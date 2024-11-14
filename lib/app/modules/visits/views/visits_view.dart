import 'package:ar_visiting_app/app/core/utils/app_string.dart';
import 'package:ar_visiting_app/app/modules/visits/views/widgets/tag_item_widget.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/visits_controller.dart';
import 'widgets/my_date_visit_list_widget.dart';

class VisitsView extends GetView<VisitController> {


  const VisitsView({super.key});
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
        actions:  [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(icon: const Icon(Icons.archive_outlined),onPressed: (){
              Get.toNamed(Routes.ALLVISITS);
            },),
          ),
        ],
        leading: IconButton(onPressed: (){
          Get.toNamed(Routes.PROFILE);
        }, icon:  Image(image: AssetImage('avaRewaseIcon'.tr))),
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
            SizedBox(
                height: 45,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: TagItemWidget(
                      visitController: controller,
                      index: index,
                      tag: controller.lang=='en'?controller.tags[index]:controller.tagsAr[index],
                    ),
                  ),
                  itemCount: controller.tags.length,
                )),
            Obx(() => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConditionalBuilder(
                    condition: !controller.isLoading.value,
                    builder: (context) {
                      return  const MyDateVisitListWidget();
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
