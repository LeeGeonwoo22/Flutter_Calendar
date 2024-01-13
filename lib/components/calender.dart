import 'package:flutter/material.dart';
import 'package:flutter_callender/const/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class Calender extends StatelessWidget {
  final DateTime? selectedDay;
  final DateTime focusedDay;
  final OnDaySelected? onDaySelected;

  Calender({
    required this.selectedDay,
    required this.focusedDay,
    required this.onDaySelected,
    Key? key,
  }) : super(key: key);

  final defalutBoxDeco = BoxDecoration(
    borderRadius: BorderRadius.circular(6.0),
    color: Colors.grey[200],
  );

  final defaultTextStyle =
      TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w700);

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
        locale: 'ko_KR',
        focusedDay: focusedDay,
        firstDay: DateTime(1800),
        lastDay: DateTime(3000),
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        calendarStyle: CalendarStyle(
            isTodayHighlighted: false,
            defaultDecoration: defalutBoxDeco,
            weekendDecoration: defalutBoxDeco,
            selectedDecoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(
                  color: PRIMARY_COLOR,
                  width: 1.0,
                )),
            outsideDecoration: const BoxDecoration(shape: BoxShape.rectangle),
            defaultTextStyle: defaultTextStyle,
            weekendTextStyle: defaultTextStyle,
            selectedTextStyle: defaultTextStyle.copyWith(
              color: PRIMARY_COLOR,
            )),
        onDaySelected: onDaySelected,
        selectedDayPredicate: (DateTime date) {
          // date == selectedDay;
          if (selectedDay == null) {
            return false;
          }
          return date.year == selectedDay!.year &&
              date.month == selectedDay!.month &&
              date.day == selectedDay!.day;
        });
  }
}
