import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmers/constant/app_constants.dart';
import 'package:shimmers/constant/no_internet_screen.dart';
import 'package:shimmers/controllers/scoreController.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/internetConnectivity.dart';
import '../noDataFound/noDataFoundScreen.dart';

class EmployeeTargetDetailsScreen extends StatefulWidget {
  String user_id, activity_type, from_date, to_date;

  EmployeeTargetDetailsScreen(
      {required this.user_id,
      required this.activity_type,
      required this.from_date,
      required this.to_date});

  @override
  State<StatefulWidget> createState() {
    return _EmployeeTargetDetailsScreen();
  }
}

class _EmployeeTargetDetailsScreen extends State<EmployeeTargetDetailsScreen> {
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
    if (mounted) {
      Future.delayed(Duration.zero, () async {
        Get.find<ScoreController>().employeeTargetDetails(
            user_id: widget.user_id,
            activityType: widget.activity_type,
            fromDate: widget.from_date,
            toDate: widget.to_date);
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
                  : scoreController.employeeTargetDetail!.data == null &&
                          scoreController.employeeTargetDetail!.data!.isEmpty
                      ? Center(
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: const NoDataFoundScreen()))
                      : Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: scoreController.employeeTargetDetail!.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              child: Card(
                                elevation: 5,
                                shadowColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Product Name: ${scoreController.employeeTargetDetail!.data![index].productName}'),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          'Assigned Target: ${scoreController.employeeTargetDetail!.data![index].assignedTarget}'),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          'Completed Target: ${scoreController.employeeTargetDetail!.data![index].completedTarget}'),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          'Status: ${scoreController.employeeTargetDetail!.data![index].status}'),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
            );
          });
  }
}
