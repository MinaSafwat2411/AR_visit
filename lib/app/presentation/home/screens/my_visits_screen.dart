import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_colors.dart';
import '../controllers/home_controller.dart';
import '../views/widgets/my_date_visit_list_widget.dart';

class MyVisitsScreen extends GetView<HomeController> {
  const MyVisitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ConditionalBuilder(
                  condition: !controller.isLoadingInternal.value,
                  builder: (context) => controller.myVisitsGrouped.isNotEmpty
                      ? const MyDateVisitListWidget()
                      : Center(child: Text('noVisits'.tr)),
                  fallback: (context) => const Center(
                      child: CircularProgressIndicator(
                    color: AppColors.trinidadColor,
                  )),
                ),
              )),
        ),
      ],
    );
  }
}
