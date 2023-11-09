import 'package:flutter/material.dart';
import 'package:shimmers/constant/colorsConstant.dart';
import 'package:shimmers/model/ExeTourDetailModel.dart';
import 'package:shimmers/screens/campaigns/campaignsResponseScreen.dart';

import '../../constant/textConstant.dart';
import '../../model/campaignListModel.dart';

class TourListWidget extends StatefulWidget {
  final ExecutiveTourModel model;

  const TourListWidget({Key? key, required this.model}) : super(key: key);

  @override
  State<TourListWidget> createState() => _TourListWidgetState();
}

class _TourListWidgetState extends State<TourListWidget> {
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
                widget.model.area!,
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'From: ${widget.model.date}',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'To: ${widget.model.date}',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                 /* Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CampaignsResponseScreen(
                        model: widget.model,
                      )));*/
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
