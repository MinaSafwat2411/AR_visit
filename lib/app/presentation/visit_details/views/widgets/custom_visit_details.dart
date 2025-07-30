import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_colors.dart';

class CustomVisitDetails extends StatelessWidget {
  const CustomVisitDetails(
      {super.key,
      required this.function,
      required this.isStart,
      required this.isEnd,
      required this.text,
        required this.color
      });

  final VoidCallback function;
  final bool isStart;
  final bool isEnd;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ElevatedButton(
      onPressed: function,
      style: ButtonStyle(
        alignment: Alignment.center,
        backgroundColor: WidgetStatePropertyAll(color),
        shape: isEnd
            ? const WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topLeft: Radius.circular(20))))
            : isStart
                ? const WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20))))
                : const WidgetStatePropertyAll(RoundedRectangleBorder()),
        foregroundColor: const WidgetStatePropertyAll(AppColors.white),
      ),
      child: Text(
        text.tr,
        style: textTheme.bodySmall?.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
