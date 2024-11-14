import 'package:ar_visiting_app/app/core/utils/app_string.dart';
import 'package:ar_visiting_app/app/modules/all_visits/views/widgets/all_visit_list.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../visits/views/widgets/my_date_visit_list_widget.dart';
import '../controllers/all_visits_controller.dart';

class AllVisitsView extends GetView<AllVisitController> {


  const AllVisitsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 70,
          width: 70,
          child: FloatingActionButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(70)),
            elevation: 5,
            onPressed: () {
              Get.toNamed(Routes.ADD_NEW_VISIT);
            },
            backgroundColor: Colors.red, // Trinidad color
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: const Icon(Icons.arrow_back),
        ),
        title:  Text(
          'visitTitle'.tr,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Obx(() => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConditionalBuilder(
                    condition: !controller.isLoading.value,
                    builder: (context) {
                      return  const AllMyDateVisitListWidget();
                    },
                    fallback: (context) => const Center(
                      child: CircularProgressIndicator(
                          color: Colors.red), // Trinidad color
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
