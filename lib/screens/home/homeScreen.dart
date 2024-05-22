import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shimmers/constant/custom_snackbar.dart';
import 'package:shimmers/model/profileModel.dart';
import 'package:shimmers/screens/campaigns/campaignsListScreen.dart';
import 'package:shimmers/screens/distributors/distributorsScreen.dart';
import 'package:shimmers/screens/liveTracking/liveTrackingScreen.dart';
import 'package:shimmers/screens/salons/salonDetails/managerOrderApproval.dart';
import 'package:shimmers/screens/salons/salonList/salonListScreen.dart';
import 'package:shimmers/screens/scoreCard/executiveListActivity.dart';
import 'package:shimmers/screens/scoreCard/scoreCardScreen.dart';
import 'package:shimmers/screens/setTarget/setTargetScreen.dart';
import 'package:shimmers/screens/tourVisit/addExpensesScreen.dart';
import 'package:shimmers/screens/tourVisit/expensesListScreen.dart';
import 'package:shimmers/screens/tourVisit/headOfficerTourRequests.dart';
import 'package:shimmers/screens/tourVisit/tourListScreen.dart';
import 'package:shimmers/screens/tourVisit/tourVisitScreen.dart';
import 'package:shimmers/screens/tourVisit/trfExecutiveList.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/route_helper.dart';
import '../../constant/textConstant.dart';
import '../../controllers/authController.dart';

class HomeScreen extends StatefulWidget {
  static const String name = 'home';

  HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  ProfileModel? model;
  String username = 'Guest';
  String userRole = '';

