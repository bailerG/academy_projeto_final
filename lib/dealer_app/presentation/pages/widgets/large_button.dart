import 'package:flutter/material.dart';
import '/main.dart';

class LargeButton extends StatelessWidget {
  const LargeButton({required this.text, super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
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
      child: Text(text),
    );
  }
}
