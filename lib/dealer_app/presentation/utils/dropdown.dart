import 'package:flutter/material.dart';

class AppDropdown extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.list,
    required this.onChanged,
    required this.validator,
  });

  final List list;
  final void Function(Object?)? onChanged;
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
