import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmers/screens/noDataFound/noDataFoundScreen.dart';

import '../../constant/app_constants.dart';
import '../../constant/colorsConstant.dart';
import '../../constant/custom_snackbar.dart';
import '../../constant/globalFunction.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../constant/route_helper.dart';
import '../../constant/textConstant.dart';
import '../../controllers/tourController.dart';
import '../../model/tourdetailsByIdModel.dart';

class ExecutiveTourRequestDetails extends StatefulWidget {
  String tour_requestid;

  ExecutiveTourRequestDetails({required this.tour_requestid});

  @override
  State<StatefulWidget> createState() {
    return _ExecutiveTourRequestDetails();
  }
}

class _ExecutiveTourRequestDetails extends State<ExecutiveTourRequestDetails> {
  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  TourDetailsByIdModel? tourDetailsByIdModel;
  List<String> statusList = ['Select Status', 'Approve', 'Reject'];
  String? selectedStatus = 'Select Status';
  XFile? _pickedFile;

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
    if (widget.tour_requestid! != '0') {
      if (_connectionStatus != AppConstants.connectivityCheck) {
        if (mounted) {
          Future.delayed(Duration.zero, () async {
            tourDetailsByIdModel = await Get.find<TourController>()
                .getTourDetailsByid(
                    tour_reqid: widget.tour_requestid.toString());
            /* if (tourDetailsByIdModel != null) {
              // remarksController.text=tourDetailsByIdModel!.data![0].remark!;
              tourDetailsByIdModel!.data![0].executiveRemark == null ||
                  tourDetailsByIdModel!.data![0].executiveRemark! == ''
                  ? remarksController.text = ''
                  : remarksController.text =
              tourDetailsByIdModel!.data![0].executiveRemark!;
              purposeController.text = tourDetailsByIdModel!.data![0].purpose!;
              areaController.text =
                  tourDetailsByIdModel!.data![0].area!.toString();
              amountController.text =
                  tourDetailsByIdModel!.data![0].amount!.toString();
              selectedDate = tourDetailsByIdModel!.data![0].date!;
              selectedTime = tourDetailsByIdModel!.data![0].time!;
            }*/
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController remarksController = TextEditingController();
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<TourController>(builder: (tourController) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                centerTitle: true,
                title: Text(
                  'Tour Request Details',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: tourController.isLoading && tourDetailsByIdModel == null
                  ? const Center(child: CircularProgressIndicator())
                  : tourDetailsByIdModel!.data == null ||
                          tourDetailsByIdModel!.data!.isEmpty
                      ? Center(
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: const NoDataFoundScreen()))
                      : SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 20),
                            child: Column(
                              children: [
                                Card(
                                  elevation: 2,
                                  shadowColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18.0, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Area: ${tourDetailsByIdModel!.data![0].area!}',
                                                style: TextStyle(
                                                    color: primaryColor,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Date: ${tourDetailsByIdModel!.data![0].date!}',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              'Time: ${tourDetailsByIdModel!.data![0].time!}',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Purpose: ${tourDetailsByIdModel!.data![0].purpose!}',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                       /* Text(
                                          'Description: ${tourDetailsByIdModel!.data![0].description}',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),*/
                                        Text(
                                          'Amount: ${tourDetailsByIdModel!.data![0].amount!.toString()}',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Status: ${tourDetailsByIdModel!.data![0].status! == 0 ? 'Pending' : tourDetailsByIdModel!.data![0].status! == 1 ? 'Approved' : 'Rejected'}',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        tourDetailsByIdModel!.data![0]
                                                        .executiveRemark ==
                                                    null ||
                                                tourDetailsByIdModel!.data![0]
                                                        .executiveRemark ==
                                                    ''
                                            ? SizedBox()
                                            : Text(
                                                'Executive Remark: ${tourDetailsByIdModel!.data![0].executiveRemark!}',
                                                // 'Remark: ${widget.model.remark ??'vff':widget.model.remark}',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                        tourDetailsByIdModel!.data![0].remark ==
                                                    null ||
                                                tourDetailsByIdModel!
                                                        .data![0].remark ==
                                                    ''
                                            ? SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5.0),
                                                child: Text(
                                                  'Manager Remark: ${tourDetailsByIdModel!.data![0].remark}',
                                                  // 'Remark: ${widget.model.remark ??'vff':widget.model.remark}',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      'Status',
                                      style: const TextStyle(
                                          color: primaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: primaryColor)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                          isExpanded: true,
                                          value: selectedStatus,
                                          onChanged: (modeValue) {
                                            setState(() {
                                              selectedStatus = modeValue;
                                            });
                                          },
                                          items: statusList.map((modeValue) {
                                            return DropdownMenuItem(
                                              child: Text(
                                                modeValue,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                              ),
                                              value: modeValue,
                                            );
                                          }).toList()),
                                    ),
                                  ),
                                ),
                               /* SizedBox(
                                  height: 15,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
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
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    // pickImageCamera();
                                    selectImageDialog(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border:
                                            Border.all(color: primaryColor)),
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
                                                  color: Colors.black,
                                                  fontSize: 14),
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
                                ),*/
                                SizedBox(
                                  height: 15,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
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
                                  height: 10,
                                ),
                                TextFormField(
                                  style: const TextStyle(fontSize: 14),
                                  maxLines: 5,
                                  decoration:
                                      GlobalFunctions.getInputDecoration(
                                          TextConstant.remarks),
                                  controller: remarksController,
                                  keyboardType: TextInputType.text,
                                  onSaved: (value) {
                                    remarksController.text = value as String;
                                  },
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                SizedBox(
                                  width: 200,
                                  child: tourController.isLoading
                                      ? Center(
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
                                            if (selectedStatus == "" ||
                                                selectedStatus == null ||
                                                selectedStatus ==
                                                    'Select Status') {
                                              showCustomSnackBar(
                                                  "Select Status",
                                                  isError: false);
                                            }/* else if (_pickedFile == null) {
                                              showCustomSnackBar(
                                                  TextConstant.clickPicture,
                                                  isError: false);
                                            } */else if (remarksController
                                                .text.isEmpty) {
                                              showCustomSnackBar('Enter Remark',
                                                  isError: false);
                                            } else {
                                              String status='';
                                              status=selectedStatus=='Approve'?'1':'2';
                                              /*if(selectedStatus=='Approve')
                                                {
                                                  selectedStatus="1";
                                                }
                                              else{
                                                selectedStatus="0";
                                              }*/
                                              updateTourRequest(
                                                  tourController,
                                                  widget.tour_requestid,
                                                  status,
                                                  remarksController.text);
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

  void selectImageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            backgroundColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            titlePadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                Text(
                  'Select Image',
                  style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.black26,
                ),
              ],
            ),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: InkWell(
                  child: Row(
                    children: const [
                      Icon(
                        Icons.camera_alt,
                        size: 25,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Camera',
                          style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  onTap: () async {
                    // getImageFromCamera(context, 0);
                    pickImageCamera();
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: InkWell(
                  child: Row(
                    children: const [
                      Icon(
                        Icons.image,
                        size: 25,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Pick Image Or PDF',
                          style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  onTap: () async {
                    // getImageFromGallery(context, 0);
                    // pickImage();
                    openFiles();

                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          );
        });
  }

  void openFiles() async {
    FilePickerResult? resultFile = await FilePicker.platform.pickFiles();
    if (resultFile != null) {
      PlatformFile file = resultFile.files.first;
      _pickedFile = XFile(file!.path!);
      print(file.name);
      print(file.path);
      setState(() {});
    } else {
      //not picket any file
    }
  }

  void pickImage() async {
    _pickedFile = (await ImagePicker().pickImage(source: ImageSource.gallery))!;

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
    // Get.find<AuthController>().updateUserImage(_pickedFile!);
    // imageList.insert(index, imageFile);

    setState(() {});
    // update();
  }

  void updateTourRequest(TourController tourController, String tour_requestid,
      String? selectedStatus, String text) {
    tourController
        .updateTourDetails(
            tour_req_id: tour_requestid,
            status: selectedStatus,
            remark: text)
        .then((message) {
          if(message=='Data submitted successfully.')
            {
              showCustomSnackBar(message!, isError: false);
              Navigator.pop(context);
            }
          else{
            showCustomSnackBar(message!);
          }


    });
  }
}
