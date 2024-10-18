import 'package:ar_visiting_app/app/modules/visits/views/widgets/tag_item_widget.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/visits_controller.dart';
import 'widgets/my_date_visit_list_widget.dart';

class VisitsView extends StatelessWidget {
  final VisitController visitController = Get.put(VisitController());

  VisitsView({super.key});

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
        title: const Text(
          "My Visit list",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
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
                      index: index,
                      tag: visitController.tags[index],
                      tagsStatusList: visitController.tagsStatusList,
                    ),
                  ),
                  itemCount: visitController.tags.length,
                )),
            Obx(() => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConditionalBuilder(
                    condition: !visitController.isLoading.value,
                    builder: (context) {
                      // Directly access properties of VisitModel (e.g., visitDate) instead of using array indexing
                      return Obx(() => MyDateVisitListWidget(
                            visitsDates: visitController.visitsDates,
                            visitData: visitController.getFilteredVisitData(
                                visitController.tags[visitController
                                    .tagsStatusList
                                    .indexOf(true)]),
                          ));
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
