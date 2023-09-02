import 'package:flutter/material.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/textConstant.dart';
import 'campaignResponseListWidget.dart';

class CampaignsResponseScreen extends StatefulWidget {
  static const String name = 'campaignsResponseScreen';
  const CampaignsResponseScreen({Key? key}) : super(key: key);

  @override
  State<CampaignsResponseScreen> createState() =>
      _CampaignsResponseScreenState();
}

class _CampaignsResponseScreenState extends State<CampaignsResponseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          TextConstant.campaignsReport,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                width: MediaQuery.of(context).size.width,
                color: primaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Market Visit Report - Trainers',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Please note - This is to filled by the trainers whenever they do any market visit.',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Status : Published',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Campaign Duration : 254 months 10 days,\n09 Feb 2023 to 31 Dec 2023',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  TextConstant.teamRole,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                width: MediaQuery.of(context).size.width,
                color: kBackgroundColor,
                child: Row(
                  children: [
                    Center(
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          foregroundImage: AssetImage(
                            'assets/images/distribution.png',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ABC Technology',
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Role',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  TextConstant.response,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                width: MediaQuery.of(context).size.width,
                color: primaryColor,
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return CampaignResponseListWidget();
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.white.withOpacity(0.5),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
