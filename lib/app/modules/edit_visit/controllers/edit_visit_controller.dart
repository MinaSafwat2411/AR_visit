import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/firebase/AddVisitFirebase.dart';
import '../../../core/firebase/GetAreaFirebase.dart';
import '../../../core/firebase/GetVisitDetailsFirebase.dart';
import '../../../core/models/area/areamodel.dart';
import '../../../core/models/visits/addvisitmodel.dart';
import '../../../core/models/visits/visitsmodel.dart';
import '../../../routes/app_pages.dart';

class EditVisitController extends GetxController {
  var areaName = ''.obs;
  var areaNames = <String>[].obs;
  var areaData =<Area>[].obs;
  var isLoading = false.obs;
  String id =Get.arguments;
  var visitData=VisitModel(
      id: '',
      status: '',
      area: {},
      father: {},
      patient: {},
      assistant: {},
      servant: {},
      visitDate: '',
      visitTimeRangeFrom: '',
      visitTimeRangeTo: '',
      numberOfPeople: '',
      address: {},
      googleLink: '',
      note: ''
  ).obs;
  var addressType = ''.obs;

  Future<void> getVisitDetails() async {
    isLoading.value = true;
    try {
      VisitModel? visitDetails = await VisitsRetriever.retrieveVisitDetails(id);
      visitData.value=visitDetails!;
    } catch (e) {
      Get.snackbar("Error", "Failed to retrieve visit details: $e");
    } finally {
      isLoading.value = false;
    }
  }

  final formKey = GlobalKey<FormState>();

  TextEditingController dateController = TextEditingController();
  TextEditingController fromTimeController = TextEditingController();
  TextEditingController toTimeController = TextEditingController();
  TextEditingController numberOfPeopleController = TextEditingController();
  TextEditingController patientNameController = TextEditingController();
  TextEditingController patientLocationController = TextEditingController();
  TextEditingController patientAddressController = TextEditingController();
  TextEditingController assistantNameController = TextEditingController();
  TextEditingController patientPhoneController = TextEditingController();
  TextEditingController assistantPhoneController = TextEditingController();
  TextEditingController patientFamIDController = TextEditingController();
  TextEditingController patientIDNumberController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController googleLinkController = TextEditingController();

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
      dateController.text = datePicked.toString().split(" ")[0];

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
  Future<void> getAreasNames() async {
    isLoading.value = true;
    try {
      areaData.value = await GetAreaFirebase.retrieveArea();
      areaNames.value = areaData.map((area) => area.area!).toList();
    }catch(e){
      Get.snackbar("Error", "Failed to retrieve area details");
    }finally{
      isLoading.value=false;
    }
  }

  void editVisit(){
    isLoading(true);
    try{
      Visit newVisit = Visit(
        area: {
          'name': areaName.value,
          'visitId': ''
        },
        father: {
          'id': visitData.value.father['id'],
          'isFather': true,
          'name': visitData.value.father['name'],
          'phoneNumber': visitData.value.father['phone']
        },
        patient: {
          'name': patientNameController.text,
          'phoneNumber': patientPhoneController.text,
          'PatientFamilyId': patientFamIDController.text,
          'PatientIDNumber': patientIDNumberController.text,
        },
        servant: {
          'id': visitData.value.servant['id'],
          'isFather': false,
          'name': visitData.value.servant['name'],
          'phoneNumber': visitData.value.servant['phoneNumber']
        },
         assistant: {
            'name': assistantNameController.text,
            'phoneNumber':assistantPhoneController.text
          },
        status: 'NEW',
        address: {
          'address':patientAddressController.text,
          'addressType':addressType.value
        },
        visitDate: dateController.text,
        visitTimeRangeFrom: fromTimeController.text,
        visitTimeRangeTo: toTimeController.text,
        numberOfPeople: numberOfPeopleController.text,
        note: noteController.text,
        googleLink: googleLinkController.text
      );
      VisitSubmission.updateVisit(id,newVisit);
      Get.snackbar("Visits", "Visits add successfully");
      Get.offNamedUntil(
          Routes.VISIT_DETAILS,
              (route) => route.settings.name == Routes.HOME,
          arguments: id
      );
    }catch (e){
      Get.snackbar("Error", e.toString());
    }finally{
      isLoading(false);
    }
  }

  void displayData(){
    dateController = TextEditingController(text: visitData.value.visitDate);
    fromTimeController = TextEditingController(text: visitData.value.visitTimeRangeFrom);
    toTimeController = TextEditingController(text: visitData.value.visitTimeRangeTo);
    numberOfPeopleController = TextEditingController(text: visitData.value.numberOfPeople);
    patientNameController = TextEditingController(text: visitData.value.patient['name']);
    patientLocationController = TextEditingController(text: visitData.value.googleLink);
    patientAddressController = TextEditingController(text: visitData.value.address['address']);
    assistantNameController = TextEditingController(text: visitData.value.assistant['name']);
    patientPhoneController = TextEditingController(text: visitData.value.patient['phoneNumber']);
    assistantPhoneController = TextEditingController(text: visitData.value.assistant['phoneNumber']);
    patientFamIDController = TextEditingController(text: visitData.value.patient['PatientFamilyId']);
    patientIDNumberController = TextEditingController(text: visitData.value.patient['PatientIDNumber']);
    noteController = TextEditingController(text:  visitData.value.note);
    googleLinkController = TextEditingController(text:  visitData.value.googleLink);
  }
  @override
  void onInit () async{
    await getVisitDetails();
    await getAreasNames();
    displayData();
    super.onInit();
  }
}
