import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_callender/const/colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  // true - 시간 || false - 내용
  final bool isTime;
  final FormFieldSetter<String> onSaved;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.isTime,
    required this.onSaved,
  }) : super(key: key);

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
    return TextFormField(
      onSaved: onSaved,
      // null이 return 되면 에러가 없다.
      // 무조건 모든 어떤 텍스트 필드라도 validator 함수를 거쳐간다.
      // 에러가 있으면 에러를 String 값으로 리턴해준다.
      validator: (String? val) {
        if (val == null || val.isEmpty) {
          return '값을 입력해주세요';
        }

        if (isTime) {
          // value 값을 int로 변환
          int time = int.parse(val);

          if (time < 0) {
            return '0 이상의 숫자를 입력해주세요';
          }

          if (time > 24) {
            return '24 이하의 숫자를 입력해주세요';
          }
        } else {
          if (val.length > 500) {
            return '500자 이하의 글자를 입력해주세요.';
          }
        }

        return null;
      },
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
