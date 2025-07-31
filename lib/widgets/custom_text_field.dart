import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final String? Function(String?) validator;
  final void Function(String?)? onSaved;
  final TextInputType keyboardType;

  const CustomTextField({super.key, required this.label, required this.hint, required this.validator, this.onSaved, required this.keyboardType});
  


  @override
  Widget build(BuildContext context) {
        return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
      ),
      validator: validator,
      onSaved: onSaved,
      keyboardType: keyboardType,
    );

    
  }
}