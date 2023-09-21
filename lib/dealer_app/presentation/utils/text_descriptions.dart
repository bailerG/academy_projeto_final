import 'package:flutter/material.dart';

class AppTextDescription extends StatelessWidget {
  const AppTextDescription({
    required this.text,
    this.fontSize,
    this.fontWeight,
    super.key,
  });

  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textScaleFactor: fontSize ?? 1.2,
      style: TextStyle(
        color: Theme.of(context).hintColor,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
    );
  }
}
