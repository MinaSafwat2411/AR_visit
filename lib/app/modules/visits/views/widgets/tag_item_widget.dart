import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../core/utils/app_colors.dart';

Widget TagsItems(String tag, RxList<bool> tagsStatusList, int index) => Obx(() => GestureDetector(
  onTap: () {
    for (int i = 0; i < tagsStatusList.length; i++) {
      tagsStatusList[i] = false;
    }
    tagsStatusList[index] = true;
  },
  child: Card(
    elevation: 0,
    color: tagsStatusList[index] ?  AppColors.Trinidad :  AppColors.Quill_Gray,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Text(
        tag,
        style: TextStyle(color: tagsStatusList[index] ? AppColors.Quill_Gray : AppColors.Trinidad),
      ),
    ),
  ),
)
);
