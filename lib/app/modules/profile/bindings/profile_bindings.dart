import 'package:ar_visiting_app/app/modules/profile/controllers/profile_controllers.dart';
import 'package:get/get.dart';


class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileControllers>(
          () => ProfileControllers(),
    );
  }
}
