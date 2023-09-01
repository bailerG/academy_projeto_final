import 'package:flutter/material.dart';

import '../../../main.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    required this.header,
    this.fontWeight,
  });

  final String header;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      header,
      textScaleFactor: 1.3,
      style: TextStyle(
        color: accentColor,
        fontWeight: fontWeight ?? FontWeight.w700,
      ),
    );
  }
}
