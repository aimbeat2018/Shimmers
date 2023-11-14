import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';
import 'package:shimmers/constant/custom_snackbar.dart';
import 'package:shimmers/controllers/tourController.dart';
import 'package:shimmers/model/TourRequestModel.dart';
import 'package:shimmers/screens/tourVisit/tourListScreen.dart';

import '../../constant/app_constants.dart';
import '../../constant/colorsConstant.dart';
import '../../constant/globalFunction.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../constant/textConstant.dart';
import '../../controllers/authController.dart';
import '../../model/tourdetailsByIdModel.dart';

class TourVisitScreen extends StatefulWidget {
  static String name = 'TourVisitScreen';
  int tour_requestid = 0;

  TourVisitScreen({Key? key, required this.tour_requestid}) : super(key: key);

  @override
  State<TourVisitScreen> createState() => _TourVisitScreenState();
}

class _TourVisitScreenState extends State<TourVisitScreen> {
  TextEditingController remarksController = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  String? selectedDate, selectedTime;
  TourDetailsByIdModel? tourDetailsByIdModel;

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
    if (widget.tour_requestid! != 0) {
      if (_connectionStatus != AppConstants.connectivityCheck) {
        if (mounted) {
          Future.delayed(Duration.zero, () async {
            tourDetailsByIdModel = await Get.find<TourController>()
                .getTourDetailsByid(
                    tour_reqid: widget.tour_requestid.toString());
            if (tourDetailsByIdModel != null) {
              // remarksController.text=tourDetailsByIdModel!.data![0].remark!;
              tourDetailsByIdModel!.data![0].executiveRemark == null ||
                      tourDetailsByIdModel!.data![0].executiveRemark! == ''
                  ? remarksController.text = ''
                  : remarksController.text =
                      tourDetailsByIdModel!.data![0].executiveRemark!;
              purposeController.text = tourDetailsByIdModel!.data![0].purpose!;
              areaController.text =
                  tourDetailsByIdModel!.data![0].area!.toString();
              amountController.text =
                  tourDetailsByIdModel!.data![0].amount!.toString();
              selectedDate = tourDetailsByIdModel!.data![0].date!;
              selectedTime = tourDetailsByIdModel!.data![0].time!;
            }
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<TourController>(builder: (tourController) {
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
                            TextConstant.purpose,
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
                        maxLines: 2,
                        decoration: GlobalFunctions.getInputDecoration(
                            TextConstant.purpose),
                        controller: purposeController,
                        keyboardType: TextInputType.text,
                        onSaved: (value) {
                          purposeController.text = value as String;
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
                            TextConstant.amount,
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
                            TextConstant.amount),
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          amountController.text = value as String;
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
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
                        keyboardType: TextInputType.text,
                        onSaved: (value) {
                          remarksController.text = value as String;
                        },
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  primaryColor),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  primaryColor),
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
                                showCustomSnackBar('Enter Area',
                                    isError: false);
                              } else if (amountController.text.isEmpty) {
                                showCustomSnackBar('Enter Amount',
                                    isError: false);
                              } else {
                                if (widget.tour_requestid == 0) {
                                 /* TourRequestModel tourRequestModel =
                                      TourRequestModel();
                                  tourRequestModel.purpose =
                                      purposeController.text;
                                  tourRequestModel.area = "vashi";
                                  tourRequestModel.date = selectedDate;
                                  tourRequestModel.time = selectedTime;
                                  tourRequestModel.amount =
                                      int.parse(amountController.text);
                                  tourRequestModel.remark =
                                      remarksController.text;
                                  tourRequestModel.userId = 22;
                                  tourRequestModel.roleId = int.parse(
                                      Get.find<AuthController>().getRoleId());
                                  tourRequestModel.tourReqId = "";*/
                                  String tourReqid="";

                                  addTourRequest(tourController,tourReqid);
                                } else {
                                 /* TourRequestModel tourRequestModel =
                                      TourRequestModel();
                                  tourRequestModel.purpose =
                                      purposeController.text;
                                  tourRequestModel.area = areaController.text;
                                  tourRequestModel.date = selectedDate;
                                  tourRequestModel.time = selectedTime;
                                  tourRequestModel.amount =
                                      int.parse(amountController.text);
                                  tourRequestModel.remark =
                                      remarksController.text;
                                  tourRequestModel.userId = int.parse(
                                      Get.find<AuthController>().getUserId());
                                  tourRequestModel.roleId = int.parse(
                                      Get.find<AuthController>().getRoleId());
                                  tourRequestModel.tourReqId =
                                      widget.tour_requestid.toString();*/

                                  addTourRequest(tourController,widget.tour_requestid.toString());
                                }
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

  /* void addTourRequest(TourController tourController,TourRequestModel tourRequestModel) async
  {
    tourController.submitTourRequest(model: tourRequestModel).then((message) async{
      if (message == 'Request submitted successfully.') {
        showCustomSnackBar(message!, isError: false);
        Navigator.pop(context);
      } else {
        showCustomSnackBar('Something went wrong!',isError: true);
      }
    });

  }*/
  Future<void> addTourRequest(
    TourController tourController,String tourid
  ) async {
    tourController
        .submitTourRequest(
            area: areaController.text,
            date: selectedDate,
            time: selectedTime,
            amount: amountController.text,
            userid: Get.find<AuthController>().getUserId(),
            roleid: Get.find<AuthController>().getRoleId(),
            remark: remarksController.text,
            purpose: purposeController.text,
            tourid: tourid)
        .then((message) async {
      if (message == 'Request submitted successfully.') {
        showCustomSnackBar(message!, isError: false);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TourListScreen()));
      } else {
        showCustomSnackBar(message!);
      }
    });
  }
}
