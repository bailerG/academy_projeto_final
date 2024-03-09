import 'package:flutter/material.dart';

import '../../../main.dart';

/// Header widget with
///
/// [header], [fontWeight], [fontSize], [padLeft],
/// [padRight], [padTop], [padBottom] parameters.
class AppHeader extends StatelessWidget {
  /// Constructs an instance of [AppHeader] with
  /// the given [header], [fontWeight], [fontSize], [padLeft],
  /// [padRight], [padTop], [padBottom] parameters.
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

  /// String displayed by the widget.
  final String header;

  /// Font thickness.
  final FontWeight? fontWeight;

  /// Font size.
  final double? fontSize;

  /// Padding placed on left of [header].
  final double? padLeft;

  /// Padding placed on right of [header].
  final double? padRight;

  /// Padding placed on top of [header].
  final double? padTop;

  /// Padding placed on bottom of [header].
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
        textScaler: const TextScaler.linear(1.3),
        style: TextStyle(
          color: accentColor,
          fontWeight: fontWeight ?? FontWeight.w700,
        ),
      ),
    );
  }
}
