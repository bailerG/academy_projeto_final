import 'package:flutter/material.dart';

import '../../../main.dart';

class AppGridViewButton extends StatelessWidget {
  const AppGridViewButton({
    this.label,
    this.icon,
    super.key,
  });

  final String? label;
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
