import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDoubleAlert extends StatelessWidget {
  const CustomDoubleAlert({
    super.key,
    this.title,
    this.leftFunction,
    this.rightFunction,
    this.rightButtonText,
    this.leftButtonText
  });

  final String? title;
  final VoidCallback? rightFunction;
  final String? rightButtonText;
  final VoidCallback? leftFunction;
  final String? leftButtonText;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          actionsAlignment: MainAxisAlignment.spaceBetween,
          title: Text(
              title!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              )),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 45,vertical: 15),
          actions: <Widget>[
            ElevatedButton(
              style:  ElevatedButton.styleFrom(
                shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Makes it a rectangle
                ),
                  backgroundColor: AppColors.trinidadColor
              ),
              onPressed:leftFunction,
              child: Text(
                leftButtonText!,
                style: const TextStyle(
                  color: AppColors.white
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
                onPressed: rightFunction,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: AppColors.black,width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: AppColors.white
                ),
                child: Text(
                    rightButtonText!,
                    style: const TextStyle(
                      color: AppColors.black
                  ),
                )
            ),
          ],
        );
  }
}
