import 'package:flutter/material.dart';
import 'package:shimmers/constant/colorsConstant.dart';

import '../../model/campaignResponseModel.dart';

class CampaignResponseListWidget extends StatefulWidget {
  final CampaignResponseData model;
  final int index;

  const CampaignResponseListWidget(
      {Key? key, required this.model, required this.index})
      : super(key: key);

  @override
  State<CampaignResponseListWidget> createState() =>
      _CampaignResponseListWidgetState();
}

class _CampaignResponseListWidgetState
    extends State<CampaignResponseListWidget> {
  String answer = "";
  List<String> answerList = [];

  @override
  Widget build(BuildContext context) {
    answerList = [];
    for (var answerModel in widget.model.answer!) {
      answerList.add(answerModel.key!);
    }

    answer = answerList.join(",");
    int index = widget.index + 1;

    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Q. $index ${widget.model.question!}',
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20.0),
          //   child: Text(
          //     'Please mention the category of the salon. [ If the salon is a Floractive user select Existing User, If the salon is not a Floractive User select New User. ]',
          //     style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 12,
          //         fontWeight: FontWeight.normal),
          //   ),
          // ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(13),
            color: kBackgroundColor,
            child: Text(
              answer,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.normal),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
