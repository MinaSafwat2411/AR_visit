import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomDropDownList extends StatelessWidget {
   const CustomDropDownList({
    super.key,
    this.items,
    this.label,
    this.curruntValue,
    required this.onChangeValue
  });

  final List<String>? items;
  final ValueChanged<String?> onChangeValue;
  final String? label;
  final String? curruntValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: DropdownButtonFormField<String>(
        value: curruntValue,
        onSaved: onChangeValue,
        items: items?.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        borderRadius: BorderRadius.circular(20),
        menuMaxHeight: 300,
        onChanged: onChangeValue ,
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
