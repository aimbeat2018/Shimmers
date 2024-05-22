import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmers/constant/custom_snackbar.dart';
import 'package:shimmers/model/employeeRouteListModel.dart';
import 'package:shimmers/screens/home/mainScreen.dart';
import 'package:shimmers/screens/salons/addSalon/bottomSheet/salonRouteScreen.dart';

import '../../../constant/colorsConstant.dart';
import '../../../constant/globalFunction.dart';
import '../../../constant/textConstant.dart';
import '../../../controllers/salonController.dart';
import 'bottomSheet/salonSubCitySheet.dart';

class AddFinalSalonScreen extends StatefulWidget {
  static const String name = 'addSalonFinalScreen';
  final XFile salonImage;
  final String mobileNumber;
  final String email;
  final String gstNumber;
  final String categoryName;
  final String salonName;
  final String custType;
  final String brandId;
  final String beatrouteId;

  const AddFinalSalonScreen(
      {Key? key,
      required this.salonImage,
      required this.mobileNumber,
      required this.email,
      required this.gstNumber,
      required this.categoryName,
      required this.salonName,
      required this.custType,
      required this.brandId,
      required this.beatrouteId})
      : super(key: key);

  @override
  State<AddFinalSalonScreen> createState() => _AddFinalSalonScreenState();
}

