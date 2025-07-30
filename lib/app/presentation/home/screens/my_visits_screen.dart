import 'package:ar_visiting_app/app/core/widgets/custom_loading.dart';
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
    final textTheme = Theme.of(context).textTheme;
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
                  builder: (context) => controller.myVisitsGrouped.isNotEmpty
                      ? MyDateVisitListWidget()
                      : Center(child: Text('noVisits'.tr)),
                  fallback: (context) => const CustomLoading(),
                ),
              )),
        ),
      ],
    );
  }
}
