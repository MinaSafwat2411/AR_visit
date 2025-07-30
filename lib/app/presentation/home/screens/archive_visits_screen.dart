import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:ar_visiting_app/app/core/widgets/custom_loading.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../views/widgets/visit_card_item_widget.dart';

class ArchiveVisitsScreen extends GetView<HomeController> {
  const ArchiveVisitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Obx(() => ConditionalBuilder(
          condition: !controller.isLoading.value,
          fallback: (context) => const CustomLoading(),
          builder: (context) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SearchBar(
                    controller: controller.searchController,
                    hintText: 'search'.tr,
                    onChanged:(value)=> controller.onSearch(value),
                    leading: const Icon(Icons.search, color: AppColors.trinidadColor),
                    backgroundColor: const WidgetStatePropertyAll(AppColors.softAmber),
                    textStyle: WidgetStatePropertyAll(textTheme.bodyLarge),
                  ),
                ),
                Expanded(
                  child: Obx(() => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ConditionalBuilder(
                          condition: !controller.isLoadingInternal.value,
                          builder: (context) => controller
                                  .archiveVisitsFiltered.isNotEmpty
                              ? NotificationListener<ScrollNotification>(
                                  onNotification:
                                      (ScrollNotification scrollInfo) {
                                    if (scrollInfo.metrics.pixels >=
                                            scrollInfo
                                                .metrics.maxScrollExtent &&
                                        !controller.archiveLoadingMore.value && !controller.lastPageArchive.value) {
                                      controller.getMoreDataArchiveVisits();
                                    }
                                    return false;
                                  },
                                  child: ListView.separated(
                                    controller: controller
                                        .archiveVisitsScrollController,
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, visitIndex) {
                                      return VisitCardItemWidget(
                                          visit:
                                              controller.archiveVisitsFiltered[
                                                  visitIndex]);
                                    },
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 10),
                                    itemCount:
                                        controller.archiveVisitsFiltered.length,
                                  ),
                                )
                              : Center(child: Text('noVisits'.tr)),
                          fallback: (context) => const CustomLoading(),
                        ),
                      )),
                ),
              ],
            );
          },
        ));
  }
}
