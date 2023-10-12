import 'package:flutter/material.dart';

/// Text widget intended to use as description of a page
///
/// with [text], [fontSize] and [fontWeight] parameters.
class AppTextDescription extends StatelessWidget {
  /// Constructs an instance of [AppTextDescription] with
  ///
  /// the given [text], [fontSize] and [fontWeight] parameters.
  const AppTextDescription({
    required this.text,
    this.fontSize,
    this.fontWeight,
    super.key,
  });

  /// String displayed by the widget.
  final String text;

  /// Font size of [text].
  final double? fontSize;

  /// Font thickness of [text].
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textScaleFactor: fontSize ?? 1.2,
      style: TextStyle(
        color: Theme.of(context).unselectedWidgetColor,
        fontWeight: fontWeight ?? FontWeight.w400,
      ),
    );
  }
}
