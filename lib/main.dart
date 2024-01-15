import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callender/screens/home_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_callender/database/drift_database.dart';

const DEFAULT_COLORS = [
  // 빨
  'F44336',
  // 주
  'FF9800',
  // 노
  'FFEB38',
  // 초
  'FCAF50',
  // 파
  '2196F3',
  // 남
  '3F51B5',
  // 보
  '9C27B0'
];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  // 아래의 언더스코어 클래스를 쓸 수 있게끔 부른다.
  // class LocalDatabase extends _$LocalDatabase {
  // LocalDatabase() : super(_openConnection());
  final database = LocalDatabase();

  GetIt.I.registerSingleton<LocalDatabase>(database);

  final colors = await database.getCategoryColors();

  if (colors.isEmpty) {
    print('실행!!');
    for (String hexCode in DEFAULT_COLORS) {
      await database.createCategoryColor(CategoryColorsCompanion(
        hexCode: Value(hexCode),
      ));
    }
  }

  print(await database.getCategoryColors());
  // print('------GET COLORS-------');
  // print(await database.getCategoryColors());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.notoSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
