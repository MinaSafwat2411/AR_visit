import 'package:flutter/material.dart';

class CustomBigTextField extends StatelessWidget {
  const CustomBigTextField({
    super.key,
    this.label,

  });

  final String? label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: SizedBox(
        height: 120,
        child: TextFormField(
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
          expands: true,
          maxLines: null,
          minLines: null,
          cursorColor: const Color.fromARGB(255, 239, 84, 0),
        ),
      ),
    );
  }
}