  @override
  void initState() {
    super.initState();
    _handleLocationPermission();
    // _getCurrentPosition();
    userRole = Get.find<AuthController>().getUserRole();
    // _checkGps();
    if (mounted) {
      Future.delayed(Duration.zero, () async {
        Get.find<AuthController>()
            .getUserProfile()
            .then((userProfileModel) async {
          if (userProfileModel!.userProfile != null) {
            model = userProfileModel;
          } else {
            model = ProfileModel();
          }
        });
      });
    }
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text(
      //         'Location services are disabled. Please enable the services')));
      showDisabledDialog();
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      // openAppSettings();
      // if (permission == LocationPermission.denied) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(content: Text('Location permissions are denied')));
      //   return false;
      // }
      if (permission == LocationPermission.denied) {
        showCupertinoDialog(
          context: context,
          builder: (context) =>
              CupertinoAlertDialog(
                title: const Text('Location Permission Denied'),
                content:
                const Text('You need to enable location permission in setting'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: const Text('Cancel'),
                    onPressed: () {
                      if (Platform.isAndroid) {
                        exit(0);
                        //SystemNavigator.pop();
                        // Navigator.of(context).pop();
                        // Navigator.pop(context);
                      } else if (Platform.isIOS) {
                        // iOS-specific code
                        exit(0);
                        // SystemNavigator.pop();
                        // Navigator.of(context).pop();
                        // Navigator.pop(context);
                      }
                    },
                  ),
                  CupertinoDialogAction(
                    child: const Text('Setting'),
                    onPressed: () {
                      openAppSettings();
                      Navigator.of(context).pop(false);
                      SystemNavigator.pop();

                      // Future.delayed(const Duration(milliseconds: 2000), () {
                      //   SystemNavigator.pop();
                      // });
                    },
                  ),
                ],
              ),
        );
      }
      return false;
    }
    if (permission == LocationPermission.deniedForever) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text(
      //         'Location permissions are permanently denied, we cannot request permissions.')));

      // setState(() async {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        showCupertinoDialog(
          context: context,
          builder: (context) =>
              CupertinoAlertDialog(
                title: const Text('Location Permission Denied'),
                content:
                const Text('You need to enable location permission in setting'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: const Text('Cancel'),
                    onPressed: () {
                      if (Platform.isAndroid) {
                        exit(0);
                        //SystemNavigator.pop();
                        // Navigator.of(context).pop();
                        // Navigator.pop(context);
                      } else if (Platform.isIOS) {
                        // iOS-specific code
                        exit(0);
                        // SystemNavigator.pop();
                        // Navigator.of(context).pop();
                        // Navigator.pop(context);
                      }
                    },
                  ),
                  CupertinoDialogAction(
                    child: const Text('Setting'),
                    onPressed: () {
                      openAppSettings();
                      Navigator.of(context).pop(false);
                      SystemNavigator.pop();
                    },
                  ),
                ],
              ),
        );
      }

      return false;
    }
    return true;
  }

  void showDisabledDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Location Services Disabled'),
        content: const Text('You need to enable location services'),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text('Ok'),
            onPressed: () {
              if (Platform.isAndroid) {
                exit(0);
                //SystemNavigator.pop();
                // Navigator.of(context).pop();
                // Navigator.pop(context);
              } else if (Platform.isIOS) {
                // iOS-specific code
                exit(0);
                // SystemNavigator.pop();
                // Navigator.of(context).pop();
                // Navigator.pop(context);
              }
            },
          ),
          // CupertinoDialogAction(
          //   child: const Text('Setting'),
          //   onPressed: () {
          //     openAppSettings();
          //     Navigator.of(context).pop(false);
          //   },
          // ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: primaryColor,
          centerTitle: false,
          title: Text(
            authController.isLoading
                ? 'Hello!'
                : model == null
                    ? 'Hello!'
                    : 'Hello! ${model!.userProfile!.name!}',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              tooltip: 'Notifications',
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.logout_sharp,
                color: Colors.white,
              ),
              tooltip: 'Logout',
              onPressed: () {
                showDialog(
                    builder: (ctxt) {
                      return AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Do you Really want to logout?'),
                        actions: [
                          // The "Yes" button
                          TextButton(
                              onPressed: () {
                                Navigator.of(ctxt).pop();
                              },
                              child: const Text('Cancel')),
                          TextButton(
                              onPressed: () {
                                // Close the dialog
                                Navigator.of(ctxt).pop();
                                authController.clearSharedData();

                                Get.offAllNamed(RouteHelper.getLoginRoute());
                              },
                              child: const Text('Logout'))
                        ],
                      );
                    },
                    context: context);
              },
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SizedBox(
                    //   width: 200,
                    //   child: authController.isLoading
                    //       ? const Center(
                    //           child: CircularProgressIndicator(),
                    //         )
                    //       : ElevatedButton(
                    //           style: ButtonStyle(
                    //             backgroundColor:
                    //                 MaterialStateProperty.all<Color>(
                    //                     primaryColor),
                    //             foregroundColor:
                    //                 MaterialStateProperty.all<Color>(
                    //                     primaryColor),
                    //             textStyle: MaterialStateProperty.all<TextStyle>(
                    //               const TextStyle(fontSize: 16),
                    //             ),
                    //             padding: MaterialStateProperty.all<EdgeInsets>(
                    //               const EdgeInsets.symmetric(
                    //                   horizontal: 16, vertical: 8),
                    //             ),
                    //             shape: MaterialStateProperty.all<
                    //                 RoundedRectangleBorder>(
                    //               RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(10),
                    //               ),
                    //             ),
                    //           ),
                    //           onPressed: () async {
                    //             // bool hasPermission =
                    //             //     await _handleLocationPermission();
                    //             //
                    //             // if (hasPermission) {
                    //             //   _getCurrentPosition();
                    //             // } else {}
                    //           },
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Text(
                    //               TextConstant.punchIn.toUpperCase(),
                    //               style: const TextStyle(
                    //                   fontSize: 16,
                    //                   color: Colors.white,
                    //                   fontWeight: FontWeight.w500),
                    //             ),
                    //           )),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    IntrinsicHeight(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Center(
                              child: InkWell(
                                onTap: () {
                                  /* if (userRole == 'TRF Executive' ||
                                      userRole == 'TRF Manager') {
                                    showCustomSnackBar(
                                        'You dont have the permission to use this module',
                                        isError: true);
                                  }
                                  else {*/
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SalonListScreen()));
                                  // }
                                },
                                child: SizedBox(
                                  height: 135,
                                  width: 115,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Image.asset(
                                        'assets/images/hair-salon.png',
                                        width: 35,
                                        height: 35,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          TextConstant.Salon,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.clip,
                                          style: const TextStyle(
                                              color: primaryColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            VerticalDividerFadeUp(),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  /*if (userRole == 'TRF Executive' ||
                                      userRole == 'TRF Manager') {
                                    showCustomSnackBar(
                                        'You dont have the permission to use this module',
                                        isError: true);
                                  } else {*/
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          DistributorsScreen()));
                                  //   }
                                },
                                child: SizedBox(
                                  height: 135,
                                  width: 115,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Image.asset(
                                        'assets/images/distribution.png',
                                        width: 35,
                                        height: 35,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          TextConstant.Distributor,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.clip,
                                          style: const TextStyle(
                                              color: primaryColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            VerticalDividerFadeUp(),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  /* if (userRole == 'TRF Executive' ||
                                      userRole == 'TRF Manager') {
                                    showCustomSnackBar(
                                        'You dont have the permission to use this module',
                                        isError: true);
                                  } else {*/
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          CampaignsListScreen()));
                                  //  }
                                },
                                child: SizedBox(
                                  height: 135,
                                  width: 115,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Image.asset(
                                        'assets/images/digital-campaign.png',
                                        width: 35,
                                        height: 35,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          TextConstant.Campaigns,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.clip,
                                          style: const TextStyle(
                                              color: primaryColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    Divider(),
                    IntrinsicHeight(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Center(
                              child: InkWell(
                                onTap: () {
                                  if (userRole == 'sales_manager') {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SetTargetScreen(
                                                  from: 'target',
                                                )));
                                  } else {
                                    showCustomSnackBar(
                                        'You dont have the permission to use this module',
                                        isError: true);
                                  }
                                },
                                child: SizedBox(
                                  height: 135,
                                  width: 115,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Image.asset(
                                        'assets/images/target-audience.png',
                                        width: 35,
                                        height: 35,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          TextConstant.SetTarget,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.clip,
                                          style: const TextStyle(
                                              color: primaryColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            VerticalDivider(),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  //Call activity screen here
                                  showCustomSnackBar('Cooming soon!');
                                  /*Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ExecutiveListActivity()));*/
                                },
                                child: SizedBox(
                                  height: 135,
                                  width: 115,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Image.asset(
                                        'assets/images/mobile.png',
                                        width: 35,
                                        height: 35,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          TextConstant.Activity,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.clip,
                                          style: const TextStyle(
                                              color: primaryColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            VerticalDivider(),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  if (userRole == 'sales_manager') {
                                    //Sales Manager see the activities of sales executive
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ExecutiveListActivity()));
                                  } else {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ScoreCardScreen(
                                                    excutive_id: Get.find<
                                                            AuthController>()
                                                        .getUserId())));
                                  }
                                },
                                child: SizedBox(
                                  height: 135,
                                  width: 115,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Image.asset(
                                        'assets/images/student-grades.png',
                                        width: 35,
                                        height: 35,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          TextConstant.ScoreCardAnalytics,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.clip,
                                          style: const TextStyle(
                                              color: primaryColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    Divider(),
                    IntrinsicHeight(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Center(
                              child: InkWell(
                                onTap: () {
                                  /*if (userRole == 'TRF Executive' ||
                                      userRole == 'TRF Manager') {
                                    showCustomSnackBar(
                                        'You dont have the permission to use this module',
                                        isError: true);
                                  } else {
                                    //Go team page
                                  }*/
                                },
                                child: SizedBox(
                                  height: 135,
                                  width: 115,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Image.asset(
                                        'assets/images/partners.png',
                                        width: 35,
                                        height: 35,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          TextConstant.Team,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.clip,
                                          style: const TextStyle(
                                            color: primaryColor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            VerticalDivider(),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  if (userRole == 'sales_manager') {
                                    //Sales Manager Flow
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TRFExecutiveListScreen()));
                                  }
                                  /*else if (userRole == 'Head Officer') {
                                    //Head Officer Flow
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HeadOfficerTourRequests()));
                                  }*/
                                  else {
                                    //sales executive flow
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TourListScreen()));
                                  }
                                },
                                child: SizedBox(
                                  height: 135,
                                  width: 115,
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Image.asset(
                                        'assets/images/report.png',
                                        width: 35,
                                        height: 35,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          TextConstant.ReportTourVisit,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.clip,
                                          style: const TextStyle(
                                              color: primaryColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            VerticalDivider(),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  /*   if (userRole == 'TRF Executive' ||
                                      userRole == 'TRF Manager') {
                                    showCustomSnackBar(
                                        'You dont have the permission to use this module',
                                        isError: true);
                                  } else {
                                    //Go nca page
                                  }*/
                                },
                                child: SizedBox(
                                  height: 135,
                                  width: 115,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Image.asset(
                                        'assets/images/list.png',
                                        width: 35,
                                        height: 35,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          TextConstant.NCE,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                          style: const TextStyle(
                                              color: primaryColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    Divider(),
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Center(
                            child: InkWell(
                              onTap: () {
                                if (userRole == 'sales_manager') {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          ManagerOrderApproval()));
                                } else {
                                  showCustomSnackBar(
                                      'You dont have the permission to use this module',
                                      isError: true);
                                }
                              },
                              child: SizedBox(
                                height: 135,
                                width: 115,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Image.asset(
                                      'assets/images/order_list.png',
                                      width: 35,
                                      height: 35,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        'Order Approval',
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(
                                            color: primaryColor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          VerticalDividerFadeDown(),
                          Center(
                            child: InkWell(
                              onTap: () {
                                /* PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen:  ExpensesListScreen(),
                                  withNavBar: false,
                                );*/
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ExpensesListScreen()));

                                /*if (userRole == 'employee') {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ManagerOrderApproval()));
                                } else {
                                  showCustomSnackBar(
                                      'You dont have the permission to use this module',
                                      isError: true);
                                }*/
                              },
                              child: SizedBox(
                                height: 135,
                                width: 115,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Image.asset(
                                      'assets/images/expenses.png',
                                      width: 35,
                                      height: 35,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        'Expenses',
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(
                                            color: primaryColor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          VerticalDividerFadeDown(),
                          Center(
                            child: InkWell(
                              onTap: () {
                                if (userRole == 'sales_manager') {
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: LiveTrackingScreen(),
                                    withNavBar: false,
                                  );
                                } else {
                                  showCustomSnackBar(
                                      'You dont have the permission to use this module!');
                                }
                              },
                              child: SizedBox(
                                height: 135,
                                width: 115,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Image.asset(
                                      'assets/images/google_map.png',
                                      width: 35,
                                      height: 35,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        'Live Tracking',
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(
                                            color: primaryColor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ),
      );
    });
  }

  Widget VerticalDividerFadeUp() {
    return Container(
      // height: 20,
      width: 1,
      decoration: BoxDecoration(
        // border: Border(
        //   top: BorderSide(
        //     color: Colors.grey,
        //     width: 1.0,
        //   ),
        // ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white60,
            Colors.grey.shade300,
            Colors.grey.shade300,
            Colors.grey.shade300,
          ],
        ),
      ),
    );
  }

  Widget VerticalDividerFadeDown() {
    return Container(
      // height: 20,
      width: 1,
      decoration: BoxDecoration(
        // border: Border(
        //   top: BorderSide(
        //     color: Colors.grey,
        //     width: 1.0,
        //   ),
        // ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.grey.shade300,
            Colors.grey.shade300,
            Colors.grey.shade300,
            Colors.white,
          ],
        ),
      ),
    );
  }

  Widget VerticalDivider() {
    return Container(
      // height: 20,
      width: 1,
      decoration: BoxDecoration(
        // border: Border(
        //   top: BorderSide(
        //     color: Colors.grey,
        //     width: 1.0,
        //   ),
        // ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.grey.shade300,
            Colors.grey.shade300,
            Colors.grey.shade300,
          ],
        ),
      ),
    );
  }

  Widget Divider() {
    return Container(
      height: 1,
      // width: 1,
      decoration: BoxDecoration(
        // border: Border(
        //   top: BorderSide(
        //     color: Colors.grey,
        //     width: 1.0,
        //   ),
        // ),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.white,
            Colors.grey.shade300,
            Colors.grey.shade300,
            Colors.grey.shade300,
            Colors.white,
          ],
        ),
      ),
    );
  }
}
