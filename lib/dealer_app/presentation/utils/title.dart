import 'package:flutter/material.dart';

import '../../../main.dart';

/// Title widget of a page with
///
/// [title] and [fontSize] parameters.
class AppTitle extends StatelessWidget {
  /// Constructs an instance of [AppTitle] with
  ///
  /// the given [title] and [fontSize] parameters.
  const AppTitle({
    super.key,
    required this.title,
    this.fontSize,
  });

  /// The text to be displayed as title.
  final String title;

  /// The font size of [title].
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Title(
      color: accentColor,
      child: Text(
        title,
        softWrap: true,
        textScaler: const TextScaler.linear(2.5),
        style: const TextStyle(
          color: accentColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
