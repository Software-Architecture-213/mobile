import 'package:flutter/material.dart';

Widget buildTextFormField({
  required String labelText,
  required IconData iconData,
  required TextEditingController controller,
  String? Function(String?)? validator,
  bool obscureText = false,
  Function(String)? onChanged,
  bool readOnly = false,
  VoidCallback? onTap,
}) {
  return TextFormField(
    expands: false,
    validator: validator,
    controller: controller,
    onChanged: onChanged,
    obscureText: obscureText,
    onTap: onTap,
    readOnly: readOnly,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.zero,
        labelText: labelText,
        prefixIcon: Icon(
          iconData,
          size: 24,
          color: Colors.orangeAccent,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14))),
  );
}
