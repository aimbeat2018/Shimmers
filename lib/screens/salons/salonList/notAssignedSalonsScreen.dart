import 'package:flutter/material.dart';

import '../../../constant/colorsConstant.dart';
import '../../../constant/textConstant.dart';
import '../../../model/scheduleModel.dart';

class NotAssignedSalonsScreen extends StatefulWidget {
  const NotAssignedSalonsScreen({Key? key}) : super(key: key);

  @override
  State<NotAssignedSalonsScreen> createState() =>
      _NotAssignedSalonsScreenState();
}

class _NotAssignedSalonsScreenState extends State<NotAssignedSalonsScreen> {
  List<ScheduleModel> scheduleList = [
    ScheduleModel(
        salonName: "Purple - The Family Salon",
        location: 'Vashi, Navi Mumbai',
        time: '11:30 AM - 12:30 PM',
        status: 'completed'),
    ScheduleModel(
        salonName: "Purple - The Family Salon",
        location: 'Vashi, Navi Mumbai',
        time: '11:30 AM - 12:30 PM',
        status: 'pending'),
    ScheduleModel(
        salonName: "Purple - The Family Salon",
        location: 'Vashi, Navi Mumbai',
        time: '11:30 AM - 12:30 PM',
        status: 'completed'),
    ScheduleModel(
        salonName: "Purple - The Family Salon",
        location: 'Vashi, Navi Mumbai',
        time: '11:30 AM - 12:30 PM',
        status: 'completed')
  ];
  int selectedTile = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: primaryColor),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.add_circle_outline,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          TextConstant.addSalon,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // ListView.builder(
              //     physics: const NeverScrollableScrollPhysics(),
              //     shrinkWrap: true,
              //     itemCount: scheduleList.length,
              //     itemBuilder: (BuildContext context, int index) {
              //       return LocationSalonsWidget(
              //         model: scheduleList[index],
              //         position: index,
              //       );
              //     })
            ],
          ),
        ),
      ),
    );
  }
}
