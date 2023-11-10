import 'package:flutter/material.dart';
import 'package:shimmers/constant/colorsConstant.dart';
import 'package:shimmers/model/ExeTourDetailModel.dart';
import 'package:shimmers/screens/campaigns/campaignsResponseScreen.dart';
import 'package:shimmers/screens/tourVisit/tourVisitScreen.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
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
                'Area: ${widget.model.area!}',
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
                    'Date: ${widget.model.date!}',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Time: ${widget.model.time!}',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
               'Amount: ${widget.model.amount!.toString()}',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                widget.model.remark == null || widget.model.remark == '' ? 'No Any Remark' : 'Remark: ${widget.model.remark}',
                // 'Remark: ${widget.model.remark ??'vff':widget.model.remark}',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  if( widget.model.status! == 0)
                    {
                       Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TourVisitScreen()));
                    }

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
                        widget.model.status! == 0
                            ? 'Pending'
                            : widget.model.status! == 1
                                ? 'Approved'
                                : 'Rejected',
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
