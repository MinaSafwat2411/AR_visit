import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class TagItemWidget extends StatelessWidget {
  const TagItemWidget({super.key, required this.tag});
  final String tag;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.quillGrayColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Text(
          tag,
          style: const TextStyle(color: AppColors.trinidadColor),
        ),
      ),
    );
  }
}
