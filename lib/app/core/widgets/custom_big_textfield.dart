import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomBigTextField extends StatelessWidget {
  CustomBigTextField({
    super.key,
    this.label,
    required this.controller,
    required this.isDark,
    required this.observe,
    this.validator,
    this.onChanged,
    this.icon,
    this.keyboardType,
    this.enable = true,
    this.suffix,
    this.border,
    this.function,
  });

  final String? label;
  final TextEditingController controller;
  final bool isDark;
  final String? Function(String?)? validator;
  final bool observe;
  final void Function(String)? onChanged;
  final Widget? icon;
  final TextInputType? keyboardType;
  final bool enable;
  final Widget? suffix;
  final double? border;
  Function()? function = () {};


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: TextFormField(
        onTap: function,
        enabled: enable,
        keyboardType: keyboardType,
        onChanged: onChanged,
        style:  TextStyle(
          color: isDark ? AppColors.white:AppColors.boulder,
        ),
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: suffix,
          hintStyle:  TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDark ? AppColors.white:AppColors.boulder,
          ),
          hintText: label,
          suffix: icon,
          labelStyle:  TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDark ? AppColors.white:AppColors.boulder,
          ),
          floatingLabelStyle: const TextStyle(
            color: AppColors.white,
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.trinidadColor),
            borderRadius: BorderRadius.circular(border??8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.trinidadColor),
            borderRadius: BorderRadius.circular(border??8),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.trinidadColor),
            borderRadius: BorderRadius.circular(border??8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.boulder),
            borderRadius: BorderRadius.circular(border??8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.red),
            borderRadius: BorderRadius.circular(border??8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.red),
            borderRadius: BorderRadius.circular(border??8),
          ),
          counterStyle: const TextStyle(
              color: AppColors.white
          ),
          filled: false,
        ),
        autofocus: false,
        maxLines: 1,
        cursorColor: isDark ? AppColors.white:AppColors.trinidadColor,
        validator: validator,
        obscureText: observe ? true : false,
      ),
    );
  }
}
