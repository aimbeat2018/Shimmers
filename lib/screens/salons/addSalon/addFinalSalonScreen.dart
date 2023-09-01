import 'package:flutter/material.dart';

import '../../../constant/colorsConstant.dart';
import '../../../constant/globalFunction.dart';
import '../../../constant/textConstant.dart';

class AddFinalSalonScreen extends StatefulWidget {
  static const String name = 'addSalonFinalScreen';

  const AddFinalSalonScreen({Key? key}) : super(key: key);

  @override
  State<AddFinalSalonScreen> createState() => _AddFinalSalonScreenState();
}

class _AddFinalSalonScreenState extends State<AddFinalSalonScreen> {
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

  TextEditingController contactPersonMobileController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();
  TextEditingController shippingAddressController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController contactPersonNameController = TextEditingController();
  TextEditingController contactPersonNumberController = TextEditingController();

  List<String> _locations = ['New', 'Existing']; // Option 2
  String? _selectedLocation; // Option 2
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
                                color: primaryColor,
                                size: 24.0,
                              ),
                              Text(
                                '3',
                                style: TextStyle(
                                  fontSize: 14,
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
                                      text: TextConstant.pincode,
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
                            enabled: false,
                            decoration:
                                GlobalFunctions.getInputDecorationWhite(""),
                            controller: pincodeController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
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
                                      text: TextConstant.companyAddress,
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
                            controller: companyAddressController,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
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
                                      text: TextConstant.country,
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
                            enabled: false,
                            decoration:
                                GlobalFunctions.getInputDecorationWhite(""),
                            controller: countryController,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
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
                                      text: TextConstant.state,
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
                            enabled: false,
                            decoration:
                                GlobalFunctions.getInputDecorationWhite(""),
                            controller: stateController,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
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
                                      text: TextConstant.city,
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
                            enabled: false,
                            decoration:
                                GlobalFunctions.getInputDecorationWhite(""),
                            controller: cityController,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
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
                                      text: TextConstant.shippingAddress,
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
                            controller: shippingAddressController,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
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
                                      text: TextConstant.contactPersonName,
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
                            controller: contactPersonNameController,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
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
                                      text: TextConstant.contactPersonNumber,
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
                            controller: contactPersonMobileController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
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
                                      text: TextConstant.salonType,
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
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 15),
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
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                isExpanded: true,
                                value: _selectedLocation,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedLocation = newValue;
                                  });
                                },
                                items: _locations.map((location) {
                                  return DropdownMenuItem(
                                    child: new Text(location),
                                    value: location,
                                  );
                                }).toList()),
                          ),
                        ),
                        const SizedBox(height: 30),
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
