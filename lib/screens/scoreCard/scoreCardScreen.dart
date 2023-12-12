import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constant/app_constants.dart';
import '../../constant/colorsConstant.dart';
import '../../constant/custom_snackbar.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../constant/textConstant.dart';
import '../../controllers/scoreController.dart';
import '../../model/activityCountModel.dart';

class ScoreCardScreen extends StatefulWidget {
  final String excutive_id;

  const ScoreCardScreen({Key? key, required this.excutive_id})
      : super(key: key);

  @override
  State<ScoreCardScreen> createState() => _ScoreCardScreenState();
}

class _ScoreCardScreenState extends State<ScoreCardScreen> {
  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  String? fromDate = "", toDate = "";
  ActivityCountModel? activityCountModel;

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
    if (mounted) {
      Future.delayed(Duration.zero, () async {
        Get.find<ScoreController>()
            .getEmployeeScorecard(user_id:widget.excutive_id,from_date: '',to_date: '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<ScoreController>(builder: (scoreController) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                centerTitle: true,
                title: Text(
                  TextConstant.ScoreCardAnalytics.replaceAll("\n", " "),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: scoreController.isLoading &&
                      scoreController.activityCountModel == null
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            margin: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            color: primaryColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    scoreController.activityCountModel!
                                                .profileImage! ==
                                            ""
                                        ? Image.asset(
                                            'assets/images/avatar.png',
                                            height: 50,
                                            width: 50,
                                          )
                                        : Image.network(
                                            scoreController.activityCountModel!
                                                .profileImage!,
                                            height: 50,
                                            width: 50,
                                            fit: BoxFit.cover,
                                          ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Name: ${scoreController
                                          .activityCountModel!.name!}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                           'Role: ${scoreController
                                               .activityCountModel!.role!}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                           'Mobile: ${scoreController
                                               .activityCountModel!.mobile!}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Select Dates',
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            //DateTime.now() - not to allow to choose before today.
                                            lastDate: DateTime(2101));

                                        if (pickedDate != null) {
                                          //deptDT=pickedDate;
                                          print(
                                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                          String formattedDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(pickedDate);
                                          print(
                                              formattedDate); //formatted date output using intl package =>  2021-03-16
                                          //you can implement different kind of Date Format here according to your requirement

                                          DateTime? currentDT = DateTime.now();
                                          setState(() {
                                            fromDate = formattedDate;
                                          });
                                          //  }
                                        } else {
                                          print("Date is not selected");
                                        }
                                      },
                                      child: Container(
                                        width: 125,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            border: Border.all(
                                                color: primaryColor)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_month,
                                                color: primaryColor,
                                              ),
                                              Expanded(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Text(
                                                  fromDate == ""
                                                      ? 'From Date'
                                                      : fromDate!,
                                                  style: const TextStyle(
                                                      color: primaryColor,
                                                      fontSize: 14),
                                                ),
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),
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
                                          //deptDT=pickedDate;
                                          print(
                                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                          String formattedDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(pickedDate);
                                          print(
                                              formattedDate); //formatted date output using intl package =>  2021-03-16
                                          //you can implement different kind of Date Format here according to your requirement

                                          DateTime? currentDT = DateTime.now();
                                          setState(() {
                                            toDate = formattedDate;
                                          });
                                          //  }
                                        } else {
                                          print("Date is not selected");
                                        }
                                      },
                                      child: Container(
                                        width: 125,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            border: Border.all(
                                                color: primaryColor)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_month,
                                                color: primaryColor,
                                              ),
                                              Expanded(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Text(
                                                  toDate == ""
                                                      ? 'To Date'
                                                      : toDate!,
                                                  style: const TextStyle(
                                                      color: primaryColor,
                                                      fontSize: 14),
                                                ),
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: SizedBox(
                                    width: 120,
                                    // height: 45,
                                    child: scoreController.isLoading
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(primaryColor),
                                              foregroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(primaryColor),
                                              textStyle: MaterialStateProperty
                                                  .all<TextStyle>(
                                                const TextStyle(fontSize: 16),
                                              ),
                                              padding: MaterialStateProperty.all<
                                                  EdgeInsets>(
                                                const EdgeInsets.symmetric(
                                                    horizontal: 16, vertical: 8),
                                              ),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              if (fromDate == '') {
                                                showCustomSnackBar(
                                                    'Select From Date',
                                                    isError: true);
                                              } else if (toDate == '') {
                                                showCustomSnackBar(
                                                    'Select To Date',
                                                    isError: true);
                                              } else {
                                                //call API here
                                                // addSalon(salonController);
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
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Score Card',
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  color: primaryColor,
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Salon Created Count',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              'Explore',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12),
                                            )),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 80,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: primaryColor),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Actual Value',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  scoreController
                                                      .activityCountModel!
                                                      .salonCreated!
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(
                                          color: Colors.white,
                                          thickness: 1,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Salon Visited Count',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              'Explore',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12),
                                            )),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 80,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: primaryColor),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Actual Value',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  scoreController
                                                      .activityCountModel!
                                                      .salonVisit!
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(
                                          color: Colors.white,
                                          thickness: 1,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Salon Order Value',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              'Explore',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12),
                                            )),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 80,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: primaryColor),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Actual Value',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  'Rs. ${scoreController.activityCountModel!.salonOrderValue!.toString()}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(
                                          color: Colors.white,
                                          thickness: 1,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Total Target',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              'Explore',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12),
                                            )),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 80,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: primaryColor),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Actual Target',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      scoreController
                                                          .activityCountModel!
                                                          .completedTarget!
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16),
                                                    ),
                                                    Text(
                                                      ' / ',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16),
                                                    ),
                                                    Text(
                                                      scoreController
                                                          .activityCountModel!
                                                          .assignedTarget!
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(
                                          color: Colors.white,
                                          thickness: 1,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Scheduled Demo Count',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              'Explore',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12),
                                            )),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 80,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: primaryColor),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Actual Value',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  scoreController
                                                      .activityCountModel!.demo!
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(
                                          color: Colors.white,
                                          thickness: 1,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Feedback Count',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              'Explore',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12),
                                            )),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 80,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: primaryColor),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Actual Value',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  scoreController
                                                      .activityCountModel!
                                                      .feedback!
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(
                                          color: Colors.white,
                                          thickness: 1,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Total Payment Collected',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              'Explore',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12),
                                            )),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 80,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: primaryColor),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Actual Value',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  'Rs. ${scoreController.activityCountModel!.paymentCollect!.toString()}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(
                                          color: Colors.white,
                                          thickness: 1,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Campaigns Count',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              'Explore',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12),
                                            )),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 80,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: primaryColor),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Actual Value',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  scoreController
                                                      .activityCountModel!
                                                      .campaign!
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            );
          });
  }
}
