import 'package:flutter/material.dart';

class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog({
    this.title,
    this.message,
    this.buttons,
    super.key,
  });

  final List<Widget>? buttons;
  final String? title;
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
