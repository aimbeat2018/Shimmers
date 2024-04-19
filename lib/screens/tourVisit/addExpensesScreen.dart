import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shimmers/constant/no_internet_screen.dart';
import 'package:shimmers/controllers/authController.dart';
import 'package:shimmers/model/ExpensesByIdModel.dart';
import 'package:shimmers/model/addExpensesModel.dart';

import '../../constant/app_constants.dart';
import '../../constant/colorsConstant.dart';
import '../../constant/custom_snackbar.dart';
import '../../constant/globalFunction.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/textConstant.dart';
import '../../controllers/tourController.dart';

class AddExpensesScreen extends StatefulWidget {
  final String expenses_id;

  @override
  State<StatefulWidget> createState() {
    return _AddExpensesScreen();
  }

  AddExpensesScreen({required this.expenses_id});
}

class _AddExpensesScreen extends State<AddExpensesScreen> {
  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  TextEditingController areaController = TextEditingController();
  TextEditingController approxKmController = TextEditingController();
  TextEditingController daController = TextEditingController();
  TextEditingController taController = TextEditingController();
  TextEditingController hotelController = TextEditingController();
  TextEditingController misphoneController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  String? selectedDate, selectedTime;
  late int da_amount, ta_amount, hotel_amount, mis_amount, total_amount;
  ExpensesByIdModel? expensesByidModel;
  XFile? _pickedFile;

