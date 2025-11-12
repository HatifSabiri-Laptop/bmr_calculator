import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final String unit;
  final TextEditingController controller;

  const InputField({
    super.key,
    required this.label,
    required this.controller,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        suffixText: unit,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
