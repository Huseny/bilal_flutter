import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.onSaved,
      required this.labelText,
      required this.errorMsg,
      this.canEmpty = false});

  final Function(String?)? onSaved;
  final String labelText;
  final String errorMsg;
  final bool canEmpty;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: const OutlineInputBorder(),
      ),
      onSaved: widget.onSaved,
      validator: (value) {
        if ((value == null || value == "") && !widget.canEmpty) {
          return widget.errorMsg;
        }
        return null;
      },
    );
  }
}
