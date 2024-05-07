import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmers/constant/app_constants.dart';
import 'package:shimmers/constant/no_internet_screen.dart';
import 'package:shimmers/controllers/scoreController.dart';
import 'package:shimmers/screens/setTarget/brandwiseTargetDetails.dart';

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
  bool isExpanded = false;

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
    employeeTargetDetail = await Get.find<ScoreController>()
        .employeeTargetDetails(
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
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
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
                          : scoreController.employeeTargetDetail!.data ==
                                      null &&
                                  scoreController
                                      .employeeTargetDetail!.data!.isEmpty
                              ? Center(
                                  child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                      child: const NoDataFoundScreen()))
                              : _searchResult!.isNotEmpty ||
                                      searchController.text.isNotEmpty
                                  ? Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: _searchResult!.length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 8.0, horizontal: 10),
                                              child: Card(
                                                elevation: 5,
                                                color: _searchResult![index].brandTargetStatus == "pending"
                                                    ? Colors.red.shade50
                                                    : Colors.green.shade50,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.all(Radius.circular(10)),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 15.0, vertical: 8),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              'Brand Name: ${_searchResult![index].brandName}',
                                                              style: const TextStyle(
                                                                  color: primaryColor,
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.bold),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              'Brand Assigned Target: ${_searchResult![index].brandAssignedTarget}',
                                                              style: const TextStyle(
                                                                  color: primaryColor,
                                                                  fontSize: 13,
                                                                  fontWeight: FontWeight.w500),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              'Brand Completed Target: ${_searchResult![index].brandCompletedTarget}',
                                                              style: const TextStyle(
                                                                  color: primaryColor,
                                                                  fontSize: 13,
                                                                  fontWeight: FontWeight.w500),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              'Brand Target Status: ${_searchResult![index].brandTargetStatus!}',
                                                              style: TextStyle(
                                                                  color: _searchResult![index].brandTargetStatus ==
                                                                      "pending"
                                                                      ? Colors.red
                                                                      : Colors.green,
                                                                  fontSize: 13,
                                                                  fontWeight: FontWeight.w500),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.arrow_forward_ios_rounded,
                                                        color: Colors.grey,
                                                        size: 20,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: scoreController
                                              .employeeTargetDetail!
                                              .data!
                                              .length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 8.0, horizontal: 10),
                                              child: Card(
                                                elevation: 5,
                                                color: scoreController.employeeTargetDetail!.data![index].brandTargetStatus == "pending"
                                                    ? Colors.red.shade50
                                                    : Colors.green.shade50,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.all(Radius.circular(10)),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 15.0, vertical: 8),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              'Brand Name: ${scoreController.employeeTargetDetail!.data![index].brandName}',
                                                              style: const TextStyle(
                                                                  color: primaryColor,
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.bold),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              'Brand Assigned Target: ${scoreController.employeeTargetDetail!.data![index].brandAssignedTarget}',
                                                              style: const TextStyle(
                                                                  color: primaryColor,
                                                                  fontSize: 13,
                                                                  fontWeight: FontWeight.w500),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              'Brand Completed Target: ${scoreController.employeeTargetDetail!.data![index].brandCompletedTarget}',
                                                              style: const TextStyle(
                                                                  color: primaryColor,
                                                                  fontSize: 13,
                                                                  fontWeight: FontWeight.w500),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              'Brand Target Status: ${scoreController.employeeTargetDetail!.data![index].brandTargetStatus!}',
                                                              style: TextStyle(
                                                                  color: scoreController.employeeTargetDetail!.data![index].brandTargetStatus ==
                                                                      "pending"
                                                                      ? Colors.red
                                                                      : Colors.green,
                                                                  fontSize: 13,
                                                                  fontWeight: FontWeight.w500),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: (){
                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>BrandwiseTargetDetails(productList: scoreController.employeeTargetDetail!.data![index].productData!,brandName: scoreController.employeeTargetDetail!.data![index].brandName,)));
                                                        },
                                                        child: Icon(
                                                          Icons.arrow_forward_ios_rounded,
                                                          color: Colors.grey,
                                                          size: 20,
                                                        ),
                                                      )
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
      if (members.brandName!.toLowerCase().contains(text.toLowerCase())) {
        _searchResult!.add(members);
      }
    }
    // for (var userDetail in _userDetails) {
    //   _searchResult.add(userDetail);
    // }

    setState(() {});
  }
}
