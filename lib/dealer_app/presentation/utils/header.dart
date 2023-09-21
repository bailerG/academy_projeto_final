import 'package:flutter/material.dart';

import '../../../main.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    required this.header,
    this.fontWeight,
    this.fontSize,
  });

  final String header;
  final FontWeight? fontWeight;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      header,
      textScaleFactor: fontSize ?? 1.3,
      style: TextStyle(
        color: accentColor,
        fontWeight: fontWeight ?? FontWeight.w700,
      ),
    );
  }
}
