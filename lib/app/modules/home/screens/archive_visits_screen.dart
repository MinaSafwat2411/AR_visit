import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:ar_visiting_app/app/modules/home/controllers/home_controller.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/widgets/visit_card_item_widget.dart';

class ArchiveVisitsScreen extends GetView<HomeController> {
  const ArchiveVisitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() =>ConditionalBuilder(
      condition: !controller.isLoading.value,
      fallback: (context) => const Center (
        child: CircularProgressIndicator(color: AppColors.trinidadColor,),
      ),
      builder: (context) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                height: 50,
                child: Form(
                  child: TextFormField(
                style: TextStyle(
                  color: controller.isDark.value ? AppColors.white : AppColors.gray,
                  decoration: TextDecoration.none),
                cursorColor: controller.isDark.value ? AppColors.white : AppColors.black,
                controller: controller.archiveSearchController,
                onChanged: (value) {
                  controller.onSearchArchive(value);
                },
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: controller.isDark.value ? AppColors.gray : AppColors.waferColor, // Set background color
                  focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: controller.isDark.value ? AppColors.codGray : AppColors.waferColor),
                  borderRadius: BorderRadius.circular(50),
                  ),
                  enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: controller.isDark.value ? AppColors.codGray : AppColors.waferColor),
                  borderRadius: BorderRadius.circular(50),
                  ),
                  focusColor: controller.isDark.value ? AppColors.codGray : AppColors.waferColor,
                  hintText: 'search'.tr,
                  prefixIcon: Icon(
                  Icons.search,
                  color: controller.isDark.value ? AppColors.white : AppColors.trinidadColor,
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
                      builder: (context) => controller.allVisits.isNotEmpty
                          ?           ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, visitIndex) {
                          return VisitCardItemWidget(visit: controller.archiveSearchResults[visitIndex]);  // Pass the VisitModel object
                        },
                        separatorBuilder: (context, index) => const SizedBox(height: 10),
                        itemCount:controller.archiveSearchResults.length,
                      )
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
    )
    );
  }
}