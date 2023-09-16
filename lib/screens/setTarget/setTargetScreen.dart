import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmers/constant/app_constants.dart';
import 'package:shimmers/controllers/targetController.dart';
import 'package:shimmers/screens/setTarget/employeeListWidget.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../constant/textConstant.dart';
import '../../model/employeeListModel.dart';
import '../noDataFound/noDataFoundScreen.dart';

class SetTargetScreen extends StatefulWidget {
  static const name = '/setTargetScreen';
  final String from;

  const SetTargetScreen({Key? key, required this.from}) : super(key: key);

  @override
  State<SetTargetScreen> createState() => _SetTargetScreenState();
}

class _SetTargetScreenState extends State<SetTargetScreen> {
  TextEditingController searchController = TextEditingController();
  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  EmployeeListModel? model;

  List<Members>? _searchResult;

  List<Members>? _userDetails;

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

  onSearchTextChanged(String text) async {
    _searchResult!.clear();
    if (text.isEmpty) {
      // _searchResult = _userDetails;
      setState(() {});
      return;
    }

    for (var members in _userDetails!) {
      if (members.name!.contains(text)) {
        _searchResult!.add(members);
      }
    }
    // for (var userDetail in _userDetails) {
    //   _searchResult.add(userDetail);
    // }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<TargetController>(builder: (targetController) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                centerTitle: true,
                title: Text(
                  widget.from == "target"
                      ? TextConstant.SetTarget
                      : TextConstant.Team,
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
                      targetController.isLoading && model == null
                          ? const Center(child: CircularProgressIndicator())
                          : model!.data!.members == null
                              ? const Center(
                                  child: NoDataFoundScreen(),
                                )
                              : _searchResult!.isNotEmpty ||
                                      searchController.text.isNotEmpty
                                  ? ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _searchResult!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return EmployeeListWidget(
                                          membersModel: _searchResult![index],
                                          from: widget.from,
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const Divider();
                                      },
                                    )
                                  : ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _userDetails!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return EmployeeListWidget(
                                          membersModel: _userDetails![index],
                                          from: widget.from,
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const Divider();
                                      },
                                    ),
                    ],
                  ),
                ),
              ),
            );
          });
  }
}
