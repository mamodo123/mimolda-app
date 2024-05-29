import 'package:flutter/material.dart';
class ColorButton extends StatefulWidget {
  const ColorButton({
    Key? key,
  }) : super(key: key);

  @override
  State<ColorButton> createState() => _ColorButtonState();
}

class _ColorButtonState extends State<ColorButton> {
  final colorList = const [
    Color(0xFFE57A7C),
    Color(0xFF78A0FA),
    Color(0xFF55F3A1),
    Color(0xFFE4D856),
    Color(0xFFDD4446),
    Color(0xFF182027),
    Color(0xFF44565C),
    Color(0xFFE5E5E5),
    Color(0xFF6F4F39),
  ];
  Color selectedColor = const Color(0xFFffffff);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) => GestureDetector(
          onTap: () {
            setState(() {
              selectedColor = colorList[i];
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: selectedColor == colorList[i]
                ? Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 4,
                  color: Colors.white,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                color: colorList[i],
              ),
            )
                : Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                color: colorList[i],
              ),
            ),
          ),
        ),
        itemCount: colorList.length,
      ),
    );
  }
}