import 'package:flutter/material.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/globalFunction.dart';
import '../../constant/textConstant.dart';

class TakeNoteScreen extends StatefulWidget {
  const TakeNoteScreen({Key? key}) : super(key: key);

  @override
  State<TakeNoteScreen> createState() => _TakeNoteScreenState();
}

class _TakeNoteScreenState extends State<TakeNoteScreen> {
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                            Navigator.of(context).pop();
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
            )
          ],
        ),
      ),
    );
  }
}
