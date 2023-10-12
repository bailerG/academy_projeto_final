import 'package:flutter/material.dart';

import 'header.dart';
import 'text_descriptions.dart';

/// Represents a widget of attibutes row with
///
/// a [label] and [value].
class AtributesTable extends StatelessWidget {
  /// Constructs an instance of [AtributesTable]
  ///
  /// with the given [label] and [value].
  const AtributesTable({
    required this.label,
    required this.value,
    super.key,
  });

  /// The object of which [value] is reffered to.
  final String label;

  /// A general value of some object's parameter.
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
