import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

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
            labelStyle:  const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.gray,
            ),
            floatingLabelStyle: const TextStyle(
              color: AppColors.gray,
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.alto),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.trinidadColor
              ),
            ),
          ),
          autofocus: false,
          expands: true,
          maxLines: null,
          minLines: null,
          cursorColor:AppColors.trinidadColor,
        ),
      ),
    );
  }
}
