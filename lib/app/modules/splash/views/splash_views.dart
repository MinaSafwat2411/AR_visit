import 'package:ar_visiting_app/app/modules/splash/controllers/splash_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_string.dart';

class SplashViews extends GetView<SplashController> {
  const SplashViews({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        builder: (controller) {
          return   Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  Column(
                    children: [
                      const Image(image: AssetImage(AppStrings.imageLogo),
                        height: 130,
                        width: 130,),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 44,left: 40,right: 40,top: 230),
                        child: Text(
                            textAlign: TextAlign.center,
                            controller.getCopyRight(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.boulder,
                              fontWeight: FontWeight.w400,
                            )
                        ),
                      )
                    ],
                  ),

                ],
              ),
            ),
          );
        }
    );
  }
}
