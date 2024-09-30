import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:ar_visiting_app/app/modules/visits/views/widgets/tags_list_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/visits_controller.dart';
import 'widgets/my_date_visit_list_widget.dart';

class VisitsView extends GetView<VisitsController> {
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
            backgroundColor: AppColors.trinidadColor,
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
              height: 45, // Adjust this height as needed
              child: TagsListWidget(
                tags: controller.tags,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: MyDateVisitListWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
