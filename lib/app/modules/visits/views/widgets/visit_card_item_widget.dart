import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/models/login/visitsmodel.dart';

Widget VisitCardItem(VisitModel visitdata) => GestureDetector(
  onTap: () {},
  child: Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    elevation: 4,
    color:AppColors.SoftAmber,
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
                visitdata.patient['name'],  // Accessing patient name
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const Text(
                'No. of people : 4',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Text(
                'Father: ${visitdata.father['name']}',  // Accessing father name
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
                visitdata.status,
                style: TextStyle(
                  color: visitdata.status == "NEW"
                      ? AppColors.Japanese_Laurel
                      : visitdata.status == "Done"
                      ? AppColors.Japanese_Laurel
                      : AppColors.Cornflower_Blue,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Zone: ${visitdata.area['name']}',  // Accessing area name
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Text(
                'Servant: ${visitdata.servant['name']}',  // Accessing servant name
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ],
      ),
    ),
  ),
);
