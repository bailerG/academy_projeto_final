import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.validator,
    this.inputType,
    this.hint,
    this.icon,
    this.obscureText,
    this.obscureTextButton,
    this.readOnly,
    this.onTap,
    this.onChanged,
    this.autoValidate,
  });

  final TextEditingController? controller;
  final TextInputType? inputType;
  final String? hint;
  final String? Function(String?)? validator;
  final Icon? icon;
  final bool? obscureText;
  final IconButton? obscureTextButton;
  final bool? readOnly;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final AutovalidateMode? autoValidate;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autoValidate,
      controller: controller,
      obscureText: obscureText ?? false,
      keyboardType: inputType ?? TextInputType.text,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        hintText: hint,
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
      onChanged: onChanged,
    );
  }
}
