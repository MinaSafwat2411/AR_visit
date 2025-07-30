import 'package:ar_visiting_app/app/data/models/tags/tags_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../home/controllers/home_controller.dart';

class TagItemWidget extends GetView<HomeController> {
  const TagItemWidget({
    super.key,
    required this.tags,
  });

  final TagsModel tags;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
          onTap: () {
            controller.onTagsChanged(tags.value ?? 0);
          },
          child: Card(
            margin: const EdgeInsets.all(4),
            color: controller.selectedStatus.value == tags.value
                ? AppColors.white
                : AppColors.trinidadColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                textAlign: TextAlign.center,
                tags.name,
                style: TextStyle(
                  color: controller.selectedStatus.value == tags.value
                      ? AppColors.trinidadColor
                      : AppColors.white,
                ),
              ),
            ),
          )),
    );
  }
}
