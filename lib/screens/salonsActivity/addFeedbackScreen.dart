import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmers/model/feedBackPurposeModel.dart';
import 'package:shimmers/screens/salonsActivity/feedbackPurposeScreen.dart';

import '../../constant/app_constants.dart';
import '../../constant/colorsConstant.dart';
import '../../constant/custom_snackbar.dart';
import '../../constant/globalFunction.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../constant/textConstant.dart';
import '../../controllers/salonController.dart';

class AddFeedBackScreen extends StatefulWidget {
  static const String name = 'takeFeedbackScreen';
  final String salonId;
  final String salonName;
  final String salonAddress;

  const AddFeedBackScreen(
      {Key? key,
      required this.salonId,
      required this.salonName,
      required this.salonAddress})
      : super(key: key);

  @override
  State<AddFeedBackScreen> createState() => _AddFeedBackScreenState();
}

class _AddFeedBackScreenState extends State<AddFeedBackScreen> {
  TextEditingController remarksController = TextEditingController();
  String feedbackPurpose = '', feedbackPurposeId = '';
  List<String> ratingList = ['NA', 'Good', 'average', 'unacceptable'];
  String? selectedRating;
  XFile? _pickedFile;

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
        _currentAddress = ' ${place.locality}, ${place.postalCode}';
        // locationController.text = _currentAddress!;
        // isLoaded = true;

        // Get.find<SalonController>().getSalonRouteList(
        //     latitude: lat.toString(), longitude: longi.toString(), type: "existing");

        Get.find<SalonController>().getSalonRouteList(
            latitude: "16.69537730",
            longitude: "74.24120130",
            type: "existing");

        print(lat.toString() + longi.toString());
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

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
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<SalonController>(builder: (salonController) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                centerTitle: true,
                title: Text(
                  TextConstant.takeFeedback,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 25),
                  child: Column(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 15),
                          color: Colors.grey.shade300,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.salonName,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                widget.salonAddress,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 25,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            TextConstant.selectPurpose,
                            style: const TextStyle(
                                color: primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => const FeedbackPurposeScreen(),
                            backgroundColor: Colors.transparent,
                          ).then((value) => {
                                setState(() {
                                  FeedbackData model = value;
                                  feedbackPurpose = model.feedbackType!;
                                  feedbackPurposeId = model.id!.toString();
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: primaryColor)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    feedbackPurpose == ''
                                        ? TextConstant.selectPurpose
                                        : feedbackPurpose,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                )),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.grey.shade700,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            TextConstant.remarks,
                            style: const TextStyle(
                                color: primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        style: const TextStyle(fontSize: 14),
                        maxLines: 5,
                        decoration: GlobalFunctions.getInputDecoration(
                            TextConstant.remarks),
                        controller: remarksController,
                        keyboardType: TextInputType.text,
                        onSaved: (value) {
                          remarksController.text = value as String;
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            TextConstant.rating,
                            style: const TextStyle(
                                color: primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              isExpanded: true,
                              value: selectedRating,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedRating = newValue;
                                });
                              },
                              items: ratingList.map((ratingType) {
                                return DropdownMenuItem(
                                  child: new Text(ratingType),
                                  value: ratingType,
                                );
                              }).toList()),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            TextConstant.takePhoto,
                            style: const TextStyle(
                                color: primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          pickImageCamera();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: primaryColor)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    _pickedFile == null
                                        ? TextConstant.clickPicture
                                        : _pickedFile!.name,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                )),
                                Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey.shade700,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 35),
                      SizedBox(
                        width: 200,
                        child: salonController.isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          primaryColor),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          primaryColor),
                                  textStyle:
                                      MaterialStateProperty.all<TextStyle>(
                                    const TextStyle(fontSize: 16),
                                  ),
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  if (feedbackPurposeId.isEmpty) {
                                    showCustomSnackBar(
                                        TextConstant.selectPurpose,
                                        isError: false);
                                  } else if (selectedRating == null) {
                                    showCustomSnackBar('Select Rating',
                                        isError: false);
                                  } else if (_pickedFile == null) {
                                    showCustomSnackBar(
                                        TextConstant.clickPicture,
                                        isError: false);
                                  } else {
                                    addFeedBack(
                                        salonController,
                                        feedbackPurposeId,
                                        widget.salonId,
                                        selectedRating,
                                        remarksController.text,
                                        lat.toString(),
                                        longi.toString(),
                                        Get.find<SalonController>().getonTour(),
                                        _pickedFile);
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
                ),
              ),
            );
          });
  }

  void pickImageCamera() async {
    _pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: _pickedFile!.path,
      aspectRatioPresets: [
        // CropAspectRatioPreset.square,
        // CropAspectRatioPreset.ratio3x2,
        // CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        // CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: primaryColor,
            toolbarWidgetColor: Colors.white,
            hideBottomControls: true,
            // initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
      compressQuality: 100,
    );

    _pickedFile = XFile(croppedFile!.path);
    setState(() {});
  }

  Future<void> addFeedBack(
      SalonController salonController,
      String? feedbackTypeId,
      String? salonId,
      String? rating,
      String? remark,
      String? latitude,
      String? longitude,
      String? is_on_tour,
      XFile? image) async {
    salonController
        .addFeedback(
            salonId: widget.salonId,
            feedbackTypeId: feedbackTypeId,
            rating: rating,
            remark: remark,
            latitude: latitude,
            longitude: longitude,
        is_on_tour: is_on_tour,
            image: image)
        .then((message) async {
      if (message == 'Feedback inserted successfully') {
        showCustomSnackBar(message!, isError: false);
        Navigator.pop(context);
      } else {
        showCustomSnackBar(message!);
      }
    });
  }
}
