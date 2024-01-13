import 'package:flutter/material.dart';
import 'package:flutter_callender/const/colors.dart';
import 'package:flutter_callender/components/scheduleButtonSheet.dart';

FloatingActionButton renderFloatingActionButton(context) {
  return FloatingActionButton(
    onPressed: () {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) {
            return const ScheduleBottonSheet();
          });
    },
    backgroundColor: PRIMARY_COLOR,
    shape: const CircleBorder(),
    child: const Icon(
      Icons.add,
    ),
  );
}
