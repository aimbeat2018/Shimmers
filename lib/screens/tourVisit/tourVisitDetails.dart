import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmers/controllers/tourController.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/custom_snackbar.dart';
import '../../constant/globalFunction.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/textConstant.dart';

class TourVisitDetails extends StatefulWidget {
  final String tour_requestid;

  const TourVisitDetails({Key? key, required this.tour_requestid})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TourVisitDetails();
  }
}

class _TourVisitDetails extends State<TourVisitDetails> {
  TextEditingController contactController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController descriController = TextEditingController();

  String? selectedDate, selectedTime;

  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();

    CheckInternet.initConnectivity().then((value) => setState(() {
          _connectionStatus = value;
        }));
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      CheckInternet.updateConnectionStatus(result).then((value) => setState(() {
            _connectionStatus = value;
          }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TourController>(builder: (tourController) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Text(
            'Fill Tour Visit Details',
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Area',
                      style: const TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: areaController,
                  decoration: GlobalFunctions.getInputDecoration('Area'),
                  style: TextStyle(fontSize: 14),
                  keyboardType: TextInputType.text,
                  onSaved: (value) {
                    areaController.text = value as String;
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      TextConstant.selectDate,
                      style: const TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        selectedDate = formattedDate;
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: primaryColor)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              selectedDate == null
                                  ? TextConstant.selectDate
                                  : selectedDate!,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                            ),
                          )),
                          Icon(
                            Icons.calendar_month,
                            color: Colors.grey.shade700,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      TextConstant.selectTime,
                      style: const TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () async {
                    final TimeOfDay? result = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    if (result != null) {
                      setState(() {
                        selectedTime = result.format(context);
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: primaryColor)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              selectedTime == null
                                  ? TextConstant.selectTime
                                  : selectedTime!,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                            ),
                          )),
                          Icon(
                            Icons.watch_later,
                            color: Colors.grey.shade700,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Role',
                      style: const TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: roleController,
                  decoration: GlobalFunctions.getInputDecoration('Role'),
                  style: TextStyle(fontSize: 14),
                  keyboardType: TextInputType.text,
                  onSaved: (value) {
                    roleController.text = value as String;
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Name',
                      style: const TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: nameController,
                  decoration: GlobalFunctions.getInputDecoration('Name'),
                  style: TextStyle(fontSize: 14),
                  keyboardType: TextInputType.text,
                  onSaved: (value) {
                    nameController.text = value as String;
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Contact',
                      style: const TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: contactController,
                  decoration: GlobalFunctions.getInputDecoration('Contact'),
                  style: TextStyle(fontSize: 14),
                  keyboardType: TextInputType.text,
                  onSaved: (value) {
                    contactController.text = value as String;
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Description',
                      style: const TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  style: const TextStyle(fontSize: 14),
                  maxLines: 5,
                  decoration: GlobalFunctions.getInputDecoration('Description'),
                  controller: descriController,
                  keyboardType: TextInputType.text,
                  onSaved: (value) {
                    descriController.text = value as String;
                  },
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 200,
                  child: tourController.isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(primaryColor),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(primaryColor),
                            textStyle: MaterialStateProperty.all<TextStyle>(
                              const TextStyle(fontSize: 16),
                            ),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (selectedDate == null) {
                              showCustomSnackBar(TextConstant.selectDate,
                                  isError: false);
                            } else if (selectedTime == null) {
                              showCustomSnackBar(TextConstant.selectTime,
                                  isError: false);
                            } else if (areaController.text.isEmpty) {
                              showCustomSnackBar('Enter Area', isError: false);
                            } else if (roleController.text.isEmpty) {
                              showCustomSnackBar('Enter Role', isError: false);
                            } else if (nameController.text.isEmpty) {
                              showCustomSnackBar('Enter Name', isError: false);
                            } else if (contactController.text.isEmpty) {
                              showCustomSnackBar('Enter Contact ',
                                  isError: false);
                            } else if (descriController.text.isEmpty) {
                              showCustomSnackBar('Enter Description',
                                  isError: false);
                            } else {
                              submitTourVisitDetails(tourController);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              TextConstant.submit.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> submitTourVisitDetails(TourController tourController) async {
    tourController
        .submitTourVisitDetails(
            tour_visitid: widget.tour_requestid,
            area: areaController.text,
            date: selectedDate,
            time: selectedTime,
            role: roleController.text,
            name: nameController.text,
            contact: contactController.text,
            description: descriController.text)
        .then((message) async {
      if (message == 'Request submitted successfully.') {
        showCustomSnackBar(message!, isError: false);
        /* Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TourListScreen()));*/
      } else {
        showCustomSnackBar(message!);
      }
    });
  }
}
