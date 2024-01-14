import 'package:flutter/material.dart';
import 'package:flutter_callender/const/colors.dart';

class saveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const saveButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: PRIMARY_COLOR,
            ),
            child: const Text('저장'),
          ),
        ),
      ],
    );
  }
}
