import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shimmers/constant/colorsConstant.dart';
import 'package:shimmers/constant/textConstant.dart';
import 'package:shimmers/controllers/salonController.dart';
import 'package:shimmers/screens/salons/addSalon/addSalonBasicDetailsScreen.dart';

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

          Get.find<SalonController>().getSalonRouteList(
              latitude: lat.toString(),
              longitude: longi.toString(),
              type: "new");

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

  @override
  void initState() {
    super.initState();
    if (mounted) {
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
    return GetBuilder<SalonController>(builder: (salonController) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const AddSalonBasicDetailsScreen()));
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                salonController.isLoading ||
                        salonController.salonRouteModel == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: salonController
                            .salonRouteModel!.salonRouteData!.salons!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return LocationSalonsWidget(
                            model: salonController.salonRouteModel!
                                .salonRouteData!.salons![index],
                            position: index,
                          );
                        })
              ],
            ),
          ),
        ),
      );
    });
  }
}
