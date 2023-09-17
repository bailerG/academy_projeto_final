import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';

class AppTextFieldAutoComplete extends StatelessWidget {
  const AppTextFieldAutoComplete({
    required this.suggestions,
    required this.controller,
    this.validator,
    this.focusNode,
    super.key,
  });

  final List<String> suggestions;
  final TextEditingController controller;
  final String? Function(String?)? validator;
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
