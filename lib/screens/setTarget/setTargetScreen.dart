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
import '../noDataFound/noDataFoundScreen.dart';

class SetTargetScreen extends StatefulWidget {
  static const name = '/setTargetScreen';

  const SetTargetScreen({Key? key}) : super(key: key);

  @override
  State<SetTargetScreen> createState() => _SetTargetScreenState();
}

class _SetTargetScreenState extends State<SetTargetScreen> {
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

    if (_connectionStatus != AppConstants.connectivityCheck) {
      Get.find<TargetController>().getEmployeeList();
    }
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
                  TextConstant.SetTarget,
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
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      targetController.isLoading &&
                              targetController.employeeListModel == null
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : targetController.employeeListModel!.data!.members ==
                                  null
                              ? const Center(
                                  child: NoDataFoundScreen(),
                                )
                              : ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: targetController
                                      .employeeListModel!.data!.members!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return EmployeeListWidget(
                                      membersModel: targetController
                                          .employeeListModel!
                                          .data!
                                          .members![index],
                                    );
                                  },
                                ),
                    ],
                  ),
                ),
              ),
            );

            // return Scaffold(
            //   appBar: AppBar(
            //     backgroundColor: primaryColor,
            //     centerTitle: true,
            //     title: Text(
            //       TextConstant.SetTarget,
            //       style: const TextStyle(
            //           color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            //     ),
            //   ),
            //   body: SingleChildScrollView(
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 40),
            //       child: Column(
            //         children: [
            //
            //           Align(
            //             alignment: Alignment.topLeft,
            //             child: Padding(
            //               padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //               child: Text(
            //                 TextConstant.selectEmployee,
            //                 style: const TextStyle(
            //                     color: primaryColor,
            //                     fontSize: 14,
            //                     fontWeight: FontWeight.bold),
            //               ),
            //             ),
            //           ),
            //           const SizedBox(
            //             height: 15,
            //           ),
            //           InkWell(
            //             onTap: () {
            //               // showModalBottomSheet(
            //               //   context: context,
            //               //   builder: (context) => LeaveTypeSheet(),
            //               //   backgroundColor: Colors.transparent,
            //               // ).then((value) => {
            //               //   setState(() {
            //               //     selectedLeaveType = value!;
            //               //   })
            //               // });
            //             },
            //             child: Container(
            //               decoration: BoxDecoration(
            //                 // boxShadow: const [
            //                 //   BoxShadow(
            //                 //     color: primaryColor,
            //                 //     blurRadius: 12.0, // soften the shadow
            //                 //     spreadRadius: 0.5, //extend the shadow
            //                 //     offset: Offset(
            //                 //       1.0, // Move to right 5  horizontally
            //                 //       1.0, // Move to bottom 5 Vertically
            //                 //     ),
            //                 //   )
            //                 // ],
            //                   color: Colors.white,
            //                   borderRadius: BorderRadius.circular(12),
            //                   border: Border.all(color: primaryColor)),
            //               child: Padding(
            //                 padding: const EdgeInsets.all(12.0),
            //                 child: Row(
            //                   children: [
            //                     Expanded(
            //                         child: Padding(
            //                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //                           child: Text(
            //                             TextConstant.selectEmployee,
            //                             style: const TextStyle(
            //                                 color: Colors.black, fontSize: 14),
            //                           ),
            //                         )),
            //                     Icon(
            //                       Icons.keyboard_arrow_down,
            //                       color: Colors.grey.shade700,
            //                     )
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           ),
            //           SizedBox(
            //             height: 35,
            //           ),
            //           Align(
            //             alignment: Alignment.topLeft,
            //             child: Padding(
            //               padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //               child: Text(
            //                 TextConstant.selectProduct,
            //                 style: const TextStyle(
            //                     color: primaryColor,
            //                     fontSize: 14,
            //                     fontWeight: FontWeight.bold),
            //               ),
            //             ),
            //           ),
            //           const SizedBox(
            //             height: 15,
            //           ),
            //           InkWell(
            //             onTap: () {
            //               // showModalBottomSheet(
            //               //   context: context,
            //               //   builder: (context) => LeaveTypeSheet(),
            //               //   backgroundColor: Colors.transparent,
            //               // ).then((value) => {
            //               //   setState(() {
            //               //     selectedLeaveType = value!;
            //               //   })
            //               // });
            //             },
            //             child: Container(
            //               decoration: BoxDecoration(
            //                 // boxShadow: const [
            //                 //   BoxShadow(
            //                 //     color: primaryColor,
            //                 //     blurRadius: 12.0, // soften the shadow
            //                 //     spreadRadius: 0.5, //extend the shadow
            //                 //     offset: Offset(
            //                 //       1.0, // Move to right 5  horizontally
            //                 //       1.0, // Move to bottom 5 Vertically
            //                 //     ),
            //                 //   )
            //                 // ],
            //                   color: Colors.white,
            //                   borderRadius: BorderRadius.circular(12),
            //                   border: Border.all(color: primaryColor)),
            //               child: Padding(
            //                 padding: const EdgeInsets.all(12.0),
            //                 child: Row(
            //                   children: [
            //                     Expanded(
            //                         child: Padding(
            //                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //                           child: Text(
            //                             TextConstant.selectProduct,
            //                             style: const TextStyle(
            //                                 color: Colors.black, fontSize: 14),
            //                           ),
            //                         )),
            //                     Icon(
            //                       Icons.keyboard_arrow_down,
            //                       color: Colors.grey.shade700,
            //                     )
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           ),
            //           const SizedBox(height: 40),
            //           SizedBox(
            //             width: 200,
            //             child: ElevatedButton(
            //                 style: ButtonStyle(
            //                   backgroundColor:
            //                   MaterialStateProperty.all<Color>(primaryColor),
            //                   foregroundColor:
            //                   MaterialStateProperty.all<Color>(primaryColor),
            //                   textStyle: MaterialStateProperty.all<TextStyle>(
            //                     const TextStyle(fontSize: 16),
            //                   ),
            //                   padding: MaterialStateProperty.all<EdgeInsets>(
            //                     const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //                   ),
            //                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //                     RoundedRectangleBorder(
            //                       borderRadius: BorderRadius.circular(10),
            //                     ),
            //                   ),
            //                 ),
            //                 onPressed: () {
            //                   // Navigator.of(context)
            //                   //     .push(MaterialPageRoute(
            //                   //   builder: (context) =>
            //                   //       MainScreen(),
            //                   // ));
            //                 },
            //                 child: Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: Text(
            //                     TextConstant.submit.toUpperCase(),
            //                     style: const TextStyle(
            //                         fontSize: 14,
            //                         color: Colors.white,
            //                         fontWeight: FontWeight.w500),
            //                   ),
            //                 )),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // );
          });
  }
}
