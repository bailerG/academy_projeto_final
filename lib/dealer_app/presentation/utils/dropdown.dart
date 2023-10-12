import 'package:flutter/material.dart';

/// Dropdown widget with
///
/// [list], [onChanged] and [validator] parameters.
class AppDropdown extends StatelessWidget {
  /// Constructs an instance of [AppDropdown] with
  ///
  /// the given [list], [onChanged] and [validator] parameters.
  const AppDropdown({
    super.key,
    required this.list,
    required this.onChanged,
    this.validator,
  });

  /// A list to be displayed in the Dropdown widget.
  final List list;

  /// Function called when an option is selected.
  final void Function(dynamic)? onChanged;

  /// Checks whether the typed text satisfies the given parameters.
  final String? Function(Object?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.26,
      child: DropdownButtonFormField(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        items: List.generate(
          list.length,
          (index) => DropdownMenuItem(
            value: list[index],
            child: Text(
              list[index].toString(),
            ),
          ),
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
