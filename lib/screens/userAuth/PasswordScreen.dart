import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmers/constant/textConstant.dart';

import '../../constant/app_constants.dart';
import '../../constant/colorsConstant.dart';
import '../../constant/custom_snackbar.dart';
import '../../constant/globalFunction.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../constant/route_helper.dart';
import '../../controllers/authController.dart';
import 'PasswordResetScreen.dart';

class PasswordScreen extends StatefulWidget {
  // static const String name = 'password';
  final String? image;
  final String? email;
  final String? name;

  const PasswordScreen({super.key, required this.image, this.email, this.name});

  @override
  State<StatefulWidget> createState() => PasswordScreenState();
}

class PasswordScreenState extends State<PasswordScreen> {
  final _passwordController = TextEditingController();
  List<FocusNode> _focusNodes = [
    FocusNode(),
  ];

  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool passwordVisible = true;

  @override
  void initState() {
    super.initState();
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });

    CheckInternet.initConnectivity().then((value) {
      if (mounted) {
        setState(() {
          _connectionStatus = value;
        });
      }
    });
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      CheckInternet.updateConnectionStatus(result).then((value) {
        if (mounted) {
          setState(() {
            _connectionStatus = value;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<AuthController>(builder: (authController) {
            return Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
                    child: SingleChildScrollView(
                        child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0, bottom: 20),
                        child: widget.image! == ""
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
                      Text(
                        widget.name!,
                        style: TextStyle(color: primaryColor, fontSize: 16),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Password',
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
                                  blurRadius: 12.0, // soften the shadow
                                  spreadRadius: 0.5, //extend the shadow
                                  offset: Offset(
                                    1.0, // Move to right 5  horizontally
                                    1.0, // Move to bottom 5 Vertically
                                  ),
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: TextFormField(
                                      obscureText: passwordVisible,
                                      focusNode: _focusNodes[0],
                                      style: const TextStyle(fontSize: 14),
                                      /*decoration:
                                          GlobalFunctions.getInputDecoration(
                                        TextConstant.enterPassword,
                                      ),*/
                                      decoration: const InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 2),
                                        ),
                                        hintText: "Enter Password",
                                        hintStyle: TextStyle(
                                          fontFamily: 'calibri_reqular',
                                        ),
                                        contentPadding:
                                        EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 5),
                                      ),

                                      controller: _passwordController,
                                      keyboardType: TextInputType.text,
                                      onSaved: (value) {
                                        _passwordController.text = value as String;
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          passwordVisible = !passwordVisible;
                                        });
                                      },
                                      child: Icon(
                                        passwordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.grey,
                                      ),
                                    )),
                              ],
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
                                    TextConstant.log_in.toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                      ),
                      const SizedBox(height: 30),
                      new GestureDetector(
                        onTap: () {
                          forgetPassword();
                        },
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              TextConstant.forgetPassword,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: primaryColor),
                            )),
                      )
                    ],
                  ),
                ))));
          });
  }

  Future<void> _submit(String? password, AuthController authController) async {
    //await FirebaseMessaging.instance.getToken()
    authController
        .loginUser(phone: widget.email!, password: password, deviceToken: "")
        .then((loginModel) async {
      if (loginModel!.code == 200) {
        if (loginModel.passwordChanged == 1) {
          Get.offNamed(RouteHelper.getMainScreenRoute());
        } else {
          Get.offNamed(RouteHelper.getPasswordChangedScreenRoute(
              widget.email!, widget.image!));
        }
      } else {
        showCustomSnackBar('Password invalid');
      }
    });
  }

  forgetPassword() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            PasswordResetScreen(email: widget.email!, image: widget.image!)));
  }
}
