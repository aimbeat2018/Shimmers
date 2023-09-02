import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmers/constant/textConstant.dart';
import 'package:shimmers/screens/campaigns/campaignsListWidget.dart';

import '../../constant/colorsConstant.dart';

class CampaignsListScreen extends StatefulWidget {
  static const String name = 'campaignsListScreen';

  const CampaignsListScreen({Key? key}) : super(key: key);

  @override
  State<CampaignsListScreen> createState() => _CampaignsListScreenState();
}

class _CampaignsListScreenState extends State<CampaignsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          TextConstant.Campaigns,
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
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return CampaignsListWidget();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
