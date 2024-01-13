import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_callender/const/colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  // true - 시간 || false - 내용
  final bool isTime;

  const CustomTextField({super.key, required this.label, required this.isTime});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              color: PRIMARY_COLOR, fontWeight: FontWeight.w600),
        ),
        if (isTime) renderTextField(),
        if (!isTime) Expanded(child: renderTextField()),
      ],
    );
  }

  Widget renderTextField() {
    return TextField(
      cursorColor: Colors.grey,
      // 시간이라면 1줄이 최대, 아니면 입력한 대로의 줄을 부여함
      maxLines: isTime ? 1 : null,
      // 화면 꽉 채워주기
      expands: !isTime,
      // 키보드에서 숫자가 시간입력이 맞을경우 || 아닐경우 여러줄을 입력함(내용 입력)
      keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
      // 시간이 맞다면 숫자 입력 || 아니면 아무것도 입력하지않음
      inputFormatters: isTime ? [FilteringTextInputFormatter.digitsOnly] : [],
      decoration: InputDecoration(
        // 아래 줄을 없앰
        border: InputBorder.none,
        // 필드에 색깔넣기
        filled: true,
        fillColor: Colors.grey[300],
      ),
    );
  }
}
