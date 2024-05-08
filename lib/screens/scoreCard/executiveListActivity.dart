import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shimmers/constant/app_constants.dart';
import 'package:shimmers/constant/no_internet_screen.dart';
import 'package:shimmers/controllers/authController.dart';
import 'package:shimmers/model/TRFExecutiveProfile.dart';
import 'package:shimmers/screens/scoreCard/scoreCardScreen.dart';
import 'package:shimmers/screens/tourVisit/executivesTourRequestList.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/internetConnectivity.dart';
import '../../controllers/targetController.dart';
import '../../controllers/tourController.dart';
import '../../model/employeeListModel.dart';
import '../noDataFound/noDataFoundScreen.dart';

class ExecutiveListActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExecutiveListActivity();
  }
}

class _ExecutiveListActivity extends State {
  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  TextEditingController searchController = TextEditingController();

 // List<TRFExecutiveProfileDetail>? _searchResult;
//  List<TRFExecutiveProfileDetail>? _executiveDetails;

  List<Members>? _userDetails;
  List<Members>? _searchResult;
  EmployeeListModel? model;



  TRFExecutiveProfile? trfExecutiveProfile;

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
    //getTrfExcutiveDetails();
    getEmployeeList();
  }
  Future<void> getEmployeeList() async {
    _userDetails = [];
    _searchResult = [];
    model = await Get.find<TargetController>().getEmployeeList();
    _userDetails = model!.data!.members!;
    // _searchResult = model!.data!.members!;

    if (mounted) {
      setState(() {});
    }
  }

 /* Future<void> getTrfExcutiveDetails() async {
    _executiveDetails = [];
    _searchResult = [];
    trfExecutiveProfile = await Get.find<TourController>().getExecutivesList();
    _executiveDetails = trfExecutiveProfile!.data!;
    // _searchResult = model!.data!.members!;

    if (mounted) {
      setState(() {});
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<TargetController>(builder: (targetController) {
      return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Text(
            'Executives List',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10.0, vertical: 25),
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
                  height: 20,
                ),
                ElevatedButton(
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
                          borderRadius:
                          BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ScoreCardScreen(excutive_id: Get.find<AuthController>().getUserId())));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'Check your Scorecard',
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                targetController.isLoading &&
                    model == null
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : model!.data!.members == null || model!.data!.members!.isEmpty
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
                        return (Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ScoreCardScreen(excutive_id: _searchResult![index]!.id.toString())));
                            },
                            child: Card(
                              elevation: 5,
                              shadowColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius.circular(
                                          5))),
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
                                      'Name: ${_searchResult![index].name!.toString()}',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                          fontWeight:
                                          FontWeight
                                              .w500),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Email: ${_searchResult![index].email!.toString()}',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                          fontWeight:
                                          FontWeight
                                              .w500),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Mobile: ${_searchResult![index].mobile!.toString()}',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                          fontWeight:
                                          FontWeight
                                              .w500),
                                    ),
                                  ],
                                ),
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
                      itemCount: _userDetails!.length,
                      physics:
                      const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context,
                          int index) {
                        return (Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: InkWell(
                            onTap: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen:  ScoreCardScreen(
                                    excutive_id: _userDetails![index]!.id.toString()),
                                withNavBar: false,
                              );
                             /* Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ScoreCardScreen(
                                              excutive_id: _executiveDetails![index]!.id.toString()),),);*/
                            },
                            child: Card(
                              elevation: 5,
                              shadowColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius.circular(
                                          5))),
                              child: Padding(
                                padding:
                                EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 10),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    Text(
                                      'Name: ${_userDetails![index].name!.toString()}',
                                      style: TextStyle(
                                          color:
                                          Colors.grey,
                                          fontSize: 14,
                                          fontWeight:
                                          FontWeight
                                              .w500),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Email: ${_userDetails![index].email!.toString()}',
                                      style: TextStyle(
                                          color:
                                          Colors.grey,
                                          fontSize: 14,
                                          fontWeight:
                                          FontWeight
                                              .w500),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Mobile: ${_userDetails![index].mobile!.toString()}',
                                      style: TextStyle(
                                          color:
                                          Colors.grey,
                                          fontSize: 14,
                                          fontWeight:
                                          FontWeight
                                              .w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ));
                      }),
                )
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

    for (var members in _userDetails!) {
      if (members.name!.toLowerCase().contains(text.toLowerCase())) {
        _searchResult!.add(members);
      }
    }
    // for (var userDetail in _userDetails) {
    //   _searchResult.add(userDetail);
    // }

    setState(() {});
  }

 /* onSearchTextChanged(String text) async {
    _searchResult!.clear();
    if (text.isEmpty) {
      // _searchResult = _userDetails;
      setState(() {});
      return;
    }

    for (var members in _executiveDetails!) {
      if (members.name!.toLowerCase().contains(text.toLowerCase())) {
        _searchResult!.add(members);
      }
    }
    // for (var userDetail in _userDetails) {
    //   _searchResult.add(userDetail);
    // }

    setState(() {});
  }*/
}
