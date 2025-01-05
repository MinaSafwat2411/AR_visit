import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../visits/views/widgets/my_date_visit_list_widget.dart';
import '../controllers/all_visits_controller.dart';

class ALLVisitsViews extends GetView<ALLVisitController> {


  const ALLVisitsViews({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back),onPressed: (){
          Get.back();
        },),
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
                      return  MyDateVisitListWidget(visits: controller.visits);
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
