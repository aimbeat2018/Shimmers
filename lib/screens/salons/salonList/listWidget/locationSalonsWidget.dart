import 'package:flutter/material.dart';
import 'package:shimmers/screens/salons/salonList/listWidget/salonListWidget.dart';

import '../../../../constant/colorsConstant.dart';
import '../../../../model/scheduleModel.dart';

class LocationSalonsWidget extends StatefulWidget {
  final ScheduleModel model;
  final int position;

  const LocationSalonsWidget(
      {Key? key, required this.model, required this.position})
      : super(key: key);

  @override
  State<LocationSalonsWidget> createState() => _LocationSalonsWidgetState();
}

class _LocationSalonsWidgetState extends State<LocationSalonsWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: isExpanded
              ? EdgeInsets.only(left: 8, right: 8, top: 5)
              : EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 15),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: primaryColor,
                blurRadius: 5.0, // soften the shadow
                spreadRadius: 0.1, //extend the shadow
                offset: Offset(
                  1.5, // Move to right 5  horizontally
                  1.5, // Move to bottom 5 Vertically
                ),
              )
            ],
            color: isExpanded ? primaryColor : kBackgroundColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.model.location!,
                        style: TextStyle(
                            color: isExpanded ? Colors.white : primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.model.time!,
                        style: TextStyle(
                            color: isExpanded ? Colors.white70 : primaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down_outlined,
                    color: isExpanded ? Colors.white : primaryColor,
                    size: 28,
                  ),
                )
              ],
            ),
          ),
        ),
        if (isExpanded)
          Padding(
            padding: EdgeInsets.only(left: 5, right: 5, bottom: 10, top: 5),
            child: Card(
              // elevation: 5,
              shadowColor: primaryColor,
              color: kBackgroundColor,
              child: Padding(
                padding:
                    EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return SalonListWidget(model: widget.model);
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: primaryColor.withOpacity(0.5),
                    );
                  },
                ),
              ),
            ),
          ),
      ],
    );
  }
}
