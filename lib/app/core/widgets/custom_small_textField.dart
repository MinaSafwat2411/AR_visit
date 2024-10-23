import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSmallTextField extends StatelessWidget {
  const CustomSmallTextField({
    super.key,
    this.textController,
    this.label,
    this.validator,
    this.function

  });
  final TextEditingController? textController;
  final String? label;
  final FormFieldValidator? validator;
  final Function()? function;

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      height: 45,
      child: TextFormField(
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
          cursorColor:
          const Color.fromARGB(255, 239, 84, 0),
          validator: validator,
        onTap: function,
      ),
    );
  }
}
