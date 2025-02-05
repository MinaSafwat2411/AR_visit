import 'package:ar_visiting_app/app/core/widgets/custom_dropdownlist.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../controllers/home_controller.dart';
import '../views/widgets/visit_card_item_widget.dart';

class ReportScreen extends GetView<HomeController> {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: CustomDropDownList(onChangeValue: (value) {
            controller.onUserSelected(value?? '');
          },
            items: controller.userNames,
            label: 'select user',
          ),
        ),
        const SizedBox(height: 20,),
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
                  return VisitCardItemWidget(visit: controller.visitsReport[visitIndex]);  // Pass the VisitModel object
                },
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemCount:controller.visitsReport.length,
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
}
