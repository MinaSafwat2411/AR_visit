import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';
import 'constants.dart';

void navigateto(context, Widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Widget,
    ));

void navigateandend(context, Widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Widget),
      (route) => false,
    );

Widget DefualtButton({
  @required String? text,
  @required function,
  @required Color? btncolor,
  @required double? height,
}) =>
    Container(
      height: height,
      width: double.infinity,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: function,
        child: Text(
          '$text',
          style: TextStyle(color: Colors.white),
        ),
        color: btncolor,
      ),
    );

Widget VisitCardIem() => GestureDetector(
  onTap: (){},
  child: Container(
    child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 4,
          color: Wafer,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Column(
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
                const Spacer(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Done",
                      style: TextStyle(
                          color: Japanese_Laurel,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    const Text(
                      ' Zone: Abbassia',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    const Text(
                      'Servant: Mr.Micheal',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
  ),
);

Widget TagsItems(String tag) => Card(
  elevation: 0,
  color: Quill_Gray,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    child: Text(
      tag,
      style: TextStyle(color: Trinidad),
    ),
  ),
);


