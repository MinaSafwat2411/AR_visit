import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_new_visit_controller.dart';

class AddNewVisitView extends GetView<AddNewVisitController> {
  const AddNewVisitView({super.key});
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
            // navigateandend(context, ArVisitLayout());
            Get.back();
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
                    key: controller.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: controller.patientNameController,
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
                                  controller: controller.patientFamIDController,
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
                                controller:
                                    controller.patientIDNumeberController,
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
                            controller: controller.patientPhoneController,
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

                            // TODO: Update the state of the app
                            // setState(() {
                            //   addressType = value!;
                            // });
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
                          items: controller.areaNames.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.

                            // TODO: Update the state of the app
                            // setState(() {
                            //   areaName = value!;
                            // });
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
                          controller: controller.dateController,
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
                            controller.selectDate(context);
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
                                controller: controller.fromTimeController,
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
                                  controller.selectedFromTime();
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
                                controller: controller.toTimeController,
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
                                  controller.selectedToTime();
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
                      // TODO: Implement the submit button
                      // setState(() {
                      //   print(controller.formKey.currentState!.validate());
                      //   Visit newVisit = Visit(
                      //     area: {
                      //       'name': areaName,
                      //       'visitId': areasData[areaName]
                      //     },
                      //     father: {
                      //       'id': '',
                      //       'isFather': true,
                      //       'name': '',
                      //       'phoneNumber': ''
                      //     },
                      //     patient: {
                      //       'name': patientNameController.text,
                      //       'phoneNumber': patientPhoneController.text,
                      //       'PatientFamilyId': patientFamIDController.text,
                      //       'PatientIDNumber': patientIDNumeberController.text,
                      //     },
                      //     servant: {
                      //       'id': '',
                      //       'isFather': false,
                      //       'name': '',
                      //       'phoneNumber': ''
                      //     },
                      //     status: 'PENDING_ASSIGNMENT',
                      //     visitDate: dateController.text,
                      //     visitTimeRangeFrom: fromTimeController.text,
                      //     visitTimeRangeTo: toTimeController.text,
                      //   );
                      //   visitSubmission.submitVisit(newVisit);
                      //   Navigator.of(context).pop();
                      // });
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
