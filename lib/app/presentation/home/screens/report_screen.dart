import 'package:ar_visiting_app/app/appcontroller/app_controller.dart';
import 'package:ar_visiting_app/app/core/widgets/custom_dropdownlist.dart';
import 'package:ar_visiting_app/app/core/widgets/custom_loading.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../../core/utils/app_colors.dart';
import '../controllers/home_controller.dart';
import '../views/widgets/visit_card_item_widget.dart';

class ReportScreen extends GetView<HomeController> {
  ReportScreen({super.key});

  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: CustomDropDownList(),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if ((scrollInfo.metrics.pixels >=
                            scrollInfo.metrics.maxScrollExtent) &&
                        !(controller.reportsLoadingMore.value) &&
                        !(controller.lastPageReports.value)) {
                      controller.getMoreDataReportsVisits();
                    }
                    return false;
                  },
                  child: ConditionalBuilder(
                    condition: !controller.isLoadingInternal.value,
                    builder: (context) => controller.visitsReport.isNotEmpty
                        ? Obx(() => ListView(
                              children: [
                                if(controller.dataMap!={})SizedBox(
                                  height: 200,
                                  width: double.infinity,
                                  child: PieChart(
                                    chartValuesOptions: const ChartValuesOptions(
                                      decimalPlaces: 0,
                                    ),
                                    legendOptions: LegendOptions(
                                      legendPosition: appController.lang.value == 'en'?LegendPosition.right: LegendPosition.left
                                    ),
                                    chartRadius: MediaQuery.of(context).size.width / 3.2,
                                    ringStrokeWidth: 10,
                                    dataMap: controller.dataMap,
                                    chartType: ChartType.ring,
                                    colorList: const [
                                      AppColors.green,
                                      AppColors.red,
                                      AppColors.orange,
                                      AppColors.blue,
                                      AppColors.deepBrown,
                                      AppColors.charcoalGray,
                                    ],
                                  ),
                                ),
                                ...controller.visitsReport
                                    .map((element) => Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: VisitCardItemWidget(
                                            visit: element,
                                          ),
                                    ))
                              ],
                            ))
                        : Center(child: Text('noVisits'.tr)),
                    fallback: (context) => const CustomLoading(),
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
