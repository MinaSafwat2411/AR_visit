import 'package:ar_visiting_app/app/modules/my_order_visits/controllers/my_order_visits_controller.dart';
import 'package:get/get.dart';


class MyOrderBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyOrderVisitsController>(
          () => MyOrderVisitsController(),
    );
  }
}