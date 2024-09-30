import 'package:ar_visiting_app/app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class VisitCardItemWidget extends StatelessWidget {
  const VisitCardItemWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 4,
        color: AppColors.waferColor,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mina Safwat',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'No. of people : 4',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'Father: Fr.Mina',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  )
                ],
              ),
              Spacer(),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Done",
                    style: TextStyle(
                        color: AppColors.japaneseLaurelColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    ' Zone: Abbassia',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'Servant: Mr.Micheal',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
