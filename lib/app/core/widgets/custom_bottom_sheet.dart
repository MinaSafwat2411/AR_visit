import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:ar_visiting_app/app/modules/visit_details/controllers/visit_details_controllers.dart';
import 'package:ar_visiting_app/app/modules/visit_details/di/bottom_sheet_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomSheet extends GetView<VisitDetailsControllers> {
  final String title;
  final List<String> items;
  final BottomSheetType bottomSheetType;

  const CustomBottomSheet({
    Key? key,
    required this.title,
    required this.items,
    required this.bottomSheetType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Container(
            width: 50,
            height: 10,
            decoration: BoxDecoration(
              color: AppColors.gray20,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 1.25,
                    letterSpacing: -0.45,
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.back(closeOverlays: true),
                  child: Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: AppColors.gray20,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Text('x'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              itemCount: items.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GestureDetector(
                  onTap: (){
                    if(bottomSheetType==BottomSheetType.FATHER){
                      controller.onFatherSelected(index);
                      Get.back(closeOverlays: true);
                    }else{
                      controller.onServantSelected(index);
                      Get.back(closeOverlays: true);
                    }
                  },
                  child: SizedBox(
                    height: 72,
                    child: Card(
                      elevation: 2,
                      color: AppColors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Text(
                          items[index],
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 5),
            ),
          ),
        ],
      ),
    );
  }
}
