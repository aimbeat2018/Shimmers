import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shimmers/screens/distributors/distributorSalonListWidget.dart';

import '../../constant/app_constants.dart';
import '../../constant/colorsConstant.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../controllers/distributorController.dart';
import '../noDataFound/noDataFoundScreen.dart';

class DistributorWiseSalonScreen extends StatefulWidget {
  static const String name = 'distributorWiseSalonScreen';
  final String distributorName;
  final String id;

  const DistributorWiseSalonScreen(
      {Key? key, required this.distributorName, required this.id})
      : super(key: key);

  @override
  State<DistributorWiseSalonScreen> createState() =>
      _DistributorWiseSalonScreenState();
}

class _DistributorWiseSalonScreenState
    extends State<DistributorWiseSalonScreen> {
  String? _currentAddress;
  double? lat, longi;
  Position? _currentPosition;
  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

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
      _currentPosition = position;
      if (mounted) {
        setState(() {});
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
      lat = _currentPosition!.latitude;
      longi = _currentPosition!.longitude;
      /*, ${place.subAdministrativeArea}*/
      _currentAddress = ' ${place.locality}, ${place.postalCode}';

      // Get.find<DistributorController>().getDistributorSalonList(
      //     latitude: lat.toString(), longitude: longi.toString());
      Get.find<DistributorController>()
          .getDistributorSalonList(latitude: "0.00", longitude: "0.00");

      print(lat.toString() + longi.toString());
      if (mounted) {
        setState(() {});
      }
    }).catchError((e) {
      debugPrint(e);
    });
  }

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
        _getCurrentPosition();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<DistributorController>(builder: (distributorController) {
            return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
                backgroundColor: primaryColor,
                centerTitle: true,
                title: Text(
                  widget.distributorName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: distributorController.isLoading &&
                      distributorController.distributorSalonListModel == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : distributorController.distributorSalonListModel!.data ==
                              null ||
                          distributorController
                              .distributorSalonListModel!.data!.isEmpty
                      ? Center(
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: const NoDataFoundScreen()))
                      : ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: distributorController
                              .distributorSalonListModel!
                              .data![0]
                              .salons!
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            return DistributorSalonListWidget(
                              model: distributorController
                                  .distributorSalonListModel!
                                  .data![0]
                                  .salons![index],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              color: primaryColor.withOpacity(0.5),
                            );
                          },
                        ),
            );
          });
  }
}
