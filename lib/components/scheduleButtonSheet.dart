import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_callender/components/custom_textField.dart';
import 'package:flutter_callender/database/drift_database.dart';
import 'package:flutter_callender/widgets/pickColor.dart';
import 'package:flutter_callender/widgets/saveButton.dart';
import 'package:get_it/get_it.dart';

class ScheduleBottonSheet extends StatefulWidget {
  final DateTime selectedDate;
  final int? scheduleId;

  const ScheduleBottonSheet(
      {required this.scheduleId, required this.selectedDate, super.key});

  @override
  State<ScheduleBottonSheet> createState() => _ScheduleBottonSheetState();
}

class _ScheduleBottonSheetState extends State<ScheduleBottonSheet> {
  // Form의 상태를 가지고있는 globalKey
  final GlobalKey<FormState> formKey = GlobalKey();
  int? startTime;
  int? endTime;
  String? content;
  int? selectedColorId;

  @override
  Widget build(BuildContext context) {
    final bottomInsert = MediaQuery.of(context).viewInsets.bottom;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: FutureBuilder<Schedule>(
          future: widget.scheduleId == null
              ? null
              : GetIt.I<LocalDatabase>().scheduleById(widget.scheduleId!),
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.hasError) {
              return const Center(
                child: Text('스케줄을 불러올 수 없습니다.'),
              );
            }

            // FutureBuilder 처음 실행됐고
            // 로딩중일때
            if (snapshot.connectionState != ConnectionState.none &&
                !snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // Future가 실행이 되고
            // 값이 있는데 단 한번도 startTime이 세팅되지 않았을때
            if (snapshot.hasData && startTime == null) {
              startTime = snapshot.data!.startTime;
              endTime = snapshot.data!.endTime;
              content = snapshot.data!.content;
              selectedColorId = snapshot.data!.colorId;
            }

            return SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height / 2 + bottomInsert,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(bottom: bottomInsert),
                  child:
                      // 라벨과 텍스트 필드 상하좌우
                      Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
                    child: Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(children: [
                        _Time(
                          onStartSaved: (String? val) {
                            startTime = int.parse(val!);
                          },
                          onEndSaved: (String? val) {
                            endTime = int.parse(val!);
                          },
                          startInitialValue: startTime?.toString() ?? '',
                          endInitialValue: endTime?.toString() ?? '',
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        _Content(
                          onSaved: (String? val) {
                            content = val;
                          },
                          initialValue: content ?? '',
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        // 내용 공간 자체는 전체로 늘어남
                        const SizedBox(
                          height: 16,
                        ),
                        FutureBuilder<List<CategoryColor>>(
                            future:
                                GetIt.I<LocalDatabase>().getCategoryColors(),
                            builder: (context, snapshot) {
                              // print(snapshot.data);
                              if (snapshot.hasData &&
                                  selectedColorId == null &&
                                  snapshot.data!.isNotEmpty) {
                                selectedColorId = snapshot.data![0].id;
                              }
                              return ColorPicker(
                                colors: snapshot.hasData ? snapshot.data! : [],
                                selectedColorId: selectedColorId,
                                colorIdSetter: (int id) {
                                  setState(() {
                                    selectedColorId = id;
                                  });
                                },
                              );
                            }),
                        const SizedBox(
                          height: 16,
                        ),
                        saveButton(
                          onPressed: onSavePressed,
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void onSavePressed() async {
    // formKey는 생성을 했는데
    // Form 위젯과 결합을 안했을때
    if (formKey.currentState == null) {
      return;
    }
    // null이 아닐때 Validate 를 실행
    // 에러값이 없다면 && true 라면.
    if (formKey.currentState!.validate()) {
      print('에러가 없습니다.');
      formKey.currentState!.save();
      print('---------------------------');
      print('startTime : $startTime');
      print('endTime : $endTime');
      print('content : $content');
      if (widget.scheduleId == null) {
        await GetIt.I<LocalDatabase>().createSchedule(
          SchedulesCompanion(
            date: Value(widget.selectedDate),
            startTime: Value(startTime!),
            endTime: Value(endTime!),
            content: Value(content!),
            colorId: Value(selectedColorId!),
          ),
        );
      } else {
        await GetIt.I<LocalDatabase>().updateScheduleById(
          widget.scheduleId!,
          SchedulesCompanion(
            date: Value(widget.selectedDate),
            startTime: Value(startTime!),
            endTime: Value(endTime!),
            content: Value(content!),
            colorId: Value(selectedColorId!),
          ),
        );
      }

      Navigator.of(context).pop();
    } else {
      print('에러가 있습니다.');
    }
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final String initialValue;
  const _Content({Key? key, required this.onSaved, required this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        isTime: false,
        onSaved: onSaved,
        initialValue: initialValue,
      ),
    );
  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;
  final String startInitialValue;
  final String endInitialValue;
  const _Time(
      {Key? key,
      required this.onEndSaved,
      required this.onStartSaved,
      required this.endInitialValue,
      required this.startInitialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomTextField(
          label: '시작 시간',
          isTime: true,
          onSaved: onStartSaved,
          initialValue: startInitialValue,
        )),
        const SizedBox(
          width: 16,
        ),
        Expanded(
            child: CustomTextField(
          label: '마감 시간',
          isTime: true,
          onSaved: onEndSaved,
          initialValue: endInitialValue,
        )),
      ],
    );
  }
}

// if (formKey.currentState!.validate()) {
//   // true
//   print('에러가 없습니다.');
// }else{
//   // false
//   print('에러가 있습니다.');
// }
