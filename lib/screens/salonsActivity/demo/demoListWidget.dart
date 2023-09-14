import 'package:flutter/material.dart';
import 'package:shimmers/model/demoListModel.dart';

import '../../../constant/colorsConstant.dart';

class DemoListWidget extends StatefulWidget {
  final DemoData model;
  final String salonId;

  const DemoListWidget({Key? key, required this.model, required this.salonId})
      : super(key: key);

  @override
  State<DemoListWidget> createState() => _DemoListWidgetState();
}

class _DemoListWidgetState extends State<DemoListWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
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
                widget.model.salonName!,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                widget.model.requirement!,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Date : ${widget.model.date!}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
