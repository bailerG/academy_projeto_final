import 'package:flutter/material.dart';

import '../../../main.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({
    super.key,
    required this.title,
    this.fontSize,
  });

  final String title;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Title(
      color: accentColor,
      child: Text(
        title,
        textScaleFactor: fontSize ?? 2.5,
        style: const TextStyle(
          color: accentColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
