import 'package:flutter/material.dart';

import '../../../main.dart';

/// Clickable container displayed in gridview with
///
/// [label] and [icon] parameters.
class AppGridViewButton extends StatelessWidget {
  /// Constructs an instance of [AppGridViewButton]
  ///
  /// with the given [label] and [icon] parameters
  const AppGridViewButton({
    this.label,
    this.icon,
    super.key,
  });

  /// A label displayed in the center of widget.
  final String? label;

  /// An incon displayed just above [label].
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: accentColor,
      ),
      padding: const EdgeInsets.all(
        8.0,
      ),
      margin: const EdgeInsets.all(
        8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon ?? Icons.question_mark,
            color: Colors.white,
            size: MediaQuery.sizeOf(context).height / 20,
          ),
          Text(
            label ?? '',
            textAlign: TextAlign.center,
            textScaleFactor: 1.1,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
