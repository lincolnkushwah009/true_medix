import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String textName;
  final double? fontSize;
  final Color? fontColor;
  final FontWeight? fontWeight;

  const CustomText(
      {super.key,
      this.fontColor,
      this.fontSize,
      this.fontWeight,
      required this.textName});

  @override
  Widget build(BuildContext context) {
    return Text(
      textName,
      style: TextStyle(
          color: fontColor, fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
