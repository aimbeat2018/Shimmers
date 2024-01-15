import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmers/constant/app_constants.dart';
import 'package:shimmers/constant/custom_snackbar.dart';
import 'package:shimmers/controllers/scoreController.dart';
import 'package:shimmers/screens/salons/salonDetails/salonDetailsScreen.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../constant/textConstant.dart';
import '../../model/liveTrackingModel.dart';

class LiveTrackingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LiveTrackingScreen();
  }
}

class _LiveTrackingScreen extends State<LiveTrackingScreen> {
  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  Position? _currentPosition;
 // LatLng currentLatLng;
  double? lat, longi;
  String? _currentAddress;
  late GoogleMapController mapController;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  LatLng? currentLatLng;
  LiveTrackingModel? trackingModel;
  List<LiveTrackList>? liveTrackList;

  List<Marker> _marker = [];


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
        _getLiveEmpList();
       /* Get.find<ScoreController>().getLiveTrackingList();
        _marker.addAll(_list);*/
      });
    }
  }

  Future<void> _getLiveEmpList() async {
    trackingModel = await Get.find<ScoreController>().getLiveTrackingList();
    liveTrackList = trackingModel!.data!;
    if(trackingModel!.data!.isEmpty){
      showCustomSnackBar('No executive is live today!');
    }
    liveTrackList!.forEach((element) {
      _marker.add(Marker(
          markerId: MarkerId(element.salonName!),
          draggable: false,
          onTap: () {
            print(element.salonId);
          },
          position:
              LatLng(double.parse(element.latitude!), double.parse(element.longitude!)),
          infoWindow: InfoWindow(
            title: element.name!,
            snippet: element.salonName!,
          )));
    });
    setState(() {

    });
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
                    'Live Tracking',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  actions: [
                    InkWell(
                      onTap: () {
                        _getLiveEmpList();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.refresh,
                          size: 25,
                        ),
                      ),
                    )
                  ],
                ),
                body: scoreController.isLoading || currentLatLng==null
                    ? Center(child: CircularProgressIndicator())
                    : Container(
                        // on below line creating google maps.
                        child: GoogleMap(
                          // on below line setting camera position
                          initialCameraPosition: CameraPosition(
                            target: currentLatLng!,
                            //LatLng(19.076090, 72.877426),
                            zoom: 12,
                          ),
                          // on below line specifying map type.
                          mapType: MapType.normal,
                          markers: Set<Marker>.of(_marker),
                          // on below line setting user location enabled.
                          myLocationEnabled: true,
                          // on below line setting compass enabled.
                          compassEnabled: true,
                          // on below line specifying controller on map complete.
                          onMapCreated: _onMapCreated,
                        ),
                      )
                );
          });
  }

  /*Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }*/

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude), 14));
    setState(() {
      _controller.complete();
    });
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        currentLatLng= LatLng(position.latitude, position.longitude);
      });
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
      setState(() {
        lat = _currentPosition!.latitude;
        longi = _currentPosition!.longitude;
        /*, ${place.subAdministrativeArea}*/
        _currentAddress = ' ${place.locality}, ${place.postalCode}';
        // locationController.text = _currentAddress!;
        // isLoaded = true;

        // Get.find<SalonController>().getSalonRouteList(
        //     latitude: lat.toString(), longitude: longi.toString(), type: "existing");
        print(lat.toString() + longi.toString());
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