class _AddFinalSalonScreenState extends State<AddFinalSalonScreen> {
  showBackDialog(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(TextConstant.backTitle),
          content: Text(TextConstant.backDescription),
          actions: [
            TextButton(
              child: Text(TextConstant.cancel),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(TextConstant.yes),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(parentContext);
              },
            )
          ],
        );
      },
    );
  }

  TextEditingController contactPersonMobileController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();
  TextEditingController shippingAddressController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController contactPersonNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<String> _locations = ['New', 'Existing']; // Option 2
  String? _selectedLocation; // Option 2
  String? _currentAddress,
      country,
      city,
      state,
      pincode,
      salonRouteId = "",
      salonRoute = "";
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
      setState(() {
        _currentPosition = position;
      });
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
      setState(() {
        lat = _currentPosition!.latitude;
        longi = _currentPosition!.longitude;
        /*, ${place.subAdministrativeArea}*/
        _currentAddress =
            ' ${place.name}, ${place.street}, ${place.subLocality}, ${place.locality}';

        pincode = place.postalCode;
        country = place.country;
        state = place.administrativeArea;
        city = place.subLocality;

        pincodeController.text = pincode!;
        countryController.text = country!;
        stateController.text = state!;
        cityController.text = city!;

        companyAddressController.text = _currentAddress!;
        // isLoaded = true;

        // Get.find<SalonController>().getSalonRouteList(
        //     latitude: lat.toString(), longitude: longi.toString(), type: "existing");

        print(lat.toString() + longi.toString());
      });
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
        // Get.find<SalonController>().getEmpRouteList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalonController>(builder: (salonController) {
      return WillPopScope(
          child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.white, //change your color here
              ),
              backgroundColor: primaryColor,
              centerTitle: true,
              title: Text(
                TextConstant.addSalon,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: _currentAddress == null
                ? Center(
                    child: CircularProgressIndicator(),
                    /* child: SizedBox(
                      height: 200.0,
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                strokeWidth: 5,
                                value: 1.0,
                              ),
                            ),
                          ),
                          Center(
                              child: Text(
                                  "Please Wait..Fetching Current Location!")),
                        ],
                      ),
                    ),*/
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25.0, horizontal: 15),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 200.0,
                              child: Row(
                                children: [
                                  const Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: primaryColor,
                                        size: 24.0,
                                      ),
                                      Text(
                                        '1',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 50.0,
                                    child: Divider(
                                      color: Colors.grey.shade300,
                                      thickness: 1.5,
                                    ),
                                  ),
                                  const Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: primaryColor,
                                        size: 24.0,
                                      ),
                                      Text(
                                        '2',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 50.0,
                                    child: Divider(
                                      color: Colors.grey.shade300,
                                      thickness: 1.5,
                                    ),
                                  ),
                                  const Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: primaryColor,
                                        size: 24.0,
                                      ),
                                      Text(
                                        '3',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: RichText(
                                          text: TextSpan(
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                              children: <TextSpan>[
                                            TextSpan(
                                              text: TextConstant.pincode,
                                            ),
                                            TextSpan(
                                              text: ' *',
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ]))),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    // boxShadow: const [
                                    //   BoxShadow(
                                    //     color: primaryColor,
                                    //     blurRadius: 12.0, // soften the shadow
                                    //     spreadRadius: 0.5, //extend the shadow
                                    //     offset: Offset(
                                    //       1.0, // Move to right 5  horizontally
                                    //       1.0, // Move to bottom 5 Vertically
                                    //     ),
                                    //   )
                                    // ],
                                    border: Border.all(color: primaryColor),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: TextFormField(
                                    style: const TextStyle(fontSize: 14),
                                    enabled: false,
                                    decoration:
                                        GlobalFunctions.getInputDecorationWhite(
                                            ""),
                                    controller: pincodeController,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: RichText(
                                          text: TextSpan(
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                              children: <TextSpan>[
                                            TextSpan(
                                              text: TextConstant.companyAddress,
                                            ),
                                            TextSpan(
                                              text: ' *',
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ]))),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    // boxShadow: const [
                                    //   BoxShadow(
                                    //     color: primaryColor,
                                    //     blurRadius: 12.0, // soften the shadow
                                    //     spreadRadius: 0.5, //extend the shadow
                                    //     offset: Offset(
                                    //       1.0, // Move to right 5  horizontally
                                    //       1.0, // Move to bottom 5 Vertically
                                    //     ),
                                    //   )
                                    // ],
                                    border: Border.all(color: primaryColor),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: TextFormField(
                                    style: const TextStyle(fontSize: 14),
                                    decoration:
                                        GlobalFunctions.getInputDecorationWhite(
                                            ""),
                                    controller: companyAddressController,
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: RichText(
                                          text: TextSpan(
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                              children: <TextSpan>[
                                            TextSpan(
                                              text: TextConstant.country,
                                            ),
                                            TextSpan(
                                              text: ' *',
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ]))),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    // boxShadow: const [
                                    //   BoxShadow(
                                    //     color: primaryColor,
                                    //     blurRadius: 12.0, // soften the shadow
                                    //     spreadRadius: 0.5, //extend the shadow
                                    //     offset: Offset(
                                    //       1.0, // Move to right 5  horizontally
                                    //       1.0, // Move to bottom 5 Vertically
                                    //     ),
                                    //   )
                                    // ],
                                    border: Border.all(color: primaryColor),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: TextFormField(
                                    style: const TextStyle(fontSize: 14),
                                    enabled: false,
                                    decoration:
                                        GlobalFunctions.getInputDecorationWhite(
                                            ""),
                                    controller: countryController,
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: RichText(
                                          text: TextSpan(
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                              children: <TextSpan>[
                                            TextSpan(
                                              text: TextConstant.state,
                                            ),
                                            TextSpan(
                                              text: ' *',
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ]))),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    // boxShadow: const [
                                    //   BoxShadow(
                                    //     color: primaryColor,
                                    //     blurRadius: 12.0, // soften the shadow
                                    //     spreadRadius: 0.5, //extend the shadow
                                    //     offset: Offset(
                                    //       1.0, // Move to right 5  horizontally
                                    //       1.0, // Move to bottom 5 Vertically
                                    //     ),
                                    //   )
                                    // ],
                                    border: Border.all(color: primaryColor),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: TextFormField(
                                    style: const TextStyle(fontSize: 14),
                                    enabled: true,
                                    decoration:
                                        GlobalFunctions.getInputDecorationWhite(
                                            ""),
                                    controller: stateController,
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: RichText(
                                          text: TextSpan(
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                              children: <TextSpan>[
                                            TextSpan(
                                              text: TextConstant.city,
                                            ),
                                            TextSpan(
                                              text: ' *',
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ]))),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    // boxShadow: const [
                                    //   BoxShadow(
                                    //     color: primaryColor,
                                    //     blurRadius: 12.0, // soften the shadow
                                    //     spreadRadius: 0.5, //extend the shadow
                                    //     offset: Offset(
                                    //       1.0, // Move to right 5  horizontally
                                    //       1.0, // Move to bottom 5 Vertically
                                    //     ),
                                    //   )
                                    // ],
                                    border: Border.all(color: primaryColor),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: TextFormField(
                                    style: const TextStyle(fontSize: 14),
                                    enabled: true,
                                    decoration:
                                        GlobalFunctions.getInputDecorationWhite(
                                            ""),
                                    controller: cityController,
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: RichText(
                                          text: TextSpan(
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                              children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  TextConstant.shippingAddress,
                                            ),
                                            TextSpan(
                                              text: ' *',
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ]))),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    // boxShadow: const [
                                    //   BoxShadow(
                                    //     color: primaryColor,
                                    //     blurRadius: 12.0, // soften the shadow
                                    //     spreadRadius: 0.5, //extend the shadow
                                    //     offset: Offset(
                                    //       1.0, // Move to right 5  horizontally
                                    //       1.0, // Move to bottom 5 Vertically
                                    //     ),
                                    //   )
                                    // ],
                                    border: Border.all(color: primaryColor),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: TextFormField(
                                    style: const TextStyle(fontSize: 14),
                                    decoration:
                                        GlobalFunctions.getInputDecorationWhite(
                                            ""),
                                    controller: shippingAddressController,
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: RichText(
                                          text: TextSpan(
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                              children: <TextSpan>[
                                            TextSpan(
                                              text: TextConstant
                                                  .contactPersonName,
                                            ),
                                            TextSpan(
                                              text: ' *',
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ]))),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    // boxShadow: const [
                                    //   BoxShadow(
                                    //     color: primaryColor,
                                    //     blurRadius: 12.0, // soften the shadow
                                    //     spreadRadius: 0.5, //extend the shadow
                                    //     offset: Offset(
                                    //       1.0, // Move to right 5  horizontally
                                    //       1.0, // Move to bottom 5 Vertically
                                    //     ),
                                    //   )
                                    // ],
                                    border: Border.all(color: primaryColor),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: TextFormField(
                                    style: const TextStyle(fontSize: 14),
                                    decoration:
                                        GlobalFunctions.getInputDecorationWhite(
                                            ""),
                                    controller: contactPersonNameController,
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: RichText(
                                          text: TextSpan(
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                              children: <TextSpan>[
                                            TextSpan(
                                              text: TextConstant
                                                  .contactPersonNumber,
                                            ),
                                            TextSpan(
                                              text: ' *',
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ]))),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    // boxShadow: const [
                                    //   BoxShadow(
                                    //     color: primaryColor,
                                    //     blurRadius: 12.0, // soften the shadow
                                    //     spreadRadius: 0.5, //extend the shadow
                                    //     offset: Offset(
                                    //       1.0, // Move to right 5  horizontally
                                    //       1.0, // Move to bottom 5 Vertically
                                    //     ),
                                    //   )
                                    // ],
                                    border: Border.all(color: primaryColor),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: TextFormField(
                                    style: const TextStyle(fontSize: 14),
                                    decoration:
                                        GlobalFunctions.getInputDecorationWhite(
                                            ""),
                                    controller: contactPersonMobileController,
                                    inputFormatters: [
                                      new LengthLimitingTextInputFormatter(10),
                                    ],
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: RichText(
                                          text: TextSpan(
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                              children: <TextSpan>[
                                            TextSpan(
                                              text: TextConstant.Password,
                                            ),
                                            TextSpan(
                                              text: ' *',
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ]))),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    // boxShadow: const [
                                    //   BoxShadow(
                                    //     color: primaryColor,
                                    //     blurRadius: 12.0, // soften the shadow
                                    //     spreadRadius: 0.5, //extend the shadow
                                    //     offset: Offset(
                                    //       1.0, // Move to right 5  horizontally
                                    //       1.0, // Move to bottom 5 Vertically
                                    //     ),
                                    //   )
                                    // ],
                                    border: Border.all(color: primaryColor),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: TextFormField(
                                    obscureText: true,
                                    style: const TextStyle(fontSize: 14),
                                    decoration:
                                        GlobalFunctions.getInputDecorationWhite(
                                            ""),
                                    controller: passwordController,
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: RichText(
                                          text: TextSpan(
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                              children: <TextSpan>[
                                            TextSpan(
                                              text: TextConstant.salonType,
                                            ),
                                            TextSpan(
                                              text: ' *',
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ]))),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  decoration: BoxDecoration(
                                    // boxShadow: const [
                                    //   BoxShadow(
                                    //     color: primaryColor,
                                    //     blurRadius: 12.0, // soften the shadow
                                    //     spreadRadius: 0.5, //extend the shadow
                                    //     offset: Offset(
                                    //       1.0, // Move to right 5  horizontally
                                    //       1.0, // Move to bottom 5 Vertically
                                    //     ),
                                    //   )
                                    // ],
                                    border: Border.all(color: primaryColor),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                        isExpanded: true,
                                        value: _selectedLocation,
                                        onChanged: (newValue) {
                                          setState(() {
                                            _selectedLocation = newValue;
                                          });
                                        },
                                        items: _locations.map((location) {
                                          return DropdownMenuItem(
                                            child: new Text(location),
                                            value: location,
                                          );
                                        }).toList()),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: RichText(
                                          text: TextSpan(
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                              children: <TextSpan>[
                                            TextSpan(
                                              text: TextConstant.city,
                                            ),
                                            TextSpan(
                                              text: ' *',
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ]))),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    /*showModalBottomSheet(
                                context: context,
                                builder: (context) => const SalonRouteScreen(),
                                backgroundColor: Colors.transparent,
                              ).then((empRouteModel) => {
                                setState(() {
                                  EmpRouteModel model = empRouteModel;
                                  salonRouteId = model.id.toString();
                                  salonRoute = model.name;
                                })
                              });*/
                                    //
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: MediaQuery.of(context).size.height*0.8,
                                            child: SalonSubCitySheet()
                                        );
                                      },
                                      backgroundColor: Colors.transparent,
                                    ).then((empRouteModel) => {
                                          setState(() {
                                            EmpRouteModel model = empRouteModel;
                                            salonRouteId = model.id.toString();
                                            salonRoute = model.name;
                                          })
                                        });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      // boxShadow: const [
                                      //   BoxShadow(
                                      //     color: primaryColor,
                                      //     blurRadius: 12.0, // soften the shadow
                                      //     spreadRadius: 0.5, //extend the shadow
                                      //     offset: Offset(
                                      //       1.0, // Move to right 5  horizontally
                                      //       1.0, // Move to bottom 5 Vertically
                                      //     ),
                                      //   )
                                      // ],
                                      border: Border.all(color: primaryColor),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              salonRoute == null
                                                  ? ""
                                                  : salonRoute!,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14),
                                            ),
                                          )),
                                          Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.grey.shade900,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                SizedBox(
                                  width: 200,
                                  // height: 45,
                                  child: salonController.isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(primaryColor),
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(primaryColor),
                                            textStyle: MaterialStateProperty
                                                .all<TextStyle>(
                                              const TextStyle(fontSize: 16),
                                            ),
                                            padding: MaterialStateProperty.all<
                                                EdgeInsets>(
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
                                            if (pincodeController
                                                .text.isEmpty) {
                                              showCustomSnackBar(
                                                  'Enter pincode',
                                                  isError: true);
                                            } else if (companyAddressController
                                                .text.isEmpty) {
                                              showCustomSnackBar(
                                                  'Enter Company Address',
                                                  isError: true);
                                            } else if (countryController
                                                .text.isEmpty) {
                                              showCustomSnackBar(
                                                  'Enter Country',
                                                  isError: true);
                                            } else if (stateController
                                                .text.isEmpty) {
                                              showCustomSnackBar('Enter State',
                                                  isError: true);
                                            } else if (cityController
                                                .text.isEmpty) {
                                              showCustomSnackBar('Enter City',
                                                  isError: true);
                                            } else if (shippingAddressController
                                                .text.isEmpty) {
                                              showCustomSnackBar(
                                                  'Enter Shipping Address',
                                                  isError: true);
                                            } else if (contactPersonNameController
                                                .text.isEmpty) {
                                              showCustomSnackBar(
                                                  'Enter Contact Person Name',
                                                  isError: true);
                                            } else if (contactPersonMobileController
                                                    .text.length !=
                                                10) {
                                              showCustomSnackBar(
                                                  'Enter Contact Person Mobile Number',
                                                  isError: true);
                                            } else if (passwordController
                                                .text.isEmpty) {
                                              showCustomSnackBar(
                                                  'Enter Password',
                                                  isError: true);
                                            } else if (_selectedLocation ==
                                                '') {
                                              showCustomSnackBar(
                                                  'Select Salon Type',
                                                  isError: true);
                                            } else if (salonRouteId == "") {
                                              showCustomSnackBar('Select Route',
                                                  isError: true);
                                            } else {
                                              //     showTourVisitDialog(context,salonController);
                                              addSalon(salonController);
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              TextConstant.submit.toUpperCase(),
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
          ),
          onWillPop: () async {
            return showBackDialog(context);
          });
    });
  }

  showTourVisitDialog(
      BuildContext parentContext, SalonController salonController) {
    showDialog(
      context: parentContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
            title: Text('Tour Visit '),
            content: Text('Are you on Tour Visit?'),
            actions: [
              TextButton(
                child: Text('No'),
                onPressed: () {
                  Get.find<SalonController>().setonTour('0');
                  addSalon(salonController);
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text(TextConstant.yes),
                onPressed: () {
                  Get.find<SalonController>().setonTour('1');
                  addSalon(salonController);
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> addSalon(SalonController salonController) async {
    salonController
        .addSalon(
      name: widget.salonName,
      password: passwordController.text,
      email: widget.email,
      location_id: salonRouteId,
      mobile: widget.mobileNumber,
      sub_category_id: widget.categoryName,
      gst_number: widget.gstNumber,
      country: countryController.text,
      shipping_address: shippingAddressController.text,
      postal_code: pincodeController.text,
      state: stateController.text,
      city: cityController.text,
      number: contactPersonMobileController.text,
      owner_name: contactPersonNameController.text,
      salon_type: _selectedLocation,
      latitude: lat.toString(),
      longitude: longi.toString(),
      address: companyAddressController.text,
      is_on_tour: '0',
      customer_sub_type: widget.custType,
      brand_id: widget.brandId,
      beatroute_id: widget.beatrouteId,
      image: widget.salonImage,
    )
        .then((message) async {
      if (message == 'Salon added successfully') {
        showCustomSnackBar(message!, isError: false);
        Navigator.pop(context);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MainScreen()));
      } else {
        showCustomSnackBar(message!);
      }
    });
  }
}
