import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmers/screens/distributors/distributorSalonListWidget.dart';

import '../../constant/colorsConstant.dart';

class DistributorWiseSalonScreen extends StatefulWidget {
  static const String name = 'distributorWiseSalonScreen';
  final String distributorName;

  const DistributorWiseSalonScreen({Key? key, required this.distributorName})
      : super(key: key);

  @override
  State<DistributorWiseSalonScreen> createState() =>
      _DistributorWiseSalonScreenState();
}

class _DistributorWiseSalonScreenState
    extends State<DistributorWiseSalonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          widget.distributorName,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 25),
          child: Column(
            children: [
              TextFormField(
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: primaryColor, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: primaryColor, width: 1),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    suffixIcon: Icon(
                      CupertinoIcons.search,
                      size: 28,
                    )),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 30,
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return DistributorSalonListWidget();
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: primaryColor.withOpacity(0.5),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
