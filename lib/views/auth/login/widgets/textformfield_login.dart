import 'package:flutter/material.dart';

Widget buildTextFormField(
    {required String hintText,
    required IconData iconData,
    Function(String)? onChanged,
    Widget? suffixIcon,
    bool obscureText = false,
    required TextEditingController controller,
    String? Function(String?)? validator}) {
  return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(
            color: Colors.grey[600],
            iconData,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey[400]),
              ),
              onChanged: onChanged,
              obscureText: obscureText,
              controller: controller,
              validator: validator,
            ),
          ),
          if (suffixIcon != null) suffixIcon
        ],
      ));
}
