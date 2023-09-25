import 'package:flutter/material.dart';

import '../../../main.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    required this.header,
    this.fontWeight,
    this.fontSize,
    this.padLeft,
    this.padRight,
    this.padTop,
    this.padBottom,
  });

  final String header;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? padLeft;
  final double? padRight;
  final double? padTop;
  final double? padBottom;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: padLeft ?? 0,
        right: padRight ?? 0,
        top: padTop ?? 0,
        bottom: padBottom ?? 0,
      ),
      child: Text(
        header,
        textScaleFactor: fontSize ?? 1.3,
        style: TextStyle(
          color: accentColor,
          fontWeight: fontWeight ?? FontWeight.w700,
        ),
      ),
    );
  }
}
