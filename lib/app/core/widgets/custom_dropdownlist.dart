import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

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
    return SizedBox(
      height: 45,
      child: DropdownButtonFormField<String>(
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
          labelStyle:  const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.gray,
          ),
          floatingLabelStyle: const TextStyle(
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.alto),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color:AppColors.trinidadColor,),
          ),
        ),
        autofocus: false,
      ),
    );
  }
}