  @override
  void initState() {
    super.initState();
    selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    CheckInternet.initConnectivity().then((value) => setState(() {
          _connectionStatus = value;
        }));
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      CheckInternet.updateConnectionStatus(result).then((value) => setState(() {
            _connectionStatus = value;
          }));
    });
    da_amount = 0;
    ta_amount = 0;
    hotel_amount = 0;
    mis_amount = 0;
    total_amount = 0;
    if (widget.expenses_id != '0') {
      if (_connectionStatus != AppConstants.connectivityCheck) {
        if (mounted) {
          Future.delayed(Duration.zero, () async {
            expensesByidModel = await Get.find<TourController>()
                .getExpensesDetailsById(
                    expenses_id: widget.expenses_id.toString());
            if (expensesByidModel != null) {
              expensesByidModel!.data!.da == null ||
                      expensesByidModel!.data!.da! == ''
                  ? daController.text = ''
                  : daController.text = expensesByidModel!.data!.da!.toString();

              expensesByidModel!.data!.da == null ||
                      expensesByidModel!.data!.da! == ''
                  ? da_amount = 0
                  : da_amount = expensesByidModel!.data!.da!;

              expensesByidModel!.data!.miscOther == null ||
                      expensesByidModel!.data!.miscOther! == ''
                  ? misphoneController.text = ''
                  : misphoneController.text =
                      expensesByidModel!.data!.miscOther!.toString();

              expensesByidModel!.data!.miscOther == null ||
                      expensesByidModel!.data!.miscOther! == ''
                  ? mis_amount = 0
                  : mis_amount = expensesByidModel!.data!.miscOther!;

              expensesByidModel!.data!.remark == null ||
                      expensesByidModel!.data!.remark! == ''
                  ? remarksController.text = ''
                  : remarksController.text =
                      expensesByidModel!.data!.remark!.toString();

              selectedDate = expensesByidModel!.data!.date;
              areaController.text = expensesByidModel!.data!.areaCovered!;
              approxKmController.text = expensesByidModel!.data!.kilometer!;
              taController.text = expensesByidModel!.data!.ta!.toString();
              ta_amount = expensesByidModel!.data!.ta!;
              hotelController.text = expensesByidModel!.data!.hotel!.toString();
              hotel_amount = expensesByidModel!.data!.hotel!;
              // misphoneController.text=expensesByidModel!.data!.miscOther!.toString();
              totalController.text = expensesByidModel!.data!.total!.toString();
              total_amount = expensesByidModel!.data!.total!;
              //   remarksController.text=expensesByidModel!.data!.remark!.toString();
            }
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<TourController>(builder: (tourController) {
            return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
                backgroundColor: primaryColor,
                centerTitle: true,
                title: Text(
                  'Add Expenses',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 20),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Date',
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
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement

                            setState(() {
                              selectedDate = formattedDate;
                            });
                          } else {
                            print("Date is not selected");
                          }
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
                                    selectedDate == null
                                        ? TextConstant.selectDate
                                        : selectedDate!,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                )),
                                Icon(
                                  Icons.calendar_month,
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
                            'Area Covered',
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
                        decoration: GlobalFunctions.getInputDecoration('Area'),
                        controller: areaController,
                        //  keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.characters,
                        onSaved: (value) {
                          areaController.text = value as String;
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
                            'Approx Km',
                            style: const TextStyle(
                                color: primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: approxKmController,
                        decoration:
                            GlobalFunctions.getInputDecoration('Approx Km'),
                        style: TextStyle(fontSize: 14),
                        textCapitalization: TextCapitalization.characters,
                        // keyboardType: TextInputType.text,
                        onSaved: (value) {
                          approxKmController.text = value as String;
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
                            'DA',
                            style: const TextStyle(
                                color: primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: daController,
                        decoration: GlobalFunctions.getInputDecoration('DA'),
                        style: TextStyle(fontSize: 14),
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization.characters,
                        onSaved: (value) {
                          daController.text = value as String;
                        },
                        onChanged: (value) {
                          da_amount = int.parse(value);
                          calculateTotal(
                              da_amount, ta_amount, hotel_amount, mis_amount);
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
                            'TA',
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
                        decoration: GlobalFunctions.getInputDecoration('TA'),
                        // enabled: false,
                        controller: taController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            ta_amount = int.parse(value);
                            calculateTotal(
                                da_amount, ta_amount, hotel_amount, mis_amount);
                          }
                        },
                        onSaved: (value) {
                          taController.text = value as String;
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
                            'Hotel/Restaurant Bill Amount',
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
                        decoration: GlobalFunctions.getInputDecoration(
                            'Hotel / Restaurant Bill Amount'),
                        controller: hotelController,
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          hotelController.text = value as String;
                        },
                        onChanged: (value) {
                          hotel_amount = int.parse(value);
                          calculateTotal(
                              da_amount, ta_amount, hotel_amount, mis_amount);
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
                            'Miscellaneous: Phone',
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
                        decoration: GlobalFunctions.getInputDecoration(
                            'Miscellaneous Amount'),
                        controller: misphoneController,
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          misphoneController.text = value as String;
                        },
                        onChanged: (value) {
                          mis_amount = int.parse(value);
                          calculateTotal(
                              da_amount, ta_amount, hotel_amount, mis_amount);
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
                          // pickImageCamera();
                          selectImageDialog(context);
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
                      SizedBox(
                        height: 25,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Total',
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
                        decoration:
                            GlobalFunctions.getInputDecoration('Total Amount'),
                        controller: totalController,
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          totalController.text = value as String;
                        },
                        enabled: false,
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
                        //keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.characters,
                        onSaved: (value) {
                          remarksController.text = value as String;
                        },
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: 200,
                        child: tourController.isLoading
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
                                  if (areaController.text.isEmpty) {
                                    showCustomSnackBar('Enter Area Covered',
                                        isError: false);
                                  } else if (approxKmController.text.isEmpty) {
                                    showCustomSnackBar('Enter Approximate Km',
                                        isError: false);
                                  }
                                  /*else if (daController.text.isEmpty) {
                                    showCustomSnackBar('Enter DA',
                                        isError: false);
                                  } else if (selectedDate == '') {
                                    showCustomSnackBar('Select Departure Date',
                                        isError: false);
                                  } else if (taController.text.isEmpty) {
                                    showCustomSnackBar('Enter TA',
                                        isError: false);
                                  } else if (hotelController.text.isEmpty) {
                                    showCustomSnackBar(
                                        'Enter Hotel / Restaurant Bill Amount',
                                        isError: false);
                                  } */
                                  else {
                                    /*  AddExpensesModel addExpensesModel =
                                        new AddExpensesModel();
                                    addExpensesModel.expensesId =
                                        widget.expenses_id;
                                    addExpensesModel.userId = int.parse(
                                        Get.find<AuthController>().getUserId());
                                    addExpensesModel.date = selectedDate;
                                    addExpensesModel.area = areaController.text;
                                    addExpensesModel.kilometer =
                                        approxKmController.text;
                                    addExpensesModel.da = da_amount;
                                    addExpensesModel.ta = ta_amount;
                                    addExpensesModel.hotel = hotel_amount;
                                    addExpensesModel.miscOther = mis_amount;
                                    addExpensesModel.total = total_amount;
                                    addExpensesModel.remark =
                                        remarksController.text;
*/
                                    addTourExpenses(tourController,
                                        widget.expenses_id.toString());
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

  Future<void> addTourExpenses(
      TourController tourController, String expense_id) async {
    tourController
        .addExpenses(
            expenses_id: widget.expenses_id,
            user_id: Get.find<AuthController>().getUserId(),
            date: selectedDate,
            area: areaController.text,
            kilometer: approxKmController.text,
            da: daController.text,
            ta: taController.text,
            hotel: hotelController.text,
            misc_other: misphoneController.text,
            total: totalController.text,
            remark: remarksController.text,
            attachment: _pickedFile)
        .then((message) async {
      if (message == 'Expenses added successfully.') {
        showCustomSnackBar(message!, isError: false);
        Navigator.pop(context);
        /* Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TourListScreen()));*/
      } else if (message == 'Expenses updated successfully.') {
        showCustomSnackBar(message!, isError: false);
        Navigator.pop(context);
        /* Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TourListScreen()));*/
      } else {
        showCustomSnackBar(message!);
      }
    });
  }

  void calculateTotal(int ta_amt, int da_amt, int hotel_amt, int misc_amt) {
    total_amount = ta_amt + da_amt + hotel_amt + misc_amt;
    setState(() {
      totalController.text = total_amount.toString();
    });
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
}
