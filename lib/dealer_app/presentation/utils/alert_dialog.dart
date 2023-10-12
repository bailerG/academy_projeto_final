import 'package:flutter/material.dart';

/// Widget that builds an alert dialog with
///
/// [title], [message], and [buttons].
class AppAlertDialog extends StatelessWidget {
  /// Constructs an instance of [AppAlertDialog]
  ///
  /// with the given [title], [message] and [buttons].
  const AppAlertDialog({
    this.title,
    this.message,
    this.buttons,
    super.key,
  });

  /// A list of button widgets displayed as actions
  final List<Widget>? buttons;

  /// Title of an alert dialog
  final String? title;

  /// The message displayed below title.
  final String? message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null ? Text(title!) : null,
      content: message != null ? Text(message!) : null,
      actions: buttons,
    );
  }
}
