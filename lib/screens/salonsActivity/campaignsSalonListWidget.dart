import 'package:flutter/material.dart';
import 'package:shimmers/constant/colorsConstant.dart';
import 'package:shimmers/model/campaignListModel.dart';
import 'package:shimmers/screens/salonsActivity/submitCampaignScreen.dart';

class CampaignsSalonListWidget extends StatefulWidget {
  final CampaignListData model;
  final int salonId;

  const CampaignsSalonListWidget(
      {Key? key, required this.model, required this.salonId})
      : super(key: key);

  @override
  State<CampaignsSalonListWidget> createState() =>
      _CampaignsSalonListWidgetState();
}

class _CampaignsSalonListWidgetState extends State<CampaignsSalonListWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
      child: InkWell(
        onTap: () {
          if (widget.model.status != "unpublished" ||
              widget.model.status != "completed" ||
              widget.model.status != "terminated") {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SubmitCampaignScreen(
                      model: widget.model,
                      salonId: widget.salonId,
                    )));
          }
        },
        child: Card(
          elevation: 5,
          shadowColor: primaryColor,
          color: primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.model.name!,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                // SizedBox(
                //   height: 5,
                // ),
                // Text(
                //   'Please note - this is to be filled by the trainers whenever they do any market visit.',
                //   style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 13,
                //       fontWeight: FontWeight.normal),
                // ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'From: ${widget.model.startDate}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'To: ${widget.model.endDate}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'Status: ${widget.model.status!}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
