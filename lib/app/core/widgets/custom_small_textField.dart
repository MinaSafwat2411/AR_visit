import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

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
            labelStyle:  const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.gray,
            ),
            floatingLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.gray,
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.alto),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color:AppColors.trinidadColor,
              ),
            ),
          ),
          autofocus: false,
          cursorColor:AppColors.trinidadColor,
          validator: validator,
        onTap: function,
      ),
    );
  }
}
