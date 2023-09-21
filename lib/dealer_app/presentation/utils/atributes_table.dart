import 'package:flutter/material.dart';

import 'header.dart';
import 'text_descriptions.dart';

class AtributesTable extends StatelessWidget {
  const AtributesTable({
    required this.label,
    required this.value,
    super.key,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppTextDescription(
          text: '$label:'.toUpperCase(),
          fontWeight: FontWeight.bold,
        ),
        AppHeader(
          header: value.toUpperCase(),
          fontWeight: FontWeight.w700,
        )
      ],
    );
  }
}
