import 'package:ar_visiting_app/app/core/widgets/custom_alert.dart';
import 'package:ar_visiting_app/app/modules/profile/controllers/profile_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_colors.dart';

class CustomProfileCard extends GetView<ProfileControllers> {
  const CustomProfileCard({
    super.key,
    this.image,
    this.title

  });

  final String? image;
  final String? title;


  @override
  Widget build(BuildContext context) {
    return  Row(children: [
      Padding(
        padding: const EdgeInsets.all(6.0),
        child: Image(image: AssetImage(image!),width: 20,height: 20,),
      ),
      const SizedBox(width: 17,),
      Text(
          title!,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          )
      ),
      const Spacer(),
      title == 'Language' ? GestureDetector(
        onTap: (){
          showDialog(context: context, builder: (context) =>  CustomDoubleAlert(
            title: 'choose your language',
            leftButtonText: 'English',
            rightButtonText: 'Arabic',
            leftFunction: (){
              controller.changeToEnglish();
            },
            rightFunction: (){
              controller.changeToArabic();
            },
          ));
        },
        child: const Text(
            "English",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            )
        ),
      ):const SizedBox(),
      const Icon(Icons.arrow_forward_ios,size: 20,color: AppColors.doveGray,),
    ],);
  }
}
