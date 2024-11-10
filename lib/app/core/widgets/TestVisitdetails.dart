import 'package:flutter/material.dart';

class TestVisitDetails extends StatelessWidget {
  const TestVisitDetails({
    super.key,
    this.value,
    this.title
  });

  final String? title;
  final String? value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${title!} : ',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
        Expanded(child: Text(value!,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w300),overflow: TextOverflow.ellipsis,))
      ],
    );
  }
}
