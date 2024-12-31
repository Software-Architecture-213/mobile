import 'package:flutter/material.dart';

class EnumDropdownButtonFormField<T> extends StatelessWidget {
  final String labelText;
  final T value;
  final List<T> items;
  final ValueChanged<T?> onChanged;

  const EnumDropdownButtonFormField({
    Key? key,
    required this.labelText,
    required this.value,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(labelText: labelText, contentPadding: EdgeInsets.zero),
      value: value,
      items: items.map((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(item.toString().split('.').last),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}