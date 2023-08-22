import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmers/constant/colorsConstant.dart';
import 'package:shimmers/constant/textConstant.dart';

import '../../constant/globalFunction.dart';

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
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Padding(
              padding: EdgeInsets.only(top: 40.0, bottom: 20),
              child: CircleAvatar(
                radius: 80,
                backgroundColor: primaryColor,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Text(
                  '${TextConstant.helloUser}ABC',
                  style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 14),
                ),
                const SizedBox(height: 30),
                Text(
                  TextConstant.passwordResetMsg,
                  style: const TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 12),
                ),
                const SizedBox(height: 50),
                const Text(
                  'user007@gmail.com',
                  style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 13),
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
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                    child: Text(
                      TextConstant.sendPasswordResetLink,
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    )),
          ),
        ],
      ),
    ))));
  }

  void _submit() {
    // Navigator.of(context)
    //     .push(MaterialPageRoute(
    //     builder: (context) =>
    //         PasswordScreen()));
  }
}
