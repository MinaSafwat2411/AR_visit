import 'package:ar_visiting_app/app/modules/home/controllers/home_controller.dart';
import 'package:ar_visiting_app/app/modules/home/views/widgets/tag_item_widget.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_colors.dart';
import '../views/widgets/my_date_visit_list_widget.dart';

class AllVisitsScreen extends GetView<HomeController> {
  const AllVisitsScreen({super.key});

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
                controller: controller.allSearchController,
                onChanged: (value) {
                  controller.onSearchAll(value);
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
        Padding(
              padding: const EdgeInsets.only(left: 12,right: 12),
              child: SizedBox(
                  height: 45,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => TagItemWidget(
                      index: index,
                    ),
                    itemCount: controller.tags.length,
                  )),
            ),
        Expanded(
          child: Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ConditionalBuilder(
                  condition: !controller.isLoadingInternal.value,
                  builder: (context) => controller.allVisits.isNotEmpty
                      ? MyDateVisitListWidget(
                          visits: controller.allSearchResults)
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
