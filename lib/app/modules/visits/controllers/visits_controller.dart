import 'package:get/get.dart';

class VisitsController extends GetxController {
  List<String> tags = ['All', 'Me', 'New', 'assigned', 'done', 'canceled'];
  List<DateTime> date = [
    DateTime.now(),
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1),
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2),
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 3),
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 4),
  ];
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
