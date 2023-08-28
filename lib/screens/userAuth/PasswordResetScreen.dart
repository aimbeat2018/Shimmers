import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmers/constant/colorsConstant.dart';
import 'package:shimmers/constant/textConstant.dart';
import 'package:shimmers/screens/home/mainScreen.dart';

class PasswordResetScreen extends StatefulWidget {
  static const String name = 'passwordReset';

  const PasswordResetScreen({super.key});

  @override
  State<StatefulWidget> createState() => PasswordResetScreenState();
}

class PasswordResetScreenState extends State<PasswordResetScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  child: Image.asset(
                    'assets/images/user_blue.png',
                    height: 120,
                    width: 120,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      Text(
                        '${TextConstant.helloUser}ABC',
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 16),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        TextConstant.passwordResetMsg,
                        style: const TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 16),
                      ),
                      const SizedBox(height: 50),
                      const Text(
                        'user007@gmail.com',
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                SizedBox(
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(primaryColor),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(primaryColor),
                            textStyle: MaterialStateProperty.all<TextStyle>(
                              const TextStyle(fontSize: 16),
                            ),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                            ),
                            shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
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
                            _submit();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              TextConstant.sendPasswordResetLink,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
                ),
              ],
          ),
        )),
            )));
  }

  void _submit() {
    Navigator.of(context)
        .push(MaterialPageRoute(
        builder: (context) =>
            MainScreen()));
  }
}
