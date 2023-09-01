import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {super.key,
      required this.controller,
      required this.validator,
      this.inputType,
      this.hint,
      this.icon,
      this.obscureText,
      this.obscureTextButton});

  final TextEditingController controller;
  final TextInputType? inputType;
  final String? hint;
  final String? Function(String?)? validator;
  final Icon? icon;
  final bool? obscureText;
  final IconButton? obscureTextButton;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false,
      keyboardType: inputType ?? TextInputType.text,
      decoration: InputDecoration(
        hintText: hint ?? 'Please type here',
        prefixIcon: icon,
        suffixIcon: obscureTextButton,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
      validator: validator,
    );
  }
}
