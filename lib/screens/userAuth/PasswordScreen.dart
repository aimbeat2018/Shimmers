import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmers/constant/textConstant.dart';
import 'package:shimmers/screens/home/mainScreen.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/globalFunction.dart';
import 'PasswordResetScreen.dart';

class PasswordScreen extends StatefulWidget{
  static const String name ='password';
  const PasswordScreen({super.key});

  @override
  State<StatefulWidget> createState() => PasswordScreenState();

}

class PasswordScreenState extends State<PasswordScreen>{

  bool _isLoading = false;

  final _passwordController = TextEditingController();
  List<FocusNode> _focusNodes = [
    FocusNode(),
  ];

  @override
  void initState() {
print('password');
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:40.0,bottom: 20),

                        child: Image.asset('assets/images/logo.png',
                          height: 150,
                          width: 150,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0,
                            top: 0.0,
                            right: 20.0,
                            bottom: 8.0),
                        child: TextFormField(
                          focusNode: _focusNodes[0],
                          style: const TextStyle(fontSize: 14),
                          decoration:
                          GlobalFunctions.getInputDecoration(
                            TextConstant.enterPassword,
                          ),
                          controller: _passwordController,
                          keyboardType: TextInputType.text,
                          validator: (input) =>
                          // !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=
                          // ?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                          //         .hasMatch(input!)
                          input.toString() == ""
                              ? TextConstant.enterMobileNumberEmail
                              : null,
                          onSaved: (value) {
                            _passwordController.text =
                            value as String;
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 200,
                        // height: 45,
                        child: _isLoading
                            ? const Center(
                          child:
                          CircularProgressIndicator(),
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
                              padding: MaterialStateProperty
                                  .all<EdgeInsets>(
                                const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8),
                              ),
                              shape:
                              MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(
                                      10),
                                ),
                              ),
                            ),
                            onPressed: () {
                              // Navigator.of(context)
                              //     .push(MaterialPageRoute(
                              //   builder: (context) =>
                              //       MainScreen(),
                              // ));
                              _submit();
                            },
                            child: Text(
                              TextConstant.log_in,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight:
                                  FontWeight.w500),
                            )),
                      ),
                      const SizedBox(height: 10),
                      new GestureDetector(
                        onTap: () {
                          forgetPassword();
                        },
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              TextConstant.forgetPassword,
                              style: TextStyle(fontWeight: FontWeight.normal,color: primaryColor),
                            )
                        ),
                      )
                    ],
                  ),
                )
            )
        )
    );

  }

  void _submit() {
    Navigator.of(context)
        .push(MaterialPageRoute(
        builder: (context) =>
            MainScreen()));
  }


  forgetPassword() {
    Navigator.of(context)
        .push(MaterialPageRoute(
        builder: (context) => PasswordResetScreen()));

    }
  }
