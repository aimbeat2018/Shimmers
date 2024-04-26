import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmers/constant/custom_snackbar.dart';
import 'package:shimmers/constant/textConstant.dart';
import 'package:shimmers/screens/salons/addSalon/addFinalSalonScreen.dart';

import '../../../constant/colorsConstant.dart';
import '../../../constant/globalFunction.dart';

class AddSalonPersonalDetailsScreen extends StatefulWidget {
  static const String name = 'addSalonPersonalDetailsScreen';

  final String salonCategory;
  final String salonName;
  final String custType;
  final String brandId;
  final String beatrouteId;

  const AddSalonPersonalDetailsScreen(
      {Key? key, required this.salonCategory, required this.salonName,required this.custType,required this.brandId,required this.beatrouteId})
      : super(key: key);

  @override
  State<AddSalonPersonalDetailsScreen> createState() =>
      _AddSalonPersonalDetailsScreenState();
}

class _AddSalonPersonalDetailsScreenState
    extends State<AddSalonPersonalDetailsScreen> {
  XFile? _pickedFile;

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

  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController gstController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15),
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
                                color: Colors.grey,
                                size: 22.0,
                              ),
                              Text(
                                '3',
                                style: TextStyle(
                                  fontSize: 11,
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
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: RichText(
                                  text: TextSpan(
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      children: <TextSpan>[
                                    TextSpan(
                                      text: TextConstant.salonImage,
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
                        InkWell(
                          onTap: () {
                            pickImageCamera();
                          },
                          child: Stack(
                            children: [
                              Center(
                                child: CircleAvatar(
                                  radius: 45.0,
                                  backgroundImage: _pickedFile != null
                                      ? FileImage(File(_pickedFile!.path))
                                          as ImageProvider
                                      : const ExactAssetImage(
                                          'assets/images/avatar.png'),
                                  backgroundColor: primaryColor,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 125.0, top: 55),
                                  child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey.shade300),
                                      child: InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.camera_alt,
                                          size: 22,
                                        ),
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: RichText(
                                  text: TextSpan(
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      children: <TextSpan>[
                                    TextSpan(
                                      text: TextConstant.MobileNumber,
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
                                GlobalFunctions.getInputDecorationWhite(""),
                            controller: mobileController,
                            inputFormatters: [
                              new LengthLimitingTextInputFormatter(10),
                            ],
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: RichText(
                                  text: TextSpan(
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      children: <TextSpan>[
                                    TextSpan(
                                      text: TextConstant.Email,
                                    ),
                                   /* TextSpan(
                                      text: ' *',
                                      style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),*/
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
                                GlobalFunctions.getInputDecorationWhite(""),
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: RichText(
                                  text: TextSpan(
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      children: <TextSpan>[
                                    TextSpan(
                                      text: TextConstant.gstNumber,
                                    ),
                                    // TextSpan(
                                    //   text: ' *',
                                    //   style: const TextStyle(
                                    //       color: Colors.red,
                                    //       fontSize: 14,
                                    //       fontWeight: FontWeight.w500),
                                    // ),
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
                                GlobalFunctions.getInputDecorationWhite(""),
                            controller: gstController,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        const SizedBox(height: 50),
                        SizedBox(
                          width: 200,
                          // height: 45,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        primaryColor),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        primaryColor),
                                textStyle: MaterialStateProperty.all<TextStyle>(
                                  const TextStyle(fontSize: 16),
                                ),
                                padding: MaterialStateProperty.all<EdgeInsets>(
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
                                if (_pickedFile == null) {
                                  showCustomSnackBar('Select Salon Image',
                                      isError: true);
                                } else if (mobileController.text.length != 10) {
                                  showCustomSnackBar('Enter mobile number',
                                      isError: true);
                                } /*else if (emailController.text.isEmpty) {
                                  showCustomSnackBar('Enter email id',
                                      isError: true);
                                } */else {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) => AddFinalSalonScreen(
                                      salonImage: _pickedFile!,
                                      salonName: widget.salonName,
                                      categoryName: widget.salonCategory,
                                      mobileNumber: mobileController.text,
                                      email: emailController.text,
                                      gstNumber: gstController.text,
                                        custType:widget.custType,
                                        brandId:widget.brandId,
                                        beatrouteId:widget.beatrouteId,
                                    ),
                                  ));
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
      compressQuality: 80,
    );

    _pickedFile = XFile(croppedFile!.path);

    setState(() {});
    // update();
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
                          'Gallery',
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
                    pickImage();
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          );
        });
  }
}
