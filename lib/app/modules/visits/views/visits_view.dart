import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:ar_visiting_app/app/core/widgets/custom_alert.dart';
import 'package:ar_visiting_app/app/core/widgets/custom_textformfield.dart';
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
      backgroundColor: AppColors.white,
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
              showDialog(context: context, builder: (context) => CustomDoubleAlert(
                title: 'patientCreated'.tr,
                leftButtonText: 'yes'.tr,
                leftFunction: () {
                  Get.back(closeOverlays: true);
                  Get.toNamed(Routes.ADD_NEW_VISIT);
                },
                rightButtonText: 'no'.tr,
                rightFunction: () {
                  Get.back(closeOverlays: true);
                  showDialog(context: context, builder: (context) => AlertDialog(
                    title: Text('add patient'.tr),
                    content: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6),
                        child: Form(
                          child: Column(
                            children: [
                              CustomTextFormField(textController: controller.name, label: 'name'.tr, validator: (value) {},),
                              CustomTextFormField(textController: controller.nameAr, label: 'nameAr'.tr, validator: (value) {},),
                              CustomTextFormField(textController: controller.familyId, label: 'E1C1F'.tr, validator: (value) {},),
                              CustomTextFormField(textController: controller.familyNumber, label: 'NR'.tr, validator: (value) {},),
                              CustomTextFormField(textController: controller.email, label: 'email'.tr, validator: (value) {},),
                              CustomTextFormField(textController: controller.phone, label: 'phone'.tr, validator: (value) {},)
                            ],
                          ),
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(AppColors.trinidadColor)),
                          onPressed: () {
                          controller.addPatient();
                          Get.back(closeOverlays: true);
                      }, child: Text('add'.tr,style: const TextStyle(color: AppColors.white),))
                    ],
                  ));

                },
              ),);

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
        backgroundColor: AppColors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.archive_outlined),
              onPressed: () {
                Get.toNamed(Routes.ALLVISITS);
              },
            ),
          ),
        ],
        leading: IconButton(
            onPressed: () {
              Get.toNamed(Routes.PROFILE);
            },
            icon: Image(image: AssetImage('avaRewaseIcon'.tr))),
        title: Text(
          'visitTitle'.tr,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0,right: 8.0,left: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.getMyVisits();
                        },
                        child: Obx(
                          () => Column(
                            children: [
                              Text(
                                'me'.tr,
                                style: TextStyle(
                                    color: controller.me.value
                                        ? AppColors.trinidadColor
                                        : AppColors.gray,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: controller.me.value
                                        ? AppColors.trinidadColor
                                        : AppColors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                height: 5,
                                width:
                                    (MediaQuery.of(context).size.width / 2) - 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            controller.getAllVisits();
                          },
                          child: Obx(
                            () => Column(
                              children: [
                                Text(
                                  'All'.tr,
                                  style: TextStyle(
                                      color: controller.me.value
                                          ? AppColors.gray
                                          : AppColors.trinidadColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: controller.me.value
                                          ? AppColors.white
                                          : AppColors.trinidadColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  height: 5,
                                  width: (MediaQuery.of(context).size.width / 2) -
                                      30,
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                color: AppColors.trinidadColor,
                displacement: 50,
                onRefresh: ()async{
                  controller.getVisitsData();
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.waferColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                                child: TextFormField(
                                  style: const TextStyle(
                                    color: AppColors.gray,
                                    decoration: TextDecoration.none
                                  ),
                                  onTap: () {
                                  controller.onSearchClicked();
                                  },
                                  cursorColor: AppColors.white,
                                  controller: controller.searchController,
                                  onChanged: (value) {
                                  controller.search();
                                  },
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.waferColor, // Set background color
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: AppColors.waferColor),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: AppColors.waferColor),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  focusColor: AppColors.waferColor,
                                  hintText: 'search'.tr,
                                  prefixIcon: const Icon(Icons.search,color: AppColors.trinidadColor,),
                                  ),
                                ),
                              ),
                              Obx(() => Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: ConditionalBuilder(
                                    condition: !controller.me.value && controller.onSearch.value,
                                    fallback: (context) => const SizedBox(),
                                    builder: (context) {
                                      return SizedBox(
                                          height: 45,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) =>
                                                TagItemWidget(
                                              index: index,
                                            ),
                                            itemCount: 3,
                                          ));
                                    }),
                              )),
                              Obx(() => Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: ConditionalBuilder(
                                    condition: !controller.me.value && controller.onSearch.value,
                                    fallback: (context) => const SizedBox(),
                                    builder: (context) {
                                      return SizedBox(
                                          height: 45,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) =>
                                                TagItemWidget(
                                              index: index+3,
                                            ),
                                            itemCount: 3,
                                          ));
                                    }),
                              )),
                            ],
                          ),
                        ),
                      ),
                      Obx(() => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ConditionalBuilder(
                              condition: !controller.isLoading.value,
                              builder: (context) {
                                if (controller.visits.isEmpty) {
                                  return Center(
                                    child: Text('noVisits'.tr),
                                  );
                                } else {
                                  return MyDateVisitListWidget(
                                      visits: controller.searchResults);
                                }
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
