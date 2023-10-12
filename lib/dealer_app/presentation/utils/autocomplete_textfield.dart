import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';

/// A Text Field widget that shows a list of
///
/// given [suggestions], with [controller],
/// [validator], and [focusNode] parameters.
class AppTextFieldAutoComplete extends StatelessWidget {
  /// Constructs an instance of [AppTextFieldAutoComplete]
  ///
  /// with the given [suggestions], [controller], [validator],
  /// [focusNode] parameters.
  const AppTextFieldAutoComplete({
    required this.suggestions,
    required this.controller,
    this.validator,
    this.focusNode,
    super.key,
  });

  /// List of string appearing below text field as autocomplete suggestions.
  final List<String> suggestions;

  /// Controls the text typed in widget
  final TextEditingController controller;

  /// Checks whether the typed text satisfies the given parameters.
  final String? Function(String?)? validator;

  /// Checks whether widget is being used or not.
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return EasyAutocomplete(
      suggestions: suggestions,
      validator: validator,
      focusNode: focusNode,
      onChanged: (value) => controller,
      controller: controller,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
    );
  }
}
