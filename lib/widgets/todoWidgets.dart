import 'package:flutter/material.dart';
import 'package:flutter_callender/components/scheduleCard.dart';

class TodoWidgets extends StatelessWidget {
  const TodoWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView.separated(
              itemCount: 10,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: ((context, index) => ScheduleCard(
                  startTime: 8,
                  endTime: 9,
                  content: "프로그래밍 공부. $index",
                  color: Colors.red)))),
    );
  }
}
