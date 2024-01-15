import 'package:flutter/material.dart';
import 'package:flutter_callender/components/scheduleCard.dart';
import 'package:flutter_callender/database/drift_database.dart';
import 'package:get_it/get_it.dart';

class ScheduleListWidgets extends StatelessWidget {
  final DateTime selectedDate;
  const ScheduleListWidgets({
    super.key,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: StreamBuilder<List<Schedule>>(
              stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
              builder: (context, snapshot) {
                print(snapshot.hasData);
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData && snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('스케쥴이 없습니다.'),
                  );
                }
                // print('-----original data----');
                // print(snapshot.data);

                // List<Schedule> schedules = [];

                // if (snapshot.hasData) {
                //   schedules = snapshot.data!
                //       .where((ele) => ele.date.toUtc() == selectedDate)
                //       .toList();
                //   print('-----filtered data ----');
                //   print(selectedDate);
                //   print(schedules);
                // }
                return ListView.separated(
                    itemCount: snapshot.data!.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: ((context, index) {
                      final schedule = snapshot.data![index];
                      return ScheduleCard(
                          startTime: schedule.startTime,
                          endTime: schedule.endTime,
                          content: schedule.content,
                          color: Colors.red);
                    }));
              })),
    );
  }
}
