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
import '../../constant/route_helper.dart';
import '../../constant/textConstant.dart';
import '../../controllers/scoreController.dart';
import '../../model/employeeActivityDetail.dart';

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
  TextEditingController searchController = TextEditingController();
  EmployeeActivityDetail? employeeActivityDetail;
  List<ActivityTypeDetails>? activityTypeDetailsList;
  List<ActivityTypeDetails>? _searchResult;

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
    getEmployeeActivityDetail();
  }

  Future<void> getEmployeeActivityDetail() async {
    activityTypeDetailsList = [];
    _searchResult = [];
    employeeActivityDetail = await Get.find<ScoreController>()
        .employeeactivityDetails(
            user_id: widget.userId,
            activityType: widget.activityType,
            fromDate: widget.fromDate,
            toDate: widget.toDate);

    activityTypeDetailsList = employeeActivityDetail!.data!;

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
                  widget.activityType == 'salon_created'
                      ? 'Salon Created List'
                      : widget.activityType == 'salon_visit'
                          ? 'Salon Visited List'
                          : widget.activityType == 'salon_order_value'
                              ? 'Salon Order Value'
                              : widget.activityType == 'demo'
                                  ? 'Demo List'
                                  : widget.activityType == 'feedback'
                                      ? 'Feedback List'
                                      : 'Payment Collected List',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 25),
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
                          : scoreController.employeeActivityDetail!.data ==
                                      null ||
                                  scoreController
                                      .employeeActivityDetail!.data!.isEmpty
                              ? Center(
                                  child: SizedBox(
                                      height: MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                      child: const NoDataFoundScreen()))
                              : _searchResult!.isNotEmpty ||
                                      searchController.text.isNotEmpty
                                  ? Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: _searchResult!.length,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemBuilder:
                                              (BuildContext context, int index) {
                                            return Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 5),
                                                child: InkWell(
                                                  onTap: ()
                                                  {
                                                    Get.toNamed(
                                                        RouteHelper.getSalonDetailsRoute(_searchResult![index].salonId.toString()));
                                                  },
                                                  child: Card(
                                                    elevation: 5,
                                                    shadowColor: primaryColor,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(5)),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: 18,
                                                          vertical: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              'Salon Name: ${_searchResult![index].salonName}'),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                              'Salon Mobile: ${_searchResult![index].mobile}'),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                              'Salon Location: ${_searchResult![index].address}'),
                                                          widget.activityType ==
                                                                  'salon_order_value'
                                                              ? Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          top: 5.0),
                                                                  child: Text(
                                                                      'Salon Order Value: Rs.${_searchResult![index].orderAmount}'),
                                                                )
                                                              : SizedBox(),
                                                          widget.activityType ==
                                                                  'demo'
                                                              ? Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          top: 5.0),
                                                                  child: Text(
                                                                      'Demo Date: ${_searchResult![index].demoDate}'),
                                                                )
                                                              : SizedBox(),
                                                          widget.activityType ==
                                                                  'demo'
                                                              ? Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          top: 5.0),
                                                                  child: Text(
                                                                      'Demo Time: ${_searchResult![index].demoTime}'),
                                                                )
                                                              : SizedBox(),
                                                          widget.activityType ==
                                                                  'demo'
                                                              ? Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          top: 5.0),
                                                                  child: Text(
                                                                      'Requirement: ${_searchResult![index].requirement}'),
                                                                )
                                                              : SizedBox(),
                                                          widget.activityType ==
                                                                  'demo'
                                                              ? Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          top: 5.0),
                                                                  child: Text(
                                                                      'Demo Status: ${_searchResult![index].demoStatus}'),
                                                                )
                                                              : SizedBox(),
                                                          widget.activityType ==
                                                                  'feedback'
                                                              ? Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          top: 5.0),
                                                                  child: Text(
                                                                      'Rating : ${_searchResult![index].rating}'),
                                                                )
                                                              : SizedBox(),
                                                          widget.activityType ==
                                                                  'feedback'
                                                              ? Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          top: 5.0),
                                                                  child: Text(
                                                                      'Remark : ${_searchResult![index].remark}'),
                                                                )
                                                              : SizedBox(),
                                                          widget.activityType ==
                                                                  'payment_collect'
                                                              ? Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          top: 5.0),
                                                                  child: Text(
                                                                      'Payment Collected : Rs.${_searchResult![index].orderAmount}'),
                                                                )
                                                              : SizedBox(),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ));
                                          }),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: scoreController
                                              .employeeActivityDetail!
                                              .data!
                                              .length,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemBuilder:
                                              (BuildContext context, int index) {
                                            return Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 5),
                                                child: InkWell(
                                                  onTap: ()
                                                  {
                                                    Get.toNamed(
                                                        RouteHelper.getSalonDetailsRoute(scoreController.employeeActivityDetail!.data![index].salonId.toString()));
                                                  },
                                                  child: Card(
                                                    elevation: 5,
                                                    shadowColor: primaryColor,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(5)),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: 18,
                                                          vertical: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              'Salon Name: ${scoreController.employeeActivityDetail!.data![index].salonName}'),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                              'Salon Mobile: ${scoreController.employeeActivityDetail!.data![index].mobile}'),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                              'Salon Location: ${scoreController.employeeActivityDetail!.data![index].address}'),
                                                          widget.activityType ==
                                                                  'salon_order_value'
                                                              ? Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          top: 5.0),
                                                                  child: Text(
                                                                      'Salon Order Value: Rs.${scoreController.employeeActivityDetail!.data![index].orderAmount}'),
                                                                )
                                                              : SizedBox(),
                                                          widget.activityType ==
                                                                  'demo'
                                                              ? Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          top: 5.0),
                                                                  child: Text(
                                                                      'Demo Date: ${scoreController.employeeActivityDetail!.data![index].demoDate}'),
                                                                )
                                                              : SizedBox(),
                                                          widget.activityType ==
                                                                  'demo'
                                                              ? Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          top: 5.0),
                                                                  child: Text(
                                                                      'Demo Time: ${scoreController.employeeActivityDetail!.data![index].demoTime}'),
                                                                )
                                                              : SizedBox(),
                                                          widget.activityType ==
                                                                  'demo'
                                                              ? Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          top: 5.0),
                                                                  child: Text(
                                                                      'Requirement: ${scoreController.employeeActivityDetail!.data![index].requirement}'),
                                                                )
                                                              : SizedBox(),
                                                          widget.activityType ==
                                                                  'demo'
                                                              ? Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          top: 5.0),
                                                                  child: Text(
                                                                      'Demo Status: ${scoreController.employeeActivityDetail!.data![index].demoStatus}'),
                                                                )
                                                              : SizedBox(),
                                                          widget.activityType ==
                                                                  'feedback'
                                                              ? Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          top: 5.0),
                                                                  child: Text(
                                                                      'Rating : ${scoreController.employeeActivityDetail!.data![index].rating}'),
                                                                )
                                                              : SizedBox(),
                                                          widget.activityType ==
                                                                  'feedback'
                                                              ? Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          top: 5.0),
                                                                  child: Text(
                                                                      'Remark : ${scoreController.employeeActivityDetail!.data![index].remark}'),
                                                                )
                                                              : SizedBox(),
                                                          widget.activityType ==
                                                                  'payment_collect'
                                                              ? Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          top: 5.0),
                                                                  child: Text(
                                                                      'Payment Collected : Rs.${scoreController.employeeActivityDetail!.data![index].orderAmount}'),
                                                                )
                                                              : SizedBox(),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ));
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

    for (var members in activityTypeDetailsList!) {
      if (members.salonName!.toLowerCase().contains(text.toLowerCase())) {
        _searchResult!.add(members);
      }
    }
    // for (var userDetail in _userDetails) {
    //   _searchResult.add(userDetail);
    // }

    setState(() {});
  }
}
