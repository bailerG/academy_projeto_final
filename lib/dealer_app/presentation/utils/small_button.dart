import 'package:flutter/material.dart';

import '../../../main.dart';

/// Button widget of small size
///
/// with [text], [padding] and [onPressed] parameters.
class AppSmallButton extends StatelessWidget {
  /// Constructs an instance of [AppSmallButton] with
  ///
  /// the given [text], [padding] and [onPressed] parameters.
  const AppSmallButton({
    super.key,
    this.text,
    this.padding,
    this.onPressed,
  });

  /// Callback function when button is pressed.
  final void Function()? onPressed;

  /// Label appearing in center of button.
  final String? text;

  /// Padding placed both right and left of button.
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        maximumSize: Size(
          MediaQuery.of(context).size.width / 1.26,
          MediaQuery.of(context).size.height / 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: padding != null
            ? EdgeInsets.only(
                left: padding!,
                right: padding!,
              )
            : null,
        backgroundColor: accentColor,
        foregroundColor: Colors.white,
      ),
      child: Text(text ?? ''),
    );
  }
}
