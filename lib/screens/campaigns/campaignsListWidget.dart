import 'package:flutter/material.dart';
import 'package:shimmers/constant/colorsConstant.dart';
import 'package:shimmers/screens/campaigns/campaignsResponseScreen.dart';

import '../../constant/textConstant.dart';

class CampaignsListWidget extends StatefulWidget {
  const CampaignsListWidget({Key? key}) : super(key: key);

  @override
  State<CampaignsListWidget> createState() => _CampaignsListWidgetState();
}

class _CampaignsListWidgetState extends State<CampaignsListWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
      child: Card(
        elevation: 5,
        shadowColor: primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ABC Technology',
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CampaignsResponseScreen()));
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: primaryColor),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        TextConstant.viewResponse,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
