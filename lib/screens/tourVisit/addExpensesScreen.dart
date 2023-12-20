import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmers/constant/no_internet_screen.dart';

import '../../constant/app_constants.dart';
import '../../constant/colorsConstant.dart';
import '../../constant/globalFunction.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/textConstant.dart';
import '../../controllers/tourController.dart';

class AddExpensesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddExpensesScreen();
  }

}

class _AddExpensesScreen extends State<AddExpensesScreen> {
  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  TextEditingController areaController = TextEditingController();
  TextEditingController approxKmController = TextEditingController();
  TextEditingController daController = TextEditingController();
  TextEditingController taController = TextEditingController();
  TextEditingController hotelController = TextEditingController();
  TextEditingController misphoneController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  String? selectedDate, selectedTime;


  @override
  void initState() {
    super.initState();
    selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    CheckInternet.initConnectivity().then((value) =>
        setState(() {
          _connectionStatus = value;
        }));
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
          CheckInternet.updateConnectionStatus(result).then((value) =>
              setState(() {
                _connectionStatus = value;
              }));
        });
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ?  const NoInternetScreen()
        : GetBuilder<TourController>(builder: (tourController){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
              centerTitle: true,
              title: Text(
                TextConstant.addtourVisit,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Date',
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
                    SizedBox(height: 25,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Area Covered',
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
                      decoration: GlobalFunctions.getInputDecoration(
                          'Area'),
                      controller: areaController,
                      //  keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.characters,
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
                          'Approx Km',
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
                      controller: approxKmController,
                      decoration: GlobalFunctions.getInputDecoration('Approx Km'),
                      style: TextStyle(fontSize: 14),
                      textCapitalization: TextCapitalization.characters,
                      // keyboardType: TextInputType.text,
                      onSaved: (value) {
                        approxKmController.text = value as String;
                      },
                    ),
                    SizedBox(height: 25,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'DA',
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
                      controller: daController,
                      decoration: GlobalFunctions.getInputDecoration('Travel To'),
                      style: TextStyle(fontSize: 14),
                      // keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.characters,
                      onSaved: (value) {
                        daController.text = value as String;
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
                          'TA',
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
                      decoration: GlobalFunctions.getInputDecoration(
                          'TA'),
                      // enabled: false,
                      controller: taController,
                      keyboardType: TextInputType.text,
                      onSaved: (value) {
                        taController.text = value as String;
                      },
                    ),
                    SizedBox(height: 25,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Hotel/Residence',
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
                      decoration: GlobalFunctions.getInputDecoration(
                          'Hotel / Residence'),
                      controller: hotelController,
                      keyboardType: TextInputType.text,
                      onSaved: (value) {
                        hotelController.text = value as String;
                      },
                    ),
                    SizedBox(height: 25,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          TextConstant.remarks,
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
                      decoration: GlobalFunctions.getInputDecoration(
                          TextConstant.remarks),
                      controller: remarksController,
                      //keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.characters,
                      onSaved: (value) {
                        remarksController.text = value as String;
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
                            MaterialStateProperty.all<Color>(
                                primaryColor),
                            foregroundColor:
                            MaterialStateProperty.all<Color>(
                                primaryColor),
                            textStyle:
                            MaterialStateProperty.all<TextStyle>(
                              const TextStyle(fontSize: 16),
                            ),
                            padding:
                            MaterialStateProperty.all<EdgeInsets>(
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
                          /*  if (nameController.text.isEmpty) {
                              showCustomSnackBar('Enter Sales/Trainer Name',
                                  isError: false);
                            } else if (travelfromController.text.isEmpty) {
                              showCustomSnackBar('Enter Travel From Field',
                                  isError: false);
                            } else if (traveltoController.text.isEmpty) {
                              showCustomSnackBar('Enter Travel To Field',
                                  isError: false);
                            } else if (deptDate == '') {
                              showCustomSnackBar('Select Departure Date',
                                  isError: false);
                            } else if (returnDate == '') {
                              showCustomSnackBar('Select Return Date',
                                  isError: false);
                            }
                            else if (daysController.text.isEmpty) {
                              showCustomSnackBar('Enter No of Days',
                                  isError: false);
                            } else {
                              if (widget.tour_requestid == '0') {
                                String tourReqid = "";

                                addTourRequest(tourController, tourReqid);
                              } else {
                                addTourRequest(tourController,
                                    widget.tour_requestid.toString());
                              }
                            }*/
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


}