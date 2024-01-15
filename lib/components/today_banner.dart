import 'package:flutter/material.dart';
import 'package:flutter_callender/const/colors.dart';
import 'package:flutter_callender/model/schedule_with_model.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_callender/database/drift_database.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDay;
  final int scheduleCount;

  const TodayBanner({
    super.key,
    required this.selectedDay,
    required this.scheduleCount,
  });

  final textStyle = const TextStyle(
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            '${selectedDay.year}년 ${selectedDay.month}월 ${selectedDay.day}일',
            style: textStyle,
          ),
          StreamBuilder<List<ScheduleWithColor>>(
              stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDay),
              builder: (context, snapshot) {
                return Text('$scheduleCount개');
              })
        ]),
      ),
    );
  }
}
