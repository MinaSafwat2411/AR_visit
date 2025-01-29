import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../home/controllers/home_controller.dart';

class TagItemWidget extends GetView<HomeController> {
  const TagItemWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Obx(()=> GestureDetector(
      onTap: () {
        controller.onTagsChanged(index);
      },
      child: Card(
        elevation: 2,
        color: controller.tags[index].isSelected.value ?  AppColors.trinidadColor :  AppColors.lightGray,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            controller.lang.value== 'en'? controller.tags[index].name:controller.tags[index].nameAr,
            style: TextStyle(color: controller.tags[index].isSelected.value ? AppColors.lightGray : AppColors.trinidadColor),
          ),
        ),
      )
      ),
    );
  }
}