import 'package:ar_visiting_app/models/visit_model.dart';
import 'package:ar_visiting_app/shared/network/firebase/areas_retriever.dart';
import 'package:ar_visiting_app/shared/network/firebase/visit_submission.dart';
import 'package:ar_visiting_app/layouts/ar_visit_layout.dart';
import 'package:ar_visiting_app/shared/components/components.dart';
import 'package:flutter/material.dart';

class newVisitScreen extends StatefulWidget {
  const newVisitScreen({super.key});

  @override
  State<newVisitScreen> createState() => _newVisitScreenState();
}

class _newVisitScreenState extends State<newVisitScreen> {
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
      setState(() {
        dateController.text = datePicked.toString().split(" ")[0];
      });
    }
  }

  Future<void> selectedFromTime() async {
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
      setState(() {
        fromTimeController.text = fromTimePicked.format(context).toString();
      });
    }
  }

  Future<void> selectedToTime() async {
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
      setState(() {
        toTimeController.text = toTimePicked.format(context).toString();
      });
    }
  }

  void getAreasNames() async {
    areasData = await areaRetriever.retrieveAreas();
    for (String areaName in areasData.keys) {
      setState(() {
        areaNames.add(areaName);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAreasNames();
  }

  @override
  void dispose() {
    dateController.dispose();
    fromTimeController.dispose();
    toTimeController.dispose();
    patientNameController.dispose();
    patientFamIDController.dispose();
    patientIDNumeberController.dispose();
    patientPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Visit',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            fontFamily: 'Inter',
          ),
        ),
        leading: IconButton(
          onPressed: () {
            navigateandend(context, ArVisitLayout());
          },
          icon: const Icon(Icons.chevron_left),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: patientNameController,
                          decoration: InputDecoration(
                            labelText: 'Patient Name',
                            floatingLabelStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 239, 84, 0),
                              ),
                            ),
                          ),
                          autofocus: false,
                          cursorColor: const Color.fromARGB(255, 239, 84, 0),
                          validator: (name) {
                            if (name == null || name.isEmpty) {
                              return 'Patient name can\'t be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(5, 8, 8, 8),
                              child: Text(
                                'E1C1F',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 45,
                              child: TextFormField(
                                  controller: patientFamIDController,
                                  decoration: InputDecoration(
                                    labelText: 'XXXX',
                                    floatingLabelStyle: const TextStyle(
                                      color: Colors.black,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 239, 84, 0),
                                      ),
                                    ),
                                  ),
                                  autofocus: false,
                                  cursorColor:
                                      const Color.fromARGB(255, 239, 84, 0),
                                  validator: (familyID) {
                                    if (familyID == null || familyID.isEmpty) {
                                      return 'Patient\'s family ID must be entered';
                                    } else if (familyID.length >= 7) {
                                      return 'Patient\'s family ID must be 1 to 6 digits';
                                    }
                                    return null;
                                  }),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(15, 8, 12, 8),
                              child: Text(
                                'NR',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.255,
                              height: 45,
                              child: TextFormField(
                                controller: patientIDNumeberController,
                                decoration: InputDecoration(
                                  labelText: 'X',
                                  floatingLabelStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 239, 84, 0),
                                    ),
                                  ),
                                ),
                                autofocus: false,
                                cursorColor:
                                    const Color.fromARGB(255, 239, 84, 0),
                                validator: (patientID) {
                                  if (patientID == null || patientID.isEmpty) {
                                    return 'Patient\'s ID must be entered';
                                  } else if (patientID.length != 1) {
                                    return 'Patient\'s ID must be 1 digit';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                            controller: patientPhoneController,
                            decoration: InputDecoration(
                              labelText: 'Patient Phone Number',
                              floatingLabelStyle: const TextStyle(
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 239, 84, 0),
                                ),
                              ),
                            ),
                            autofocus: false,
                            cursorColor: const Color.fromARGB(255, 239, 84, 0),
                            validator: (phone) {
                              if (phone == null || phone.isEmpty) {
                                return 'Patient\'s phone number must be entered';
                              } else if (phone.length != 11) {
                                return 'Patient\'s phone must consist of 11 digits';
                              }
                              return null;
                            }),
                        const SizedBox(height: 12),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Assistant Name',
                            floatingLabelStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 239, 84, 0),
                              ),
                            ),
                          ),
                          autofocus: false,
                          cursorColor: const Color.fromARGB(255, 239, 84, 0),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Assistant Phone',
                            floatingLabelStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 239, 84, 0),
                              ),
                            ),
                          ),
                          autofocus: false,
                          cursorColor: const Color.fromARGB(255, 239, 84, 0),
                          validator: (assisstantPhone) {
                            // Allow the field to be empty
                            if (assisstantPhone == null ||
                                assisstantPhone.isEmpty) {
                              return null; // No error if the field is empty
                            }

                            // If the field is not empty, check if the value meets the condition
                            if (assisstantPhone.length != 11) {
                              return 'Phone must consist of 11 numbers';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          items:
                              ['Hospital', 'Home', 'Dar'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              addressType = value!;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Address Type',
                            floatingLabelStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 239, 84, 0),
                              ),
                            ),
                          ),
                          autofocus: false,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Address',
                            floatingLabelStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 239, 84, 0),
                              ),
                            ),
                          ),
                          autofocus: false,
                          cursorColor: const Color.fromARGB(255, 239, 84, 0),
                          validator: (address) {
                            if (address == null || address.isEmpty) {
                              return 'Patient\'s address must be entered';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          items: areaNames.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              areaName = value!;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Area',
                            floatingLabelStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 239, 84, 0),
                              ),
                            ),
                          ),
                          autofocus: false,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Google Maps Link',
                            floatingLabelStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 239, 84, 0),
                              ),
                            ),
                          ),
                          autofocus: false,
                          cursorColor: const Color.fromARGB(255, 239, 84, 0),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: dateController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.date_range),
                            labelText: 'Date',
                            floatingLabelStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 239, 84, 0),
                              ),
                            ),
                          ),
                          readOnly: true,
                          autofocus: false,
                          validator: (date) {
                            if (date == null || date.isEmpty) {
                              return 'Date of visit must be chosen';
                            }
                            return null;
                          },
                          onTap: () {
                            selectDate(context);
                          },
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(5, 8, 8, 8),
                              child: Text(
                                'From:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.284,
                              height: 45,
                              child: TextFormField(
                                controller: fromTimeController,
                                decoration: InputDecoration(
                                  labelText: 'Start',
                                  floatingLabelStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 239, 84, 0),
                                    ),
                                  ),
                                ),
                                readOnly: true,
                                autofocus: false,
                                validator: (start) {
                                  if (start == null || start.isEmpty) {
                                    return 'Start time of visit must be chosen';
                                  }
                                  return null;
                                },
                                onTap: () {
                                  selectedFromTime();
                                },
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(15, 8, 12, 8),
                              child: Text(
                                'To:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.284,
                              height: 45,
                              child: TextFormField(
                                controller: toTimeController,
                                decoration: InputDecoration(
                                  labelText: 'End',
                                  floatingLabelStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 239, 84, 0),
                                    ),
                                  ),
                                ),
                                readOnly: true,
                                autofocus: false,
                                onTap: () {
                                  selectedToTime();
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 120,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Notes',
                              floatingLabelStyle: const TextStyle(
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 239, 84, 0),
                                ),
                              ),
                            ),
                            autofocus: false,
                            expands: true,
                            maxLines: null,
                            minLines: null,
                            cursorColor: const Color.fromARGB(255, 239, 84, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        print(formKey.currentState!.validate());
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
                            'PatientIDNumber': patientIDNumeberController.text,
                          },
                          servant: {
                            'id': '',
                            'isFather': false,
                            'name': '',
                            'phoneNumber': ''
                          },
                          status: 'PENDING_ASSIGNMENT',
                          visitDate: dateController.text,
                          visitTimeRangeFrom: fromTimeController.text,
                          visitTimeRangeTo: toTimeController.text,
                        );
                        visitSubmission.submitVisit(newVisit);
                        Navigator.of(context).pop();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 239, 84, 0),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
