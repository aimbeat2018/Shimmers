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
import '../../model/employeeActivityDetail.dart';
import '../../model/employeeTargetDetail.dart';
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
  TextEditingController searchController = TextEditingController();
  EmployeeTargetDetail? employeeTargetDetail;
  List<EmployeeTargetList>? _searchResult;
  List<EmployeeTargetList>? employeeTargetList;


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
    getEmployeeTargetDetails();
   /* if (mounted) {
      Future.delayed(Duration.zero, () async {
        Get.find<ScoreController>().employeeTargetDetails(
            user_id: widget.user_id,
            activityType: widget.activity_type,
            fromDate: widget.from_date,
            toDate: widget.to_date);
      });
    }*/
  }
  Future<void> getEmployeeTargetDetails() async {
    employeeTargetList = [];
    _searchResult = [];
    employeeTargetDetail = await Get.find<ScoreController>().employeeTargetDetails(
        user_id: widget.user_id,
        activityType: widget.activity_type,
        fromDate: widget.from_date,
        toDate: widget.to_date);

    employeeTargetList = employeeTargetDetail!.data!;

    if (mounted) {
      setState(() {});
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
                  'Target Details List',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 10),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: searchController,
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(12.0)),
                              borderSide:
                              BorderSide(color: primaryColor, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(12.0)),
                              borderSide:
                              BorderSide(color: primaryColor, width: 1),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            hintText: 'Search',
                            suffixIcon: Icon(
                              CupertinoIcons.search,
                              size: 28,
                            )),
                        keyboardType: TextInputType.text,
                        // onChanged: (value) {
                        //   onSearchTextChanged(value);
                        // },
                        onChanged: onSearchTextChanged,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      scoreController.isLoading
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
                                      itemCount: scoreController
                                          .employeeTargetDetail!.data!.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 5),
                                          child: Card(
                                            elevation: 5,
                                            shadowColor: primaryColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
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
                    ],
                  ),
                ),
              ),
            );
          });
  }
  onSearchTextChanged(String text) async {
    _searchResult!.clear();
    if (text.isEmpty) {
      // _searchResult = _userDetails;
      setState(() {});
      return;
    }

    for (var members in employeeTargetList!) {
      if (members.productName!.toLowerCase().contains(text.toLowerCase())) {
        _searchResult!.add(members);
      }
    }
    // for (var userDetail in _userDetails) {
    //   _searchResult.add(userDetail);
    // }

    setState(() {});
  }
}
