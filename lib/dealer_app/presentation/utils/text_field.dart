import 'package:flutter/material.dart';

/// Text field widget with
///
/// [controller], [validator], [inputType], [hint],
/// [icon], [obscureText], [obscureTextButton], [readOnly],
/// [onTap], [onChanged], and [autoValidate] parameters.
class AppTextField extends StatelessWidget {
  /// Constructs an instance of [AppTextField] with
  ///
  /// the given [controller], [validator], [inputType], [hint],
  /// [icon], [obscureText], [obscureTextButton], [readOnly],
  /// [onTap], [onChanged], and [autoValidate] parameters.
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

  /// The controller of an instance of this widget.
  final TextEditingController? controller;

  /// Type of input from an instance of this widget.
  final TextInputType? inputType;

  /// A hint text displayed inside text field.
  final String? hint;

  /// Checks whether the typed text satisfies the given parameters.
  final String? Function(String?)? validator;

  /// Icon displayed at left side of widget.
  final Icon? icon;

  /// Whether the typed text is obscure or not.
  final bool? obscureText;

  /// Toggles on and off [obscureText].
  final IconButton? obscureTextButton;

  /// Whether text can't be edited or not.
  final bool? readOnly;

  /// Callback function to when the widget is tapped.
  final void Function()? onTap;

  /// Callback function to when widget is edited.
  final void Function(String)? onChanged;

  /// Validates with [validator] at any change made.
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
