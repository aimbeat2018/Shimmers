import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmers/screens/salons/addSalon/bottomSheet/salonTypeScreen.dart';
import 'package:shimmers/screens/salonsActivity/collectPaymentScreen.dart';
import 'package:shimmers/screens/salonsActivity/demo/demoListScreen.dart';
import 'package:shimmers/screens/salonsActivity/salonCampaignListScreen.dart';
import 'package:shimmers/screens/salonsActivity/takeNoteScreen.dart';
import 'package:shimmers/screens/salonsActivity/takeOrder/productListScreen.dart';

import '../../../constant/app_constants.dart';
import '../../../constant/colorsConstant.dart';
import '../../../constant/internetConnectivity.dart';
import '../../../constant/no_internet_screen.dart';
import '../../../constant/textConstant.dart';
import '../../../controllers/salonController.dart';
import '../../salonsActivity/addFeedbackScreen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../constant/custom_snackbar.dart';


class SalonDetailsScreen extends StatefulWidget {
  static const String name = 'salonDetailsScreen';
  final String salonId;

  const SalonDetailsScreen({Key? key, required this.salonId}) : super(key: key);

  @override
  State<SalonDetailsScreen> createState() => _SalonDetailsScreenState();
}

class _SalonDetailsScreenState extends State<SalonDetailsScreen> {
  bool isDetailsVisible = true;
  String salonType = "";
  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  Position? _currentPosition;
  String? _currentAddress;
  double? lat, longi;

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
        Get.find<SalonController>().getSalonDetails(widget.salonId);
        _getCurrentPosition();
      });
    }
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _currentPosition = position;
      if (mounted) {
        setState(() {});
      }
      // setState(() {});
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e!);
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
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
    }
    if (permission == LocationPermission.deniedForever) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text(
      //         'Location permissions are permanently denied, we cannot request permissions.')));

      // setState(() async {
      permission = await Geolocator.requestPermission();
      // });

      // openAppSettings();

      // return false;
    }
    return true;
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      lat = _currentPosition!.latitude;
      longi = _currentPosition!.longitude;
      /*, ${place.subAdministrativeArea}*/
      _currentAddress = ' ${place.locality}, ${place.postalCode}';
      // locationController.text = _currentAddress!;
      // isLoaded = true;

      print(lat.toString() + longi.toString());
      if (mounted) {
        setState(() {});
      }
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<SalonController>(builder: (salonController) {
            return Scaffold(
              backgroundColor: kBackgroundColor,
              appBar: AppBar(
                backgroundColor: primaryColor,
                title: Text(
                  TextConstant.Salon,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                actions: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      child: InkWell(
                        onTap: () {
                          if (salonController.salonDetailsModel != null) {
                            if (salonController
                                    .salonDetailsModel!.data!.is_clockin ==
                                1) {
                              Get.find<SalonController>()
                                  .salonwiseLogin(
                                      salonid: widget.salonId,
                                      lat: lat.toString(),
                                      long: longi.toString(),
                                      address: _currentAddress)
                                  .then((value) async {
                                if (value == 'Clock-out successfully.') {
                                  setState(() {
                                    salonController.salonDetailsModel!.data!
                                        .is_clockin = 0;
                                  });
                                }
                              });
                            } else {
                              Get.find<SalonController>()
                                  .salonwiseLogin(
                                      salonid: widget.salonId,
                                      lat: lat.toString(),
                                      long: longi.toString(),
                                      address: _currentAddress)
                                  .then((value) async {
                                if (value == 'Clock-in successfully.') {
                                  setState(() {
                                    salonController.salonDetailsModel!.data!
                                        .is_clockin = 1;
                                  });
                                }
                              });
                            }
                          } else {
                            Get.find<SalonController>()
                                .salonwiseLogin(
                                    salonid: widget.salonId,
                                    lat: lat.toString(),
                                    long: longi.toString(),
                                    address: _currentAddress)
                                .then((value) async {
                              if (value == 'Clock-in successfully.') {
                                setState(() {
                                  salonController
                                      .salonDetailsModel!.data!.is_clockin = 1;
                                });
                              }
                            });
                          }
                        },
                        child: Text(
                          salonController.salonDetailsModel == null
                              ? TextConstant.punchIn
                              : salonController.salonDetailsModel!.data!
                                          .is_clockin ==
                                      1
                                  ? TextConstant.punchOut
                                  : TextConstant.punchIn,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              body: salonController.isLoading ||
                      salonController.salonDetailsModel == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.28,
                            color: isDetailsVisible
                                ? primaryColor
                                : Colors.transparent,
                            child: Stack(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.25,
                                  child: Stack(
                                    children: [
                                      salonController.salonDetailsModel!.data!
                                                  .image ==
                                              ""
                                          ? Image.asset(
                                              'assets/images/avatar.png',
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.25,
                                              fit: BoxFit.fitWidth,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            )
                                          : Image.network(
                                              salonController.salonDetailsModel!
                                                  .data!.image!,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.25,
                                              fit: BoxFit.fitWidth,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
                                      Positioned.fill(
                                        child: Opacity(
                                          opacity: 0.3,
                                          child: Container(
                                            color: const Color(0xFF000000),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 20),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Expanded(
                                                  child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    salonController
                                                        .salonDetailsModel!
                                                        .data!
                                                        .name!,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  Text(
                                                    salonController
                                                        .salonDetailsModel!
                                                        .data!
                                                        .address!,
                                                    style: TextStyle(
                                                        color: Colors.white70,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  // const Text(
                                                  //   '5 Km Away',
                                                  //   style: TextStyle(
                                                  //       color: Colors.white70,
                                                  //       fontSize: 13,
                                                  //       fontWeight: FontWeight.w500),
                                                  // ),
                                                ],
                                              )),
                                              const Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Icon(
                                                    Icons.call,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: isDetailsVisible ? false : true,
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: FloatingActionButton(
                                      backgroundColor: Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          isDetailsVisible = !isDetailsVisible;
                                        });
                                      },
                                      child: const Icon(
                                        Icons.arrow_downward,
                                        color: primaryColor,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Visibility(
                            visible: isDetailsVisible ? true : false,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.34,
                              child: Stack(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.30,
                                    color: primaryColor,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 25, horizontal: 15),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: salonController
                                                      .salonDetailsModel!.data!.is_clockin ==
                                                  0
                                                      ? showCustomSnackBar(
                                                          "Please Punch In First",
                                                          isError: true)
                                                      : () => Navigator.of(
                                                              context)
                                                          .push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          DemoListScreen(
                                                                            model:
                                                                                salonController.salonDetailsModel!.data!,
                                                                          ))),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/demonstrate.png',
                                                    height: 28,
                                                    width: 28,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    TextConstant.demonstrate,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () => Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProductListScreen(
                                                            model: salonController
                                                                .salonDetailsModel!,
                                                          ))),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/take_order.png',
                                                    height: 28,
                                                    width: 28,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    TextConstant.takeOrder,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () => Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddFeedBackScreen(
                                                            salonId:
                                                                widget.salonId,
                                                            salonName:
                                                                salonController
                                                                    .salonDetailsModel!
                                                                    .data!
                                                                    .name!,
                                                            salonAddress:
                                                                salonController
                                                                    .salonDetailsModel!
                                                                    .data!
                                                                    .address!,
                                                          ))),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/take_feedback.png',
                                                    height: 28,
                                                    width: 28,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    TextConstant.takeFeedback,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () => Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          CollectPaymentScreen(
                                                            salonId:
                                                                widget.salonId,
                                                            salonName:
                                                                salonController
                                                                    .salonDetailsModel!
                                                                    .data!
                                                                    .name!,
                                                            salonAddress:
                                                                salonController
                                                                    .salonDetailsModel!
                                                                    .data!
                                                                    .address!,
                                                          ))),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/collect_payment.png',
                                                    height: 28,
                                                    width: 28,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    TextConstant.collectPayment,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  context: context,
                                                  builder: (context) =>
                                                      TakeNoteScreen(
                                                    salonId: widget.salonId,
                                                  ),
                                                  backgroundColor:
                                                      Colors.transparent,
                                                ).then((value) => {
                                                      setState(() {
                                                        salonController
                                                            .getSalonDetails(
                                                                widget.salonId);
                                                      })
                                                    });
                                              },
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/take_note.png',
                                                    height: 28,
                                                    width: 28,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    TextConstant.takeNote,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () => Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          SalonCampaignListScreen(
                                                            salonId: int.parse(
                                                                widget.salonId),
                                                          ))),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/report_campaign.png',
                                                    height: 28,
                                                    width: 28,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    TextConstant.reportCampaign,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        // Row(
                                        //   mainAxisAlignment: MainAxisAlignment.center,
                                        //   children: [
                                        //     Column(
                                        //       children: [
                                        //         Image.asset(
                                        //           'assets/images/take_stock.png',
                                        //           height: 28,
                                        //           width: 28,
                                        //         ),
                                        //         const SizedBox(
                                        //           height: 5,
                                        //         ),
                                        //         Text(
                                        //           TextConstant.updateStock,
                                        //           style: const TextStyle(
                                        //               color: Colors.white,
                                        //               fontSize: 13,
                                        //               fontWeight: FontWeight.w500),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: FloatingActionButton(
                                      backgroundColor: Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          isDetailsVisible = !isDetailsVisible;
                                        });
                                      },
                                      child: const Icon(
                                        Icons.arrow_upward,
                                        color: primaryColor,
                                        size: 25,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 15),
                            child: Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 10.0,
                                    left: 10.0,
                                    bottom: 30,
                                    top: 15),
                                child: Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Image.asset(
                                        'assets/images/schedule_salon.png',
                                        height: 25,
                                        width: 25,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          TextConstant.scheduleVisitsAndCalls,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          TextConstant
                                              .scheduleVisitsAndCallsMsg,
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          salonController.salonDetailsModel!
                                              .data!.scheduledCalls!
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10.0, left: 10.0, bottom: 15),
                            child: Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 10.0,
                                    left: 10.0,
                                    bottom: 30,
                                    top: 15),
                                child: Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Image.asset(
                                        'assets/images/recent_note.png',
                                        height: 25,
                                        width: 25,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          TextConstant.recentNotes,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          TextConstant.recentNotesMsg,
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        ListView.separated(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: salonController
                                              .salonDetailsModel!
                                              .data!
                                              .salonNotes!
                                              .length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 10),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 1.0,
                                                        vertical: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            salonController
                                                                .salonDetailsModel!
                                                                .data!
                                                                .salonNotes![
                                                                    index]
                                                                .details!,
                                                            style: const TextStyle(
                                                                color:
                                                                    primaryColor,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return Divider();
                                          },
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10.0, left: 10.0, bottom: 15),
                            child: Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 10.0,
                                    left: 10.0,
                                    bottom: 30,
                                    top: 15),
                                child: Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Image.asset(
                                        'assets/images/stage.png',
                                        height: 25,
                                        width: 25,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  SalonTypeScreen(
                                                salonId: widget.salonId,
                                              ),
                                              backgroundColor:
                                                  Colors.transparent,
                                            ).then((value) => {
                                                  setState(() {
                                                    salonType = value;
                                                  })
                                                });
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                TextConstant.stage,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const Icon(
                                                Icons.edit,
                                                color: primaryColor,
                                                size: 16,
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          salonType == ""
                                              ? salonController
                                                  .salonDetailsModel!
                                                  .data!
                                                  .stage!
                                              : salonType,
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10.0, left: 10.0, bottom: 15),
                            child: Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 10.0,
                                    left: 10.0,
                                    bottom: 30,
                                    top: 15),
                                child: Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Image.asset(
                                        'assets/images/outstanding_payment.png',
                                        height: 25,
                                        width: 25,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          TextConstant.outstandingPayment,
                                          style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          salonController
                                                      .salonDetailsModel!
                                                      .data!
                                                      .outstandingPayment ==
                                                  null
                                              ? '₹ 0.00'
                                              : '₹ ${salonController.salonDetailsModel!.data!.outstandingPayment!}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10.0, left: 10.0, bottom: 30),
                            child: Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 10.0,
                                    left: 10.0,
                                    bottom: 30,
                                    top: 15),
                                child: Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Image.asset(
                                        'assets/images/available_credit.png',
                                        height: 25,
                                        width: 25,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          TextConstant.availableCredit,
                                          style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          salonController.salonDetailsModel!
                                                      .data!.credit ==
                                                  null
                                              ? '₹ 0.00'
                                              : '₹ ${salonController.salonDetailsModel!.data!.credit!}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            );
          });
  }
}
