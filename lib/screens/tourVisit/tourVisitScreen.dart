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
  final String tour_requestid;

  const TourVisitScreen({Key? key, required this.tour_requestid})
      : super(key: key);

  @override
  State<TourVisitScreen> createState() => _TourVisitScreenState();
}

class _TourVisitScreenState extends State<TourVisitScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController travelfromController = TextEditingController();
  TextEditingController traveltoController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController daysController = TextEditingController();
  TextEditingController demoController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  String? deptDate="",returnDate="",checkinDate="",checkoutDate="", selectedTime='';
  TourDetailsByIdModel? tourDetailsByIdModel;
  DateTime? deptDT,returnDT;

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
    if (widget.tour_requestid! != '0') {
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
              nameController.text = tourDetailsByIdModel!.data![0].name!;
              travelfromController.text =
                  tourDetailsByIdModel!.data![0].travelFrom!.toString();
              traveltoController.text =
                  tourDetailsByIdModel!.data![0].travelTo!.toString();
              deptDate = tourDetailsByIdModel!.data![0].deptDate!;
              returnDate = tourDetailsByIdModel!.data![0].returnDate!;

              tourDetailsByIdModel!.data![0].checkinDate == null ||
                  tourDetailsByIdModel!.data![0].checkinDate! == ''
                  ? checkinDate = ''
                  : checkinDate =
              tourDetailsByIdModel!.data![0].checkinDate!;
              tourDetailsByIdModel!.data![0].checkoutDate == null ||
                  tourDetailsByIdModel!.data![0].checkoutDate! == ''
                  ? checkoutDate = ''
                  : checkoutDate =
              tourDetailsByIdModel!.data![0].checkoutDate!;

              daysController.text=tourDetailsByIdModel!.data![0].noOfDays!.toString();

              tourDetailsByIdModel!.data![0].noOfDemos == null ||
                  tourDetailsByIdModel!.data![0].noOfDemos! == ''
                  ? demoController.text = ''
                  : demoController.text =
              tourDetailsByIdModel!.data![0].noOfDemos!.toString();

            //  checkinDate = tourDetailsByIdModel!.data![0].checkinDate!;
            //  checkoutDate = tourDetailsByIdModel!.data![0].checkoutDate!;
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
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
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
                            'Sales/Trainer Name',
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
                            'Sales/Trainer Name'),
                        controller: nameController,
                      //  keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.characters,
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
                            'Travel From',
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
                        controller: travelfromController,
                        decoration: GlobalFunctions.getInputDecoration('Travel From'),
                        style: TextStyle(fontSize: 14),
                        textCapitalization: TextCapitalization.characters,
                        // keyboardType: TextInputType.text,
                        onSaved: (value) {
                          travelfromController.text = value as String;
                        },
                      ),
                      SizedBox(height: 25,),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Travel To',
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
                        controller: traveltoController,
                        decoration: GlobalFunctions.getInputDecoration('Travel To'),
                        style: TextStyle(fontSize: 14),
                       // keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.characters,
                        onSaved: (value) {
                          traveltoController.text = value as String;
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
                            'Departure Date',
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
                              initialDate:  DateTime.now().add(Duration(days: 7)),
                              firstDate:  DateTime.now().add(Duration(days: 7)),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            deptDT=pickedDate;
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement

                            DateTime? currentDT=DateTime.now();
                          /*  if(pickedDate.isBefore(currentDT))
                              {
                                showCustomSnackBar('Please select Tour Date after Current Date',isError: false);
                                setState(() {
                                  deptDate = '';
                                });
                              }
                            else {*/
                              setState(() {
                                deptDate = formattedDate;
                              });
                          //  }
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
                                    deptDate == ""
                                        ? 'Select Departure Date'
                                        : deptDate!,
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
                            'Return Date',
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
                              initialDate:  DateTime.now().add(Duration(days: 7)),
                              firstDate:  DateTime.now().add(Duration(days: 7)),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            returnDT=pickedDate;
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement

                            setState(() {
                              returnDate = formattedDate;
                              if(deptDT!='')
                                {
                                  final differenceInDays = returnDT!.difference(deptDT!).inDays;
                                  if(differenceInDays<0)
                                    {
                                      showCustomSnackBar('Select Departure Date & Return Date Correctly',isError: false);
                                      daysController.text='';
                                      returnDate='';
                                      deptDate='';
                                    }
                                  else{
                                    setState(() {
                                      daysController.text=differenceInDays.toString();
                                    });
                                  }

                                  print('$differenceInDays');
                                }
                              else{
                                showCustomSnackBar('Select Departure Date',isError: false);
                              }
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
                                        returnDate == ""
                                            ? 'Select Return Date'
                                            : returnDate!,
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
                      /*Align(
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
                      ),*/
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Check-In Date',
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
                              checkinDate = formattedDate;
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
                                        checkinDate == ""
                                            ? 'Select Check-In Date'
                                            : checkinDate!,
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
                            'Check-Out Date',
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
                              checkoutDate = formattedDate;
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
                                        checkoutDate == ""
                                            ? 'Select Check-Out Date'
                                            : checkoutDate!,
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
                            'No. Of Days',
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
                            'No. Of Days'),
                       // enabled: false,
                        controller: daysController,
                        keyboardType: TextInputType.text,
                        onSaved: (value) {
                          daysController.text = value as String;
                        },
                      ),
                      SizedBox(height: 25,),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'No. Of Demos',
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
                            'No. Of Demo'),
                        controller: demoController,
                        keyboardType: TextInputType.text,
                        onSaved: (value) {
                          demoController.text = value as String;
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
                                  if (nameController.text.isEmpty) {
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
                                      /* TourRequestModel tourRequestModel =
                                      TourRequestModel();
                                  tourRequestModel.purpose =
                                      nameController.text;
                                  tourRequestModel.area = "vashi";
                                  tourRequestModel.date = deptDate;
                                  tourRequestModel.time = selectedTime;
                                  tourRequestModel.amount =
                                      int.parse(amountController.text);
                                  tourRequestModel.remark =
                                      remarksController.text;
                                  tourRequestModel.userId = 22;
                                  tourRequestModel.roleId = int.parse(
                                      Get.find<AuthController>().getRoleId());
                                  tourRequestModel.tourReqId = "";*/
                                      String tourReqid = "";

                                      addTourRequest(tourController, tourReqid);
                                    } else {
                                      /* TourRequestModel tourRequestModel =
                                      TourRequestModel();
                                  tourRequestModel.purpose =
                                      nameController.text;
                                  tourRequestModel.area = areaController.text;
                                  tourRequestModel.date = deptDate;
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

                                      addTourRequest(tourController,
                                          widget.tour_requestid.toString());
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

 /*  void addTourRequest(TourController tourController,TourRequestModel tourRequestModel) async
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
      TourController tourController, String tourid) async {
    tourController.submitTourRequest(
            name: nameController.text,
            travel_from: travelfromController.text,
            travel_to: traveltoController.text,
            dept_date: deptDate,
            return_date: returnDate,
            checkin_date: checkinDate,
            checkout_date: checkoutDate,
            no_of_days: daysController.text,
            no_of_demos: demoController.text,
            user_id: Get.find<AuthController>().getUserId(),
            role_id: Get.find<AuthController>().getRoleId(),
            remark: remarksController.text,
            tourid: tourid)
        .then((message) async {
      if (message == 'Request submitted successfully.'||message=='Request updated successfully.') {
        showCustomSnackBar(message!, isError: false);
        Navigator.pop(context);
      } else {
        showCustomSnackBar(message!);
      }
    });
  }
}


