// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomSmallTextField extends StatelessWidget {
  const CustomSmallTextField({
    super.key,
    this.textController,
    this.label,
    this.validator,
    this.function,
    required this.isDark,
  });
  final TextEditingController? textController;
  final String? label;
  final FormFieldValidator? validator;
  final Function()? function;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      height: 50,
      child: TextFormField(
          controller: textController,
          decoration: InputDecoration(
            labelText: label,
            labelStyle:   TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isDark? AppColors.white:AppColors.boulder,
            ),
            floatingLabelStyle:  TextStyle(
              fontWeight: FontWeight.w500,
              color: isDark? AppColors.white:AppColors.boulder,
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.alto),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color:AppColors.trinidadColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.boulder),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          autofocus: false,
          cursorColor:AppColors.trinidadColor,
          validator: validator,
        keyboardType: TextInputType.number,
        onTap: function,
      ),
    );
  }
}
