import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmers/screens/salonsActivity/campaignsSalonListWidget.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/textConstant.dart';

class SalonCampaignListScreen extends StatefulWidget {
  static const String name = 'SalonCampaignListScreen';

  const SalonCampaignListScreen({Key? key}) : super(key: key);

  @override
  State<SalonCampaignListScreen> createState() =>
      _SalonCampaignListScreenState();
}

class _SalonCampaignListScreenState extends State<SalonCampaignListScreen> {
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
                    hintText: 'Search',
                    suffixIcon: Icon(
                      CupertinoIcons.search,
                      size: 28,
                    )),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 20,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return CampaignsSalonListWidget();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
