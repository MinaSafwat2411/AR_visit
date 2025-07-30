import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../core/utils/app_colors.dart';
import '../controllers/splash_controllers.dart';

class SplashViews extends GetView<SplashController> {
  const SplashViews({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return GetBuilder<SplashController>(builder: (controller) {
      return Scaffold(
        body: Center(
            child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image(
                    image: AssetImage('imageLogo'.tr),
                    height: 130,
                    width: 130,
                  ),
                  controller.reload.value? Padding(
                    padding:const EdgeInsets.only(
                        bottom: 44, left: 40, right: 40, top: 230),
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: TextButton(
                        onPressed: () {
                          controller.onNavigate();
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                            AppColors.trinidadColor),
                          shape:
                            WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)))),
                        child: const Text(
                          'Reload',
                          style: TextStyle(color: AppColors.white),
                        ))),
                  ):
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 44, left: 40, right: 40, top: 230),
                    child: Text(
                        textAlign: TextAlign.center,
                        'copyRight'.tr,
                        style: textTheme.bodySmall),
                  )
                ],
              ),
            ],
          ),
        )),
      );
    });
  }
}
