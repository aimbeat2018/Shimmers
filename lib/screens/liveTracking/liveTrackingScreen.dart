import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/textConstant.dart';

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
  double? lat, longi;
  String? _currentAddress;
  late GoogleMapController mapController;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const LatLng _center = const LatLng(19.076090, 72.877426);
  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  List<Marker> _marker = [];
  final List<Marker> _list = const [
    // List of Markers Added on Google Map
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(20.42796133580664, 80.885749655962),
        infoWindow: InfoWindow(
          title: 'My Position',
        )
    ),

    Marker(
        markerId: MarkerId('2'),
        position: LatLng(25.42796133580664, 80.885749655962),
        infoWindow: InfoWindow(
          title: 'Location 1',
        )
    ),

    Marker(
        markerId: MarkerId('3'),
        position: LatLng(20.42796133580664, 73.885749655962),
        infoWindow: InfoWindow(
          title: 'Location 2',
        )
    ),
  ];

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
        _marker.addAll(_list);

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'Live Tracking',
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
        body: Container(
          // on below line creating google maps.
          child: GoogleMap(
            // on below line setting camera position
            initialCameraPosition: const CameraPosition(
              target: _center,
              //LatLng(19.076090, 72.877426),
               zoom: 11,
            ),
            // on below line specifying map type.
            mapType: MapType.normal,
            markers: Set<Marker>.of(_marker),
            // on below line setting user location enabled.
            myLocationEnabled: true,
            // on below line setting compass enabled.
            compassEnabled: true,
            // on below line specifying controller on map complete.
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
          ),
        )
      /*floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),*/
    );
  }
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude), 14));
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
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
