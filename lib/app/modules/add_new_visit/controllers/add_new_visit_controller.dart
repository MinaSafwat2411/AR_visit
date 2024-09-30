import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewVisitController extends GetxController {
  String addressType = 'Home';
  String areaName = '';
  List<String> areaNames = [];
  Map<String, String> areasData = {};

  final formKey = GlobalKey<FormState>();

  TextEditingController dateController = TextEditingController();
  TextEditingController fromTimeController = TextEditingController();
  TextEditingController toTimeController = TextEditingController();
  TextEditingController patientNameController = TextEditingController();
  TextEditingController patientPhoneController = TextEditingController();
  TextEditingController patientFamIDController = TextEditingController();
  TextEditingController patientIDNumeberController = TextEditingController();

  Future<void> selectDate(BuildContext context) async {
    DateTime? datePicked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color.fromARGB(
                      255, 239, 84, 0), //header and selced day background color
                  onPrimary: Colors.white, // titles and
                  onSurface: Colors.black, // Month days , years
                ),
              ),
              child: child!);
        });
    if (datePicked != null) {
      // setState(() {
      dateController.text = datePicked.toString().split(" ")[0];
      // });
    }
  }

  Future<void> selectedFromTime() async {
    // TimeOfDay? fromTimePicked = await showTimePicker(
    //     context: context,
    //     initialTime: TimeOfDay.now(),
    //     initialEntryMode: TimePickerEntryMode.dial,
    //     builder: (context, child) {
    //       return Theme(
    //           data: Theme.of(context).copyWith(
    //             colorScheme: const ColorScheme.light(
    //               primary: Color.fromARGB(
    //                   255, 239, 84, 0), //header and selced day background color
    //               onPrimary: Colors.white, // titles and
    //               onSurface: Colors.black, // Month days , years
    //             ),
    //           ),
    //           child: child!);
    //     });
    // if (fromTimePicked != null) {
    //   setState(() {
    //     fromTimeController.text = fromTimePicked.format(context).toString();
    //   });
    // }
  }

  Future<void> selectedToTime() async {
    // TimeOfDay? toTimePicked = await showTimePicker(
    //     context: context,
    //     initialTime: TimeOfDay.now(),
    //     initialEntryMode: TimePickerEntryMode.dial,
    //     builder: (context, child) {
    //       return Theme(
    //           data: Theme.of(context).copyWith(
    //             colorScheme: const ColorScheme.light(
    //               primary: Color.fromARGB(
    //                   255, 239, 84, 0), //header and selced day background color
    //               onPrimary: Colors.white, // titles and
    //               onSurface: Colors.black, // Month days , years
    //             ),
    //           ),
    //           child: child!);
    //     });
    // if (toTimePicked != null) {
    //   setState(() {
    //     toTimeController.text = toTimePicked.format(context).toString();
    //   });
    // }
  }

  void getAreasNames() async {
    // areasData = await areaRetriever.retrieveAreas();
    // for (String areaName in areasData.keys) {
    //   setState(() {
    //     areaNames.add(areaName);
    //   });
    // }
  }

  @override
  void onInit() {
    getAreasNames();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    dateController.dispose();
    fromTimeController.dispose();
    toTimeController.dispose();
    patientNameController.dispose();
    patientFamIDController.dispose();
    patientIDNumeberController.dispose();
    patientPhoneController.dispose();
    super.onClose();
  }
}
