import 'package:flutter/material.dart';
import 'package:flutter_callender/database/drift_database.dart';

typedef ColorIdSetter = void Function(int id);

class ColorPicker extends StatelessWidget {
  final List<CategoryColor> colors;
  final int? selectedColorId;
  final ColorIdSetter colorIdSetter;

  const ColorPicker(
      {super.key,
      required this.colors,
      required this.selectedColorId,
      required this.colorIdSetter});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // 좌우 간격
      spacing: 8,
      // 위아래 간격
      runSpacing: 10,
      // children 의 []을 삭제해주고 넣어준다.
      children: colors
          .map(
            (e) => GestureDetector(
              onTap: () {
                colorIdSetter(e.id);
              },
              child: renderColor(
                e,
                selectedColorId == e.id,
              ),
            ),
          )
          .toList()

      // renderColor(Colors.red),
      // renderColor(Colors.orange),
      // renderColor(Colors.yellow),
      // renderColor(Colors.green),
      // renderColor(Colors.blue),
      // renderColor(Colors.indigo),
      // renderColor(Colors.purple),
      ,
    );
  }
}

Widget renderColor(CategoryColor color, bool isSelected) {
  return Container(
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(int.parse('FF${color.hexCode}', radix: 16)),
        border: isSelected
            ? Border.all(
                color: Colors.black,
                width: 4,
              )
            : null),
    width: 32,
    height: 32,
  );
}
