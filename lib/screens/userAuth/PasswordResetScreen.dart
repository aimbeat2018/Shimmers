import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmers/constant/colorsConstant.dart';
import 'package:shimmers/constant/textConstant.dart';

import '../../constant/custom_snackbar.dart';
import '../../constant/globalFunction.dart';
import '../../constant/route_helper.dart';
import '../../controllers/authController.dart';

class PasswordResetScreen extends StatefulWidget {
  final String? email;
  final String? image;

  const PasswordResetScreen({super.key, this.email, this.image});

  @override
  State<StatefulWidget> createState() => PasswordResetScreenState();
}

class PasswordResetScreenState extends State<PasswordResetScreen> {
  final _passwordController = TextEditingController();
  List<FocusNode> _focusNodes = [
    FocusNode(),
  ];

  @override
  void initState() {
    // Firebase.initializeApp();
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              child: Container(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, bottom: 20),
                    child: widget.image!.isEmpty
                        ? Image.asset(
                            'assets/images/user_blue.png',
                            height: 120,
                            width: 120,
                          )
                        : Image.network(
                            widget.image!,
                            height: 120,
                            width: 120,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      children: [
                        // Text(
                        //   '${TextConstant.helloUser}${widget.name}',
                        //   style: TextStyle(
                        //       color: primaryColor,
                        //       fontWeight: FontWeight.normal,
                        //       fontSize: 16),
                        // ),
                        // const SizedBox(height: 30),
                        // // Text(
                        // //   TextConstant.passwordResetMsg,
                        // //   style: const TextStyle(
                        // //       color: primaryColor,
                        // //       fontWeight: FontWeight.normal,
                        // //       fontSize: 16),
                        // // ),
                        // const SizedBox(height: 50),
                        Text(
                          widget.email! ?? "",
                          style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   widget.email! ?? '',
                            //   style: TextStyle(color: primaryColor),
                            // ),
                            Text(
                              'Enter Password',
                              style: TextStyle(color: primaryColor),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: primaryColor,
                                    blurRadius: 12.0,
                                    // soften the shadow
                                    spreadRadius: 0.5,
                                    //extend the shadow
                                    offset: Offset(
                                      1.0,
                                      // Move to right 5  horizontally
                                      1.0, // Move to bottom 5 Vertically
                                    ),
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextFormField(
                                obscureText: true,
                                focusNode: _focusNodes[0],
                                style: const TextStyle(fontSize: 14),
                                decoration: GlobalFunctions.getInputDecoration(
                                  TextConstant.enterPassword,
                                ),
                                controller: _passwordController,
                                keyboardType: TextInputType.text,
                                onSaved: (value) {
                                  _passwordController.text = value as String;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: 200,
                          // height: 45,
                          child: authController.isLoading
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
                                    if (_passwordController.text.isEmpty) {
                                      showCustomSnackBar(
                                          TextConstant.enterPassword,
                                          isError: true);
                                    } else {
                                      _submit(_passwordController.text,
                                          authController);
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      TextConstant.resetPassword.toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          )));
    });
  }

  Future<void> _submit(String? password, AuthController authController) async {
    //await FirebaseMessaging.instance.getToken()
    authController
        .resetPassword(phone: widget.email!, password: password)
        .then((loginModel) async {
      if (loginModel!.isNotEmpty) {
        Get.offNamed(RouteHelper.getMainScreenRoute());
      } else {
        showCustomSnackBar(loginModel);
      }
    });
  }
}
