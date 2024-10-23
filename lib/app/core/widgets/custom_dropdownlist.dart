import 'package:flutter/material.dart';

class CustomDropDownList extends StatelessWidget {
   CustomDropDownList({
    super.key,
    this.items,
    this.label,
    required this.onChangeValue
  });

  final List<String>? items;
  String? onChangeValue;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      items: items?.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? value) {
        onChangeValue = value!;
      },
      decoration: InputDecoration(
        labelText: label,
        floatingLabelStyle: const TextStyle(
          color: Colors.black,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 239, 84, 0),
          ),
        ),
      ),
      autofocus: false,
    );
  }
}
