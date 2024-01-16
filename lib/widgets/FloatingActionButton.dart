import 'package:flutter/material.dart';
import 'package:flutter_callender/const/colors.dart';
import 'package:flutter_callender/components/scheduleButtonSheet.dart';

FloatingActionButton renderFloatingActionButton(context, selectedDay) {
  return FloatingActionButton(
    onPressed: () {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) {
            return ScheduleBottonSheet(
              selectedDate: selectedDay,
              scheduleId: null,
            );
          });
    },
    backgroundColor: PRIMARY_COLOR,
    shape: const CircleBorder(),
    child: const Icon(
      Icons.add,
    ),
  );
}
