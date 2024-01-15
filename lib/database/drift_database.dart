// priviate 값은 불러올 수 없다.
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_callender/model/category.dart';
import 'package:flutter_callender/model/schedule.dart';
import 'package:flutter_callender/model/schedule_with_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
// privaite 까지 다 불러올 수 있다.
// 'g'는 특정 커맨드를 실행해서 자동으로 drift database.g.dart가 생성되도록한다.
part 'drift_database.g.dart';

@DriftDatabase(tables: [
  Schedules,
  CategoryColors,
])
// 새롭게 클래스를 만들때 앞에 '_$' 를 붙여 만들어준다
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

// 생성 쿼리 (insert)
// 쿼리이름(테이블Companion) - drift가 insert쿼리를 해주는 방식이다.
  Future<int> createSchedule(SchedulesCompanion data) =>
      into(schedules).insert(data);

  Future<int> createCategoryColor(CategoryColorsCompanion data) =>
      into(categoryColors).insert(data);

// 데이터 선택(Select)
  Future<List<CategoryColor>> getCategoryColors() =>
      select(categoryColors).get();
  // Future<List<CategoryColor>> GetCategoryColors() =>
  //   select(categoryColors):get();
  Stream<List<ScheduleWithColor>> watchSchedules(DateTime date) {
    // int number = 3;
    // final resp = number.toString();
    // final resp2 = number..toString();
    // tbl 은 테이블이다. 테이블에 날짜가 equal(같은것) 받아온다.
    // return (select(schedules)..where((tbl) => tbl.date.equals(date))).watch();
    // where 는 void 이다.
    // final query = select(schedules);
    // query.where((tbl) => tbl.date.equals(date));
    // return query.watch();
    final query = select(schedules).join([
      innerJoin(categoryColors, categoryColors.id.equalsExp(schedules.colorId))
    ]);

    query.where(schedules.date.equals(date));
    query.orderBy(
      [
        // asc -> ascending 오름차순
        // desc -> descending 내림차순
        OrderingTerm.asc(schedules.startTime),
      ],
    );

    return query.watch().map(
          (rows) => rows
              .map(
                (row) => ScheduleWithColor(
                  schedule: row.readTable(schedules),
                  categoryColor: row.readTable(categoryColors),
                ),
              )
              .toList(),
        );
  }

  @override
  int get schemaVersion => 1;
}

//Missing concrete implementation of 'getter GeneratedDatabase.schemaVersion'.
//Try implementing the missing method, or make the class abstract.
//schema 를 만들어줘야함
//DB 테이블이 변경될따마다 몇버전에서 몇버전으로 업그레이드할때를 표시. 무조건 1부터
@override
int get schemaVersion => 1;

// 어디에 연결해줘야할지 명시
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationCacheDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
