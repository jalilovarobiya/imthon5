import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon? prefixicon;
  final String? Function(String?)? validator;
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.prefixicon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        prefixIcon: prefixicon,
      ),
      validator: validator,
    );
  }
}
