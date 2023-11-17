import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmers/constant/textConstant.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/globalFunction.dart';
import '../../controllers/authController.dart';

class ProfileScreen extends StatefulWidget {
  static const name = '/profileScreen';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? profileImage;

  final empNameController = TextEditingController();
  final empAddressController = TextEditingController();
  final dobController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _designationController = TextEditingController();
  final _departmentController = TextEditingController();
  XFile? _pickedFile;

  @override
  void initState() {
    super.initState();

    Get.find<AuthController>().getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      if (!authController.isLoading) {
        empNameController.text =
            authController.profileModel!.userProfile!.name!;
        _mobileController.text =
        authController.profileModel!.userProfile!.mobile!;
        _emailController.text =
        authController.profileModel!.userProfile!.email!;

       /* empAddressController.text =
            authController.profileModel!.userProfile!.address!;
        dobController.text =
            authController.profileModel!.userProfile!.dateOfBirth!;
        _designationController.text =
            authController.profileModel!.userProfile!.designationName!;
        _departmentController.text =
            authController.profileModel!.userProfile!.departmentName!;*/

        profileImage = authController.profileModel!.userProfile!.imageUrl!;
      }

      return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Text(
            TextConstant.profile,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => pickImageCamera(),
                      child: Stack(
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 45.0,
                              backgroundImage: profileImage == null
                                  ? ExactAssetImage('assets/images/avatar.png')
                                      as ImageProvider
                                  : _pickedFile != null
                                      ? FileImage(File(_pickedFile!.path))
                                          as ImageProvider
                                      : NetworkImage(profileImage!),
                              backgroundColor: primaryColor,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 110.0, top: 60),
                              child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.shade300),
                                  child: InkWell(
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.edit,
                                      size: 22,
                                    ),
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Form(
                        child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                TextConstant.EmployeeName,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 45,
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
                                // border: Border.all(color: primaryColor, width: 1),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextFormField(
                                enabled: false,
                                style: const TextStyle(fontSize: 14),
                                decoration:
                                    GlobalFunctions.getInputDecoration(""),
                                controller: empNameController,
                                keyboardType: TextInputType.text,
                                onSaved: (value) {
                                  empNameController.text = value as String;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                TextConstant.EmployeeAddress,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 45,
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
                                // border: Border.all(color: primaryColor),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextFormField(
                                enabled: false,
                                style: const TextStyle(fontSize: 14),
                                decoration:
                                    GlobalFunctions.getInputDecoration(""),
                                controller: empAddressController,
                                keyboardType: TextInputType.text,
                                onSaved: (value) {
                                  empAddressController.text = value as String;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                TextConstant.MobileNumber,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 45,
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
                                // border: Border.all(color: primaryColor),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextFormField(
                                enabled: false,
                                style: const TextStyle(fontSize: 14),
                                decoration:
                                    GlobalFunctions.getInputDecoration(""),
                                controller: _mobileController,
                                keyboardType: TextInputType.number,
                                onSaved: (value) {
                                  _mobileController.text = value as String;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                TextConstant.Email,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 45,
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
                                // border: Border.all(color: primaryColor),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextFormField(
                                style: const TextStyle(fontSize: 14),
                                enabled: false,
                                decoration:
                                    GlobalFunctions.getInputDecoration(""),
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (value) {
                                  _emailController.text = value as String;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                TextConstant.Designation,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 45,
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
                                // border: Border.all(color: primaryColor),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextFormField(
                                enabled: false,
                                style: const TextStyle(fontSize: 14),
                                decoration:
                                    GlobalFunctions.getInputDecoration(""),
                                controller: _designationController,
                                keyboardType: TextInputType.text,
                                onSaved: (value) {
                                  _designationController.text = value as String;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                TextConstant.department,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 45,
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
                                // border: Border.all(color: primaryColor),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextFormField(
                                enabled: false,
                                style: const TextStyle(fontSize: 14),
                                decoration:
                                    GlobalFunctions.getInputDecoration(""),
                                controller: _departmentController,
                                keyboardType: TextInputType.text,
                                onSaved: (value) {
                                  _departmentController.text = value as String;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        // SizedBox(
                        //   width: 200,
                        //   // height: 45,
                        //   child: _isLoading
                        //       ? const Center(
                        //           child: CircularProgressIndicator(),
                        //         )
                        //       : ElevatedButton(
                        //           style: ButtonStyle(
                        //             backgroundColor:
                        //                 MaterialStateProperty.all<Color>(
                        //                     primaryColor),
                        //             foregroundColor:
                        //                 MaterialStateProperty.all<Color>(
                        //                     primaryColor),
                        //             textStyle:
                        //                 MaterialStateProperty.all<TextStyle>(
                        //               const TextStyle(fontSize: 16),
                        //             ),
                        //             padding:
                        //                 MaterialStateProperty.all<EdgeInsets>(
                        //               const EdgeInsets.symmetric(
                        //                   horizontal: 16, vertical: 8),
                        //             ),
                        //             shape: MaterialStateProperty.all<
                        //                 RoundedRectangleBorder>(
                        //               RoundedRectangleBorder(
                        //                 borderRadius: BorderRadius.circular(10),
                        //               ),
                        //             ),
                        //           ),
                        //           onPressed: () {
                        //             // Navigator.of(context)
                        //             //     .push(MaterialPageRoute(
                        //             //   builder: (context) =>
                        //             //       MainScreen(),
                        //             // ));
                        //           },
                        //           child: Padding(
                        //             padding: const EdgeInsets.all(5.0),
                        //             child: Text(
                        //               TextConstant.submit.toUpperCase(),
                        //               style: const TextStyle(
                        //                   fontSize: 14,
                        //                   color: Colors.white,
                        //                   fontWeight: FontWeight.w500),
                        //             ),
                        //           )),
                        // ),
                      ],
                    ))
                  ],
                ),
              ),
            ),
            if (authController.isLoading)
              Positioned.fill(
                child: Opacity(
                  opacity: 0.3,
                  child: Container(
                    color: const Color(0xFF000000),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              )
          ],
        ),
      );
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
      compressQuality: 100,
    );

    _pickedFile = XFile(croppedFile!.path);
    Get.find<AuthController>().updateUserImage(_pickedFile!);
    // imageList.insert(index, imageFile);

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
    Get.find<AuthController>().updateUserImage(_pickedFile!);
    // imageList.insert(index, imageFile);
    // imageList.add(_pickedFile!);
    // imageList.insert(index, _pickedFile!);
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
