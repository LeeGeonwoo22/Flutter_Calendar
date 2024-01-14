import 'package:flutter/material.dart';
import 'package:flutter_callender/components/custom_textField.dart';
import 'package:flutter_callender/database/drift_database.dart';
import 'package:flutter_callender/widgets/pickColor.dart';
import 'package:flutter_callender/widgets/saveButton.dart';
import 'package:get_it/get_it.dart';

class ScheduleBottonSheet extends StatefulWidget {
  const ScheduleBottonSheet({super.key});

  @override
  State<ScheduleBottonSheet> createState() => _ScheduleBottonSheetState();
}

class _ScheduleBottonSheetState extends State<ScheduleBottonSheet> {
  // Form의 상태를 가지고있는 globalKey
  final GlobalKey<FormState> formKey = GlobalKey();
  int? startTime;
  int? endTime;
  String? content;

  @override
  Widget build(BuildContext context) {
    final bottomInsert = MediaQuery.of(context).viewInsets.bottom;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
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
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // 내용 공간 자체는 전체로 늘어남
                  _Content(
                    onSaved: (String? val) {
                      content = val;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FutureBuilder<List<CategoryColor>>(
                      future: GetIt.I<LocalDatabase>().getCategoryColors(),
                      builder: (context, snapshot) {
                        // print(snapshot.data);
                        return ColorPicker(
                          colors: snapshot.hasData
                              ? snapshot.data!
                                  .map((e) => Color(
                                        int.parse('FF${e.hexCode}', radix: 16),
                                      ))
                                  .toList()
                              : [],
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
      ),
    );
  }

  void onSavePressed() {
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
    } else {
      print('에러가 있습니다.');
    }
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  const _Content({Key? key, required this.onSaved}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        isTime: false,
        onSaved: onSaved,
      ),
    );
  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;
  const _Time({Key? key, required this.onEndSaved, required this.onStartSaved})
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
        )),
        const SizedBox(
          width: 16,
        ),
        Expanded(
            child: CustomTextField(
          label: '마감 시간',
          isTime: true,
          onSaved: onEndSaved,
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