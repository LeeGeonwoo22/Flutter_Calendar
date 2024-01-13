import 'package:flutter/material.dart';
import 'package:flutter_callender/components/custom_textField.dart';
import 'package:flutter_callender/widgets/pickColor.dart';
import 'package:flutter_callender/widgets/saveButton.dart';

class ScheduleBottonSheet extends StatelessWidget {
  const ScheduleBottonSheet({super.key});

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
                const Padding(
              padding: EdgeInsets.only(left: 8, right: 8, top: 16),
              child: Column(children: [
                Row(
                  children: [
                    Expanded(
                        child: CustomTextField(
                      label: '시작 시간',
                      isTime: true,
                    )),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: CustomTextField(
                      label: '마감 시간',
                      isTime: true,
                    )),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                // 내용 공간 자체는 전체로 늘어남
                Expanded(
                  child: CustomTextField(
                    label: '내용',
                    isTime: false,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                ColorPicker(),
                SizedBox(
                  height: 16,
                ),
                saveButton(),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
