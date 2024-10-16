
import 'package:flutter/material.dart';

class CustomTextFormfield extends StatelessWidget {
  CustomTextFormfield({
    super.key,
    required this.textController,
    required this.label,
    required this.validator,
    this.onTap
  });
  final TextEditingController? textController;
  final String? label;
  final FormFieldValidator validator;
  GestureTapCallback? onTap = (){};

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
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
      cursorColor: const Color.fromARGB(255, 239, 84, 0),
      validator: validator,
      onTap: onTap,
    );
  }
}
