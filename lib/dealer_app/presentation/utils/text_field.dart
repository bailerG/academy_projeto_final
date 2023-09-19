import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.validator,
    this.inputType,
    this.hint,
    this.icon,
    this.obscureText,
    this.obscureTextButton,
    this.readOnly,
    this.onTap,
  });

  final TextEditingController controller;
  final TextInputType? inputType;
  final String? hint;
  final String? Function(String?)? validator;
  final Icon? icon;
  final bool? obscureText;
  final IconButton? obscureTextButton;
  final bool? readOnly;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false,
      keyboardType: inputType ?? TextInputType.text,
      readOnly: readOnly ?? false,
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
      onTap: onTap,
      validator: validator,
    );
  }
}
