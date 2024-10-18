import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../core/utils/app_colors.dart';

class TagItemWidget extends StatelessWidget {
  const TagItemWidget({
    super.key,
    required this.tagsStatusList,
    required this.index,
    required this.tag,
  });

  final String tag;
  final RxList<bool> tagsStatusList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: () {
        for (int i = 0; i < tagsStatusList.length; i++) {
          tagsStatusList[i] = false;
        }
        tagsStatusList[index] = true;
      },
      child: Card(
        elevation: 0,
        color: tagsStatusList[index] ?  AppColors.trinidadColor :  AppColors.quillGrayColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            tag,
            style: TextStyle(color: tagsStatusList[index] ? AppColors.quillGrayColor : AppColors.trinidadColor),
          ),
        ),
      ),
    )
    );
  }
}
