import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/app_constants.dart';
import '../../constant/colorsConstant.dart';
import '../../constant/custom_snackbar.dart';
import '../../constant/globalFunction.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../constant/textConstant.dart';
import '../../controllers/salonController.dart';

class TakeNoteScreen extends StatefulWidget {
  final String salonId;

  const TakeNoteScreen({Key? key, required this.salonId}) : super(key: key);

  @override
  State<TakeNoteScreen> createState() => _TakeNoteScreenState();
}

class _TakeNoteScreenState extends State<TakeNoteScreen> {
  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    CheckInternet.initConnectivity().then((value) => setState(() {
          _connectionStatus = value;
        }));
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      CheckInternet.updateConnectionStatus(result).then((value) => setState(() {
            _connectionStatus = value;
          }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<SalonController>(builder: (salonController) {
            return Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    AppBar(
                      backgroundColor: primaryColor,
                      centerTitle: true,
                      title: Text(
                        TextConstant.takeNote,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 25),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  TextConstant.noteStr,
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
                              maxLines: 10,
                              decoration: GlobalFunctions.getInputDecoration(
                                  TextConstant.enterNote),
                              controller: noteController,
                              keyboardType: TextInputType.text,
                              onSaved: (value) {
                                noteController.text = value as String;
                              },
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: 200,
                              // height: 45,
                              child: salonController.isLoading
                                  ? Center(
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
                                        textStyle: MaterialStateProperty.all<
                                            TextStyle>(
                                          const TextStyle(fontSize: 16),
                                        ),
                                        padding: MaterialStateProperty.all<
                                            EdgeInsets>(
                                          const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                        ),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (noteController.text.isEmpty) {
                                          showCustomSnackBar("Enter note",
                                              isError: true);
                                        } else {
                                          takeSalonNote(salonController,
                                              noteController.text);
                                        }
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
                    )
                  ],
                ),
              ),
            );
          });
  }

  Future<void> takeSalonNote(
      SalonController salonController, String note) async {
    if (_connectionStatus == AppConstants.connectivityCheck) {
      showCustomSnackBar("No internet connection", isError: false);
    } else {
      salonController
          .takeSalonNote(salonId: widget.salonId, note: note)
          .then((message) async {
        if (message == 'Note added successfully.') {
          showCustomSnackBar(message!, isError: false);
          Navigator.pop(context);
        } else {
          showCustomSnackBar(message!);
        }
      });
    }
  }
}
