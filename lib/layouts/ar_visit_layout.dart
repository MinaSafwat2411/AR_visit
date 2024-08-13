import 'package:flutter/material.dart';
import '../shared/components/components.dart';
import '../shared/styles/colors.dart';

class ArVisitLayout extends StatelessWidget {
  const ArVisitLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 70,
          width: 70,
          child: FloatingActionButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(70)),
            elevation: 5,
            onPressed: () {},
            backgroundColor: Trinidad,
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "My Visit list",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 45, // Adjust this height as needed
              child: TagsList(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyDateVisitList(),
            ),
          ],
        ),
      ),
    );
  }
}

List<String> tags = ['All', 'Me', 'New', 'assigned', 'done', 'canceled'];
List<DateTime> date = [
  DateTime.now(),
  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1),
  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2),
  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 3),
  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 4),
];

Widget MyVisitList() => ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) => VisitCardIem(), // Single card
    separatorBuilder: (context, index) => const SizedBox(
          height: 5,
        ),
    itemCount: 3 // Show 3 cards for each date
    );

Widget MyDateVisitList() => Column(
      children: List.generate(
        date.length,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(width: 20),
                  Text(
                    '${date[index].day}-${date[index].month}',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              MyVisitList() // 3 cards under each date
            ],
          ),
        ),
      ),
    );

Widget TagsList() => ListView.builder(
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: TagsItems(tags[index]),
        ),
    itemCount: tags.length);
