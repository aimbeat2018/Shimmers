import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../constant/app_constants.dart';
import '../../constant/colorsConstant.dart';
import '../../constant/custom_snackbar.dart';
import '../../constant/globalFunction.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../constant/textConstant.dart';
import '../../controllers/salonController.dart';

class CollectPaymentScreen extends StatefulWidget {
  static const String name = 'collectPaymentScreen';
  final String salonId;
  final String salonName;
  final String salonAddress;

  const CollectPaymentScreen(
      {Key? key,
      required this.salonId,
      required this.salonName,
      required this.salonAddress})
      : super(key: key);

  @override
  State<CollectPaymentScreen> createState() => _CollectPaymentScreenState();
}

class _CollectPaymentScreenState extends State<CollectPaymentScreen> {
  TextEditingController referenceNumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  List<String> modeList = [
    'Select mode of payment',
    'Cheque',
    'Draft',
    'Cash',
    'NEFT',
    'RTGS',
    'Other'
  ];
  String? selectedMode;
  XFile? _pickedFile;

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
                  TextConstant.collectPayment,
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
                            TextConstant.modeOfPayment,
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
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: primaryColor)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                isExpanded: true,
                                value: selectedMode,
                                onChanged: (modeValue) {
                                  setState(() {
                                    selectedMode = modeValue;
                                  });
                                },
                                items: modeList.map((modeValue) {
                                  return DropdownMenuItem(
                                    child: Text(modeValue),
                                    value: modeValue,
                                  );
                                }).toList()),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      if (selectedMode != 'Cash')
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  selectedMode == 'Cheque'
                                      ? TextConstant.chequeNumber
                                      : selectedMode == 'Draft'
                                          ? TextConstant.draftNumber
                                          : TextConstant.referenceNumber,
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
                              maxLines: 1,
                              decoration: GlobalFunctions.getInputDecoration(
                                selectedMode == 'Cheque'
                                    ? TextConstant.chequeNumber
                                    : selectedMode == 'Draft'
                                        ? TextConstant.draftNumber
                                        : TextConstant.referenceNumber,
                              ),
                              controller: referenceNumberController,
                              keyboardType: TextInputType.text,
                              onSaved: (value) {
                                referenceNumberController.text =
                                    value as String;
                              },
                            ),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            TextConstant.amount,
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
                        maxLines: 1,
                        decoration: GlobalFunctions.getInputDecoration(
                            TextConstant.amount),
                        controller: amountController,
                        keyboardType: TextInputType.text,
                        onSaved: (value) {
                          amountController.text = value as String;
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
                            ? const Center(
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
                                  if (selectedMode == "") {
                                    showCustomSnackBar("Select payment mode",
                                        isError: true);
                                  } else if (selectedMode == "Cash") {
                                    if (amountController.text.isEmpty) {
                                      showCustomSnackBar("Enter amount",
                                          isError: true);
                                    } else if (_pickedFile == null) {
                                      showCustomSnackBar("Click picture",
                                          isError: true);
                                    } else {
                                      collectPayment(
                                          salonController,
                                          selectedMode!,
                                          "",
                                          amountController.text,
                                          _pickedFile!);
                                    }
                                  } else {
                                    if (referenceNumberController
                                        .text.isEmpty) {
                                      if (selectedMode == "Draft") {
                                        showCustomSnackBar("Enter Draft Number",
                                            isError: true);
                                      } else if (selectedMode == "Cheque") {
                                        showCustomSnackBar(
                                            "Enter Cheque Number",
                                            isError: true);
                                      } else {
                                        showCustomSnackBar(
                                            "Enter Reference Number",
                                            isError: true);
                                      }
                                    } else if (amountController.text.isEmpty) {
                                      showCustomSnackBar("Enter amount",
                                          isError: true);
                                    } else if (_pickedFile == null) {
                                      showCustomSnackBar("Click picture",
                                          isError: true);
                                    } else {
                                      collectPayment(
                                          salonController,
                                          selectedMode!,
                                          referenceNumberController.text,
                                          amountController.text,
                                          _pickedFile!);
                                    }
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

  Future<void> collectPayment(
      SalonController salonController,
      String paymentMode,
      String referenceNumber,
      String amount,
      XFile image) async {
    salonController
        .collectPayment(
            salonId: widget.salonId,
            paymentMode: paymentMode,
            referenceNumber: referenceNumber,
            amount: amount,
            image: image)
        .then((message) async {
      if (message == 'Payment collected successfully.') {
        showCustomSnackBar(message!, isError: false);
        Navigator.pop(context);
      } else {
        showCustomSnackBar(message!);
      }
    });
  }
}
