import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shimmers/constant/colorsConstant.dart';
import 'package:shimmers/constant/textConstant.dart';
import 'package:shimmers/controllers/salonController.dart';
import 'package:shimmers/screens/salons/addSalon/addSalonBasicDetailsScreen.dart';

import '../../../constant/app_constants.dart';
import '../../../constant/internetConnectivity.dart';
import '../../../constant/no_internet_screen.dart';
import '../../../constant/route_helper.dart';
import '../../../model/salonListModel.dart';
import '../../noDataFound/noDataFoundScreen.dart';
import 'package:flutter/cupertino.dart';
import 'listWidget/locationSalonsWidget.dart';

class NewSalonsScreen extends StatefulWidget {
  const NewSalonsScreen({Key? key}) : super(key: key);

  @override
  State<NewSalonsScreen> createState() => _NewSalonsScreenState();
}

class _NewSalonsScreenState extends State<NewSalonsScreen> {
  int selectedTile = -1;

  String? _currentAddress;
  double? lat, longi;
  Position? _currentPosition;
  bool isExpanded = false;
  TextEditingController searchController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  bool isLoadingMain = false;
  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  int page = 1;
  List<SalonDetailModel> salonList = [];
  List<SalonDetailModel> newSalonList = [];

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

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      if (mounted) {
        setState(() {
          _currentPosition = position;
        });
      }
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e!);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      if (mounted) {
        setState(() {
          lat = _currentPosition!.latitude;
          longi = _currentPosition!.longitude;
          /*, ${place.subAdministrativeArea}*/
          _currentAddress = ' ${place.locality}, ${place.postalCode}';
          // locationController.text = _currentAddress!;
          // isLoaded = true;
          fetchsalonData(true);
          /*  //Commented on 30-04
        Get.find<SalonController>().getSalonRouteList(
              latitude: lat.toString(),
              longitude: longi.toString(),
              type: "new",
              key: "",
              start: "1");*/

          // Get.find<SalonController>().getSalonRouteList(
          //     latitude: "16.69537730",
          //     longitude: "74.24120130",
          //     type: "existing");

          print(lat.toString() + longi.toString());
        });
      }
    }).catchError((e) {
      debugPrint(e);
    });
  }

  void fetchsalonData(bool? isLoading) {
    if (mounted) {
      Future.delayed(Duration.zero, () async {
        setState(() {
          if (page != 1) {
            isLoadingMain = true;
          }
        });

        await Get.find<SalonController>()
            .getSalonRouteList(
                latitude: lat.toString(),
                longitude: longi.toString(),
                type: "new",
                key: searchController.text,
                start: page.toString())
            .then((value) => setState(() {
                  if (page == 1) {
                    salonList = value!.salondetailData!;
                  } else {
                    newSalonList = [];
                    newSalonList = value!.salondetailData!;

                    if (newSalonList.isNotEmpty) {
                      salonList.addAll(newSalonList);
                      salonList = salonList.toSet().toList();
                    }
                  }
                  // apiStatus = value.status!;
                  page++;
                  //  requestData['page'] = page.toString();
                  isLoadingMain = false;
                }));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      CheckInternet.initConnectivity().then((value) => setState(() {
            _connectionStatus = value;
          }));
      _connectivitySubscription = _connectivity.onConnectivityChanged
          .listen((ConnectivityResult result) {
        CheckInternet.updateConnectionStatus(result)
            .then((value) => setState(() {
                  _connectionStatus = value;
                }));
      });
      _scrollController.addListener(_scrollListener);
      Future.delayed(Duration.zero, () async {
        _getCurrentPosition();

        //     .then((salonRouteModel) async {
        //   if (salonRouteModel!.salonRouteData != null) {
        //     model = userProfileModel;
        //   } else {
        //     model = ProfileModel();
        //   }
        // });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<SalonController>(builder: (salonController) {
            return Scaffold(
              body: SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 15),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: AddSalonBasicDetailsScreen(),
                            withNavBar: false,
                          );
                          /* Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const AddSalonBasicDetailsScreen()));*/
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: primaryColor),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    TextConstant.addSalon,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: searchController,
                        style: const TextStyle(fontSize: 14),
                        decoration: InputDecoration(
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
                            suffixIcon: InkWell(
                              onTap: () {
                                fetchsalonData(false);
                              },
                              child: Icon(
                                CupertinoIcons.search,
                                size: 28,
                              ),
                            )),
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          fetchsalonData(false);
                        },
                        //    onChanged: onSearchTextChanged,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      salonController.isLoading ||
                              salonController.salonListModel == null
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height / 1.5,
                              width: MediaQuery.of(context).size.width,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : salonController.salonListModel!.salondetailData ==
                                      null ||
                                  salonController
                                      .salonListModel!.salondetailData!.isEmpty
                              ? Center(
                                  child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.5,
                                      width: MediaQuery.of(context).size.width,
                                      child: const NoDataFoundScreen()))
                              : ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: salonController
                                      .salonListModel!.salondetailData!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        Container(
                                          margin: isExpanded
                                              ? EdgeInsets.only(
                                                  left: 8, right: 8, top: 5)
                                              : EdgeInsets.only(
                                                  left: 8,
                                                  right: 8,
                                                  top: 5,
                                                  bottom: 15),
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: primaryColor,
                                                blurRadius:
                                                    5.0, // soften the shadow
                                                spreadRadius:
                                                    0.1, //extend the shadow
                                                offset: Offset(
                                                  1.5, // Move to right 5  horizontally
                                                  1.5, // Move to bottom 5 Vertically
                                                ),
                                              )
                                            ],
                                            color: isExpanded
                                                ? primaryColor
                                                : kBackgroundColor,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(height: 10),
                                              Text(
                                                salonController
                                                            .salonListModel!
                                                            .salondetailData![
                                                                index]
                                                            .distributorName ==
                                                        null
                                                    ? "Distributor Name"
                                                    : "${salonController.salonListModel!.salondetailData![index].distributorName!}",
                                                style: TextStyle(
                                                    color: primaryColor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Get.toNamed(RouteHelper
                                                      .getSalonDetailsRoute(
                                                          salonController
                                                              .salonListModel!
                                                              .salondetailData![
                                                                  index]
                                                              .id!
                                                              .toString()));
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 15),
                                                  child: Row(
                                                    children: [
                                                      salonController
                                                                  .salonListModel!
                                                                  .salondetailData![
                                                                      index]
                                                                  .image ==
                                                              ""
                                                          ? Image.asset(
                                                              'assets/images/avatar.png',
                                                              height: 50,
                                                              width: 50,
                                                            )
                                                          : Image.network(
                                                              salonController
                                                                  .salonListModel!
                                                                  .salondetailData![
                                                                      index]
                                                                  .image!,
                                                              height: 50,
                                                              width: 50,
                                                              errorBuilder:
                                                                  (context,
                                                                      exception,
                                                                      stackTrace) {
                                                                return Image
                                                                    .asset(
                                                                  'assets/images/avatar.png',
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  height: 50,
                                                                  width: 50,
                                                                );
                                                              },
                                                            ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              salonController
                                                                  .salonListModel!
                                                                  .salondetailData![
                                                                      index]
                                                                  .name!,
                                                              style: TextStyle(
                                                                  color:
                                                                      primaryColor,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              salonController
                                                                  .salonListModel!
                                                                  .salondetailData![
                                                                      index]
                                                                  .address!,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: Container(
                                                          decoration: const BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              5)),
                                                              color:
                                                                  primaryColor),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        5.0,
                                                                    vertical:
                                                                        8),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                const Icon(
                                                                  Icons
                                                                      .location_on,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 13,
                                                                ),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  '${salonController.salonListModel!.salondetailData![index].distance!} Away',
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          11,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );

                                    /*LocationSalonsWidget(
                                model: salonController.salonRouteModel!
                                    .salonRouteData!.salons![index],
                                position: index,
                              );*/
                                  })
                    ],
                  ),
                ),
              ),
            );
          });
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (!isLoadingMain) {
        fetchsalonData(false);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _connectivitySubscription.cancel();
  }
}
