import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_colors.dart';
import '../../controllers/visits_controller.dart';

class TagItemWidget extends StatelessWidget {
  const TagItemWidget({
    super.key,
    required this.index,
    required this.tag,
    required this.visitController,
  });

  final String tag;
  final int index;
  final VisitController visitController;

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: () {
        for (int i = 0; i < visitController.tagsStatusList.length; i++) {
          visitController.tagsStatusList[i] = false;
        }
        visitController.tagsStatusList[index] = true;
        visitController.getVisitsData();
      },
      child: Card(
        elevation: 0,
        color: visitController.tagsStatusList[index] ?  AppColors.trinidadColor :  AppColors.quillGrayColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            tag,
            style: TextStyle(color: visitController.tagsStatusList[index] ? AppColors.quillGrayColor : AppColors.trinidadColor),
          ),
        ),
      ),
    ));
  }
}