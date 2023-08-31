import 'package:flutter/material.dart';
import 'package:shimmers/constant/colorsConstant.dart';
import 'package:shimmers/constant/textConstant.dart';

import '../../model/scheduleModel.dart';

class NewSalonsScreen extends StatefulWidget {
  const NewSalonsScreen({Key? key}) : super(key: key);

  @override
  State<NewSalonsScreen> createState() => _NewSalonsScreenState();
}

class _NewSalonsScreenState extends State<NewSalonsScreen> {
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
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: primaryColor),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.add_circle_outline,
                          color: Colors.white,
                        ),
                        SizedBox(
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
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: scheduleList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ExpansionTile(
                      title: Text(scheduleList[index].location!),
                      subtitle: Text(scheduleList[index].time!),
                      initiallyExpanded: index == selectedTile,
                      children: [
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: scheduleList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Text(scheduleList[index].location!);
                            })
                      ],
                      onExpansionChanged: ((newState) {
                        if (newState)
                          setState(() {
                            selectedTile = index;
                          });
                        else
                          setState(() {
                            selectedTile = -1;
                          });
                      }),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
