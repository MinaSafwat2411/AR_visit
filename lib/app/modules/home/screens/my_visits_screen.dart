import 'package:ar_visiting_app/app/modules/home/controllers/home_controller.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_colors.dart';
import '../views/widgets/my_date_visit_list_widget.dart';

class MyVisitsScreen extends GetView<HomeController> {
  const MyVisitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SizedBox(
            height: 50,
            child: Form(
              child: TextFormField(
                style: const TextStyle(
                    color: AppColors.gray, decoration: TextDecoration.none),
                cursorColor: AppColors.white,
                controller: controller.searchController,
                onChanged: (value) {
                  controller.onSearchMe(value);
                },
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.waferColor, // Set background color
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.waferColor),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.waferColor),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  focusColor: AppColors.waferColor,
                  hintText: 'search'.tr,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.trinidadColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ConditionalBuilder(
                  condition: !controller.isLoadingInternal.value,
                  builder: (context) => controller.meVisits.isNotEmpty
                      ? MyDateVisitListWidget(
                          visits: controller.meSearchResults)
                      : Center(child: Text('noVisits'.tr)),
                  fallback: (context) => const Center(
                      child: CircularProgressIndicator(
                    color: AppColors.trinidadColor,
                  )),
                ),
              )),
        )
      ],
    );
  }
}
