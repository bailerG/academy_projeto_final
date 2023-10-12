import 'package:flutter/material.dart';

import '../../../main.dart';

/// Button widget of large size with
///
/// [text] and [onPressed] parameters.
class AppLargeButton extends StatelessWidget {
  /// Constructs an instance of [AppLargeButton] with
  ///
  /// the given [text] and [onPressed] parameters.
  const AppLargeButton({
    super.key,
    this.text,
    required this.onPressed,
  });

  /// Callback function when button is pressed.
  final void Function()? onPressed;

  /// Label appearing in center of button.
  final String? text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          MediaQuery.of(context).size.width / 1.26,
          MediaQuery.of(context).size.height / 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: accentColor,
        foregroundColor: Colors.white,
      ),
      child: Text(text ?? ''),
    );
  }
}
