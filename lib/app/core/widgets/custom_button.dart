import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../presentation/register/controllers/register_controller.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.btnColor,
      this.height});
  final VoidCallback onPressed;
  final String text;
  final Color? btnColor;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: onPressed,
        color: btnColor,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
class RegisterButton extends GetView<RegisterController> {
  const RegisterButton(
      {super.key,
        required this.onPressed,
        this.btnColor,
        this.height});
  final VoidCallback onPressed;
  final Color? btnColor;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: onPressed,
        color: btnColor,
        child: Obx(() => Text(
          controller.btnText.value,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    ));
  }
}
