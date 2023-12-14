import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmers/constant/app_constants.dart';
import 'package:shimmers/constant/no_internet_screen.dart';
import 'package:shimmers/screens/noDataFound/noDataFoundScreen.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/textConstant.dart';
import '../../controllers/scoreController.dart';

class UserActivityDetailsScreen extends StatefulWidget {
  String userId, fromDate, toDate, activityType;

  UserActivityDetailsScreen(
      {required this.userId,
      required this.fromDate,
      required this.toDate,
      required this.activityType});

  @override
  State<StatefulWidget> createState() {
    return _UserActivityDetailScreen();
  }
}

class _UserActivityDetailScreen extends State<UserActivityDetailsScreen> {
  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool tour_allowed = true;

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
        Get.find<ScoreController>().employeeactivityDetails(
            user_id: widget.userId,
            activityType: widget.activityType,
            fromDate: widget.fromDate,
            toDate: widget.toDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? NoInternetScreen()
        : GetBuilder<ScoreController>(builder: (scoreController) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                centerTitle: true,
                title: Text(
                  'Activity Details',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: scoreController.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : scoreController.employeeActivityDetail!.data == null ||
                          scoreController.employeeActivityDetail!.data!.isEmpty
                      ? Center(
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: const NoDataFoundScreen()))
                      : Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: scoreController
                                  .employeeActivityDetail!.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 5),
                                    child: Card(
                                      elevation: 5,
                                      shadowColor: primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 18, vertical: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                'Salon Name: ${scoreController.employeeActivityDetail!.data![index].salonName}'),
                                            SizedBox(height: 5,),
                                            Text(
                                                'Salon Mobile: ${scoreController.employeeActivityDetail!.data![index].mobile}'),
                                            SizedBox(height: 5,),
                                            Text(
                                                'Salon Location: ${scoreController.employeeActivityDetail!.data![index].address}'),
                                            widget.activityType ==
                                                    'salon_order_value'
                                                ? Padding(
                                                  padding: const EdgeInsets.only(top: 5.0),
                                                  child: Text(
                                                      'Salon Order Value: Rs.${scoreController.employeeActivityDetail!.data![index].orderAmount}'),
                                                )
                                                : SizedBox(),
                                            widget.activityType ==
                                                'demo'
                                                ? Padding(
                                              padding: const EdgeInsets.only(top: 5.0),
                                              child: Text(
                                                  'Demo Date: ${scoreController.employeeActivityDetail!.data![index].demoDate}'),
                                            )
                                                : SizedBox(),
                                            widget.activityType ==
                                                'demo'
                                                ? Padding(
                                              padding: const EdgeInsets.only(top: 5.0),
                                              child: Text(
                                                  'Demo Time: ${scoreController.employeeActivityDetail!.data![index].demoTime}'),
                                            )
                                                : SizedBox(),
                                            widget.activityType ==
                                                'demo'
                                                ? Padding(
                                              padding: const EdgeInsets.only(top: 5.0),
                                              child: Text(
                                                  'Requirement: ${scoreController.employeeActivityDetail!.data![index].requirement}'),
                                            )
                                                : SizedBox(),
                                            widget.activityType ==
                                                'demo'
                                                ? Padding(
                                              padding: const EdgeInsets.only(top: 5.0),
                                              child: Text(
                                                  'Demo Status: ${scoreController.employeeActivityDetail!.data![index].demoStatus}'),
                                            )
                                                : SizedBox(),
                                            widget.activityType ==
                                                'feedback'
                                                ? Padding(
                                              padding: const EdgeInsets.only(top: 5.0),
                                              child: Text(
                                                  'Rating : ${scoreController.employeeActivityDetail!.data![index].rating}'),
                                            )
                                                : SizedBox(),
                                            widget.activityType ==
                                                'feedback'
                                                ? Padding(
                                              padding: const EdgeInsets.only(top: 5.0),
                                              child: Text(
                                                  'Remark : ${scoreController.employeeActivityDetail!.data![index].remark}'),
                                            )
                                                : SizedBox(),
                                            widget.activityType ==
                                                'payment_collect'
                                                ? Padding(
                                              padding: const EdgeInsets.only(top: 5.0),
                                              child: Text(
                                                  'Payment Collected : Rs.${scoreController.employeeActivityDetail!.data![index].orderAmount}'),
                                            )
                                                : SizedBox(),

                                          ],
                                        ),
                                      ),
                                    ));
                              }),
                        ),
            );
          });
  }
}
