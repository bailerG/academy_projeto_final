import 'package:flutter/material.dart';

class AppCloseeButton extends StatelessWidget {
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
