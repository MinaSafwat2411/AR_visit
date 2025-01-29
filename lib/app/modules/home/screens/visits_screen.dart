import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:ar_visiting_app/app/modules/home/controllers/home_controller.dart';
import 'package:ar_visiting_app/app/modules/home/screens/all_visits_screen.dart';
import 'package:ar_visiting_app/app/modules/home/screens/my_visits_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisitsScreen extends GetView<HomeController> {
  const VisitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                controller.getMyVisits();
              },
              child: Obx(
                () => Column(
                  children: [
                    Text(
                      'me'.tr,
                      style: TextStyle(
                          color: controller.me.value
                              ? AppColors.trinidadColor
                              : AppColors.gray,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: controller.me.value
                              ? AppColors.trinidadColor
                              : AppColors.white,
                          borderRadius: BorderRadius.circular(10)),
                      height: 5,
                      width: (MediaQuery.of(context).size.width / 2) - 30,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
                onTap: () {
                  controller.getAllVisits();
                },
                child: Obx(
                  () => Column(
                    children: [
                      Text(
                        'All'.tr,
                        style: TextStyle(
                            color: controller.me.value
                                ? AppColors.gray
                                : AppColors.trinidadColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: controller.me.value
                                ? AppColors.white
                                : AppColors.trinidadColor,
                            borderRadius: BorderRadius.circular(10)),
                        height: 5,
                        width: (MediaQuery.of(context).size.width / 2) - 30,
                      ),
                    ],
                  ),
                ))
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Expanded(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.visitsPageController,
            children: const [MyVisitsScreen(), AllVisitsScreen()],
          ),
        )
      ],
    );
  }
}
