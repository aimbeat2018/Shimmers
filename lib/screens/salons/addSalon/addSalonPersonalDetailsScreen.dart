import 'package:flutter/material.dart';
import 'package:shimmers/constant/textConstant.dart';
import 'package:shimmers/screens/salons/addSalon/addFinalSalonScreen.dart';

import '../../../constant/colorsConstant.dart';
import '../../../constant/globalFunction.dart';

class AddSalonPersonalDetailsScreen extends StatefulWidget {
  static const String name = 'addSalonPersonalDetailsScreen';

  final String salonCategory;
  final String salonName;

  const AddSalonPersonalDetailsScreen(
      {Key? key, required this.salonCategory, required this.salonName})
      : super(key: key);

  @override
  State<AddSalonPersonalDetailsScreen> createState() =>
      _AddSalonPersonalDetailsScreenState();
}

class _AddSalonPersonalDetailsScreenState
    extends State<AddSalonPersonalDetailsScreen> {
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
                            boxShadow: const [
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
                          child: TextFormField(
                            style: const TextStyle(fontSize: 14),
                            decoration:
                                GlobalFunctions.getInputDecorationWhite(""),
                            controller: mobileController,
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
                            boxShadow: const [
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
                            boxShadow: const [
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
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => AddFinalSalonScreen(),
                                ));
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
}
