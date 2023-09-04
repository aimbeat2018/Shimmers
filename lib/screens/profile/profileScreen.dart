import 'package:flutter/material.dart';
import 'package:shimmers/constant/textConstant.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/globalFunction.dart';

class ProfileScreen extends StatefulWidget {
  static const name = '/profileScreen';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = false;

  final empNameController = TextEditingController();
  final empAddressController = TextEditingController();
  final dobController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _designationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          TextConstant.profile,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  const Center(
                    child: CircleAvatar(
                      radius: 45.0,
                      backgroundImage:
                          ExactAssetImage('assets/images/avatar.png'),
                      backgroundColor: primaryColor,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 133.0, top: 55),
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
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                          border: Border.all(color: primaryColor, width: 1),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextFormField(
                          style: const TextStyle(fontSize: 14),
                          decoration: GlobalFunctions.getInputDecoration(""),
                          controller: empNameController,
                          keyboardType: TextInputType.text,
                          onSaved: (value) {
                            empNameController.text = value as String;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                          decoration: GlobalFunctions.getInputDecoration(""),
                          controller: empAddressController,
                          keyboardType: TextInputType.text,
                          onSaved: (value) {
                            empAddressController.text = value as String;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                          decoration: GlobalFunctions.getInputDecoration(""),
                          controller: _mobileController,
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            _mobileController.text = value as String;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                          decoration: GlobalFunctions.getInputDecoration(""),
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (value) {
                            _emailController.text = value as String;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                          decoration: GlobalFunctions.getInputDecoration(""),
                          controller: _designationController,
                          keyboardType: TextInputType.text,
                          onSaved: (value) {
                            _designationController.text = value as String;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 200,
                    // height: 45,
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  primaryColor),
                              foregroundColor: MaterialStateProperty.all<Color>(
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
                              // Navigator.of(context)
                              //     .push(MaterialPageRoute(
                              //   builder: (context) =>
                              //       MainScreen(),
                              // ));
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
              ))
            ],
          ),
        ),
      ),
    );
  }
}
