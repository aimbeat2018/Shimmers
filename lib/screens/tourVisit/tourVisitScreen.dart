import 'package:flutter/material.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/globalFunction.dart';
import '../../constant/textConstant.dart';

class TourVisitScreen extends StatefulWidget {
  static const String name = 'TourVisitScreen';

  const TourVisitScreen({Key? key}) : super(key: key);

  @override
  State<TourVisitScreen> createState() => _TourVisitScreenState();
}

class _TourVisitScreenState extends State<TourVisitScreen> {
  TextEditingController remarksController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          TextConstant.tourVisit,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    TextConstant.selectPurpose,
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
                  // showModalBottomSheet(
                  //   context: context,
                  //   builder: (context) => LeaveTypeSheet(),
                  //   backgroundColor: Colors.transparent,
                  // ).then((value) => {
                  //   setState(() {
                  //     selectedLeaveType = value!;
                  //   })
                  // });
                },
                child: Container(
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: primaryColor)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            TextConstant.selectPurpose,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14),
                          ),
                        )),
                        Icon(
                          Icons.keyboard_arrow_down,
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
                decoration:
                    GlobalFunctions.getInputDecoration(TextConstant.remarks),
                controller: remarksController,
                keyboardType: TextInputType.text,
                onSaved: (value) {
                  remarksController.text = value as String;
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
                  // showModalBottomSheet(
                  //   context: context,
                  //   builder: (context) => LeaveTypeSheet(),
                  //   backgroundColor: Colors.transparent,
                  // ).then((value) => {
                  //   setState(() {
                  //     selectedLeaveType = value!;
                  //   })
                  // });
                },
                child: Container(
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: primaryColor)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            TextConstant.clickPicture,
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
              const SizedBox(height: 40),
              SizedBox(
                width: 200,
                child: ElevatedButton(
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
  }
}