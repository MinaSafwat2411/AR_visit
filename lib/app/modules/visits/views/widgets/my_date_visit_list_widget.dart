import 'package:flutter/material.dart';

import 'visit_card_item_widget.dart';

class MyDateVisitListWidget extends StatelessWidget {
  const MyDateVisitListWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) =>
            const VisitCardItemWidget(), // Single card
        separatorBuilder: (context, index) => const SizedBox(
              height: 5,
            ),
        itemCount: 3 // Show 3 cards for each date
        );
  }
}
