import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmers/constant/colorsConstant.dart';
import 'package:shimmers/controllers/tourController.dart';
import 'package:shimmers/model/ExeTourDetailModel.dart';
import 'package:shimmers/screens/campaigns/campaignsResponseScreen.dart';
import 'package:shimmers/screens/tourVisit/tourVisitScreen.dart';

import '../../constant/custom_snackbar.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Area: ${widget.model.area!}',
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  widget.model.status! == 0?
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TourVisitScreen(
                                tour_requestid: widget.model!.id!)));
                      },
                      child: Icon(
                        Icons.edit,
                        color: primaryColor,
                      )) : SizedBox(),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: (){
                      deleteTourRequest(widget.model!.id.toString());
                    },
                    child: Icon(
                      Icons.delete,
                      color: primaryColor,
                    ),
                  )
                ],
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
                'Status: ${widget.model.status! == 0 ? 'Pending' : widget.model.status! == 1 ? 'Approved' : 'Rejected'}',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                widget.model.remark == null || widget.model.remark == ''
                    ? ''
                    : 'Remark: ${widget.model.remark}',
                // 'Remark: ${widget.model.remark ??'vff':widget.model.remark}',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
             /* InkWell(
                onTap: () {
                  if (widget.model.status! == 0) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TourVisitScreen(
                            tour_requestid: widget.model!.id!)));
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
                        'Edit Request',
                        *//* widget.model.status! == 0
                            ? 'Pending'
                            : widget.model.status! == 1
                                ? 'Approved'
                                : 'Rejected',*//*
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  if (widget.model.status! == 0) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TourVisitScreen(
                            tour_requestid: widget.model!.id!)));
                  }
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      deleteTourRequest(widget.model!.id.toString());
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: primaryColor),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Delete',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  void deleteTourRequest(String? id) {
    Get.find<TourController>()
        .deleteTourRequest(tour_reqid: id)
        .then((message) async {
      if (message == 'Tour Request deleted successfully') {
        showCustomSnackBar(message!, isError: false);
        setState(() {});
      } else {
        showCustomSnackBar(message!);
      }
    });
  }
}
