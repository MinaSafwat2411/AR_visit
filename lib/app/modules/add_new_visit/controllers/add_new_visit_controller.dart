import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/firebase/AddVisitFirebase.dart';
import '../../../core/models/addvisitmodel.dart';
import '../../../routes/app_pages.dart';

class AddNewVisitController extends GetxController {
  String addressType = '';
  String areaName = '';
  List<String> areaNames = ['Daher'];
  Map<String, String> areasData = {'Daher':''};
  var isLoading = false.obs;

  final formKey = GlobalKey<FormState>();

  TextEditingController dateController = TextEditingController();
  TextEditingController fromTimeController = TextEditingController();
  TextEditingController toTimeController = TextEditingController();
  TextEditingController patientNameController = TextEditingController();
  TextEditingController patientLocationController = TextEditingController();
  TextEditingController patientAddressController = TextEditingController();
  TextEditingController assistantNameController = TextEditingController();
  TextEditingController patientPhoneController = TextEditingController();
  TextEditingController assistantPhoneController = TextEditingController();
  TextEditingController patientFamIDController = TextEditingController();
  TextEditingController patientIDNumberController = TextEditingController();

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

  Future<void> selectedFromTime(BuildContext context) async {
    TimeOfDay? fromTimePicked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.dial,
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
    if (fromTimePicked != null) {
        fromTimeController.text = fromTimePicked.format(context).toString();
    }
  }

  Future<void> selectedToTime(BuildContext context) async {
    TimeOfDay? toTimePicked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.dial,
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
    if (toTimePicked != null) {
        toTimeController.text = toTimePicked.format(context).toString();
    }
  }

  void getAreasNames() async {
    // areasData = await areaRetriever.retrieveAreas();
    // for (String areaName in areasData.keys) {
    //   setState(() {
    //     areaNames.add(areaName);
    //   });
    // }
  }

  void addVisit() async{
    isLoading(true);
    try{
      Visit newVisit = Visit(
        area: {
          'name': areaName,
          'visitId': areasData[areaName]
        },
        father: {
          'id': '',
          'isFather': true,
          'name': '',
          'phoneNumber': ''
        },
        patient: {
          'name': patientNameController.text,
          'phoneNumber': patientPhoneController.text,
          'PatientFamilyId': patientFamIDController.text,
          'PatientIDNumber': patientIDNumberController.text,
        },
        servant: {
          'id': '',
          'isFather': false,
          'name': '',
          'phoneNumber': ''
        },
        status: 'NEW',
        visitDate: dateController.text,
        visitTimeRangeFrom: fromTimeController.text,
        visitTimeRangeTo: toTimeController.text,
      );
      visitSubmission.submitVisit(newVisit);
      Get.offNamed(Routes.VISITS);
    }catch (e){
      Get.snackbar("Error", e.toString());
    }finally{
      isLoading(false);
    }
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
    super.onClose();
    dateController.dispose();
    fromTimeController.dispose();
    toTimeController.dispose();
    patientNameController.dispose();
    patientFamIDController.dispose();
    patientIDNumberController.dispose();
    patientPhoneController.dispose();
    patientLocationController.dispose();
    dateController.dispose();
    patientAddressController.dispose();
    assistantNameController.dispose();
    assistantPhoneController.dispose();
    super.onClose();
  }
}
