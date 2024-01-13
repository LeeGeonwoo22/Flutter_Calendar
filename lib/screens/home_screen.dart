import 'package:flutter/material.dart';
import 'package:flutter_callender/components/calender.dart';
import 'package:flutter_callender/widgets/FloatingActionButton.dart';
import 'package:flutter_callender/components/today_banner.dart';
import 'package:flutter_callender/widgets/scheduleListWidgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? selectedDay;
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: renderFloatingActionButton(context),
        body: SafeArea(
          child: Column(
            children: [
              Calender(
                selectedDay: selectedDay,
                focusedDay: focusedDay,
                onDaySelected: onDaySelected,
              ),
              const SizedBox(
                height: 8,
              ),
              TodayBanner(selectedDay: DateTime.now(), scheduleCount: 4),
              const SizedBox(
                height: 8,
              ),
              const ScheduleListWidgets(),
            ],
          ),
        ));
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay;
    });
  }
}
