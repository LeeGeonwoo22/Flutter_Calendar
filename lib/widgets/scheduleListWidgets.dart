import 'package:flutter/material.dart';
import 'package:flutter_callender/components/scheduleCard.dart';
import 'package:flutter_callender/database/drift_database.dart';
import 'package:get_it/get_it.dart';

class ScheduleListWidgets extends StatelessWidget {
  const ScheduleListWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: StreamBuilder<List<Schedule>>(
              stream: GetIt.I<LocalDatabase>().watchSchedules(),
              builder: (context, snapshot) {
                print(snapshot.data);
                return ListView.separated(
                    itemCount: 10,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: ((context, index) => ScheduleCard(
                        startTime: 8,
                        endTime: 9,
                        content: "프로그래밍 공부. $index",
                        color: Colors.red)));
              })),
    );
  }
}
