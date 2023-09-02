import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmers/screens/distributors/distributorListWidget.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/textConstant.dart';

class DistributorsScreen extends StatefulWidget {
  static const String name = 'distributorScreen';

  const DistributorsScreen({Key? key}) : super(key: key);

  @override
  State<DistributorsScreen> createState() => _DistributorsScreenState();
}

class _DistributorsScreenState extends State<DistributorsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          TextConstant.Distributor,
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
                  return DistributorListWidget();
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
