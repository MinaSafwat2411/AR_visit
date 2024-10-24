import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      required this.textController,
      required this.label,
      required this.validator,
      this.onTap});
  final TextEditingController? textController;
  final String? label;
  final FormFieldValidator validator;
  GestureTapCallback? onTap = () {};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: SizedBox(
        height: 45,
        child: TextFormField(
          controller: textController,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.gray,
            ),
            floatingLabelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.gray,
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.alto),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.trinidadColor,
              ),
            ),
          ),

          autofocus: false,
          cursorColor: AppColors.trinidadColor,
          validator: validator,
          onTap: onTap,
        ),
      ),
    );
  }
}
