import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/models/visits/visitsmodel.dart';
class VisitCardItemWidget extends StatelessWidget {
  const VisitCardItemWidget({
    super.key,
    required this.visitData
  });

  final VisitModel visitData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: 4,
        color:AppColors.softAmber,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    visitData.patient['name'],  // Accessing patient name
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    'No. of people : 4',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'Father: ${visitData.father['name']}',  // Accessing father name
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const SizedBox(width: 40),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    visitData.status,
                    style: TextStyle(
                      color: visitData.status == "NEW"
                          ? AppColors.japaneseLaurelColor
                          : visitData.status == "Done"
                          ? AppColors.japaneseLaurelColor
                          : AppColors.cornflowerBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Zone: ${visitData.area['name']}',  // Accessing area name
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'Servant: ${visitData.servant['name']}',  // Accessing servant name
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

