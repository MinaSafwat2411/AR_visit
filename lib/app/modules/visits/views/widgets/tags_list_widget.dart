import 'package:flutter/material.dart';

import 'tag_item_widget.dart';

class TagsListWidget extends StatelessWidget {
  const TagsListWidget({super.key, required this.tags});
  final List<String> tags;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: TagItemWidget(tag: tags[index]),
            ),
        itemCount: tags.length);
  }
}
