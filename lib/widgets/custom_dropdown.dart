import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final String value;
  final List<DropdownMenuItem<String>> items;
  final void Function(String?)? onChanged;
  final String hint;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.value,
   required this.items,
    required this.onChanged,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: label),
      value: value,
      items: items,
      onChanged: onChanged,
    );
  }
}