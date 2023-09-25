import 'package:flutter/material.dart';

import '../../../main.dart';

class AppSmallButton extends StatelessWidget {
  const AppSmallButton({
    super.key,
    this.text,
    this.padding,
    required this.onPressed,
  });

  final void Function()? onPressed;
  final String? text;
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
