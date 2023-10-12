import 'package:flutter/material.dart';

/// Button with a navigator pop functionality
class AppCloseeButton extends StatelessWidget {
  /// Constructs an instance of [AppCloseeButton] widget.
  const AppCloseeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.close),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
