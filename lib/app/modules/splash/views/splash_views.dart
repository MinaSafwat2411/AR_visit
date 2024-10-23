import 'package:ar_visiting_app/app/modules/splash/controllers/splash_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class SplashViews extends GetView<SplashController> {
  const SplashViews({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        builder: (controller) {
          return const Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Image(image: AssetImage('assets/Logo.png'),
                  height: 130,
                  width: 130,)),
              ],
            ),
          );
        }
    );
  }
}
