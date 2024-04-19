import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shimmers/constant/globalFunction.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../constant/app_constants.dart';
import '../../constant/colorsConstant.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../constant/textConstant.dart';
import '../../model/scheduleModel.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

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
  int selectedTab = 1;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    CheckInternet.initConnectivity().then((value) => setState(() {
          _connectionStatus = value;
        }));
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      CheckInternet.updateConnectionStatus(result).then((value) => setState(() {
            _connectionStatus = value;
          }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.white, //change your color here
              ),
              backgroundColor: primaryColor,
              centerTitle: true,
              title: Text(
                TextConstant.mySchedule,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Column(
                  children: [
                    Card(
                      elevation: 5,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        // borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TableCalendar(
                        firstDay: GlobalFunctions.getFirstDay(),
                        lastDay: GlobalFunctions.getLastDay(),
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) =>
                            isSameDay(_selectedDay, day),
                        headerStyle: const HeaderStyle(
                            titleCentered: true, formatButtonVisible: false),
                        calendarFormat: CalendarFormat.week,
                        onDaySelected: (selectedDay, focusedDay) {
                          if (!isSameDay(_selectedDay, selectedDay)) {
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                            });
                          }
                        },
                        onPageChanged: (focusedDay) {
                          _focusedDay = focusedDay;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedTab = 1;
                            });
                          },
                          child: Card(
                            elevation: selectedTab == 1 ? 5 : 0,
                            color:
                                selectedTab == 1 ? primaryColor : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 50),
                              child: Text(
                                TextConstant.history,
                                style: TextStyle(
                                    color: selectedTab == 1
                                        ? Colors.white
                                        : primaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedTab = 2;
                            });
                          },
                          child: Card(
                            elevation: selectedTab == 2 ? 5 : 0,
                            color:
                                selectedTab == 2 ? primaryColor : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 50),
                              child: Text(
                                TextConstant.schedule,
                                style: TextStyle(
                                    color: selectedTab == 2
                                        ? Colors.white
                                        : primaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: scheduleList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 10),
                            child: Card(
                              elevation: 5,
                              color: scheduleList[index].status == "pending"
                                  ? Colors.red.shade50
                                  : Colors.green.shade50,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            scheduleList[index].salonName!,
                                            style: const TextStyle(
                                                color: primaryColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            scheduleList[index].location!,
                                            style: const TextStyle(
                                                color: primaryColor,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            scheduleList[index].time!,
                                            style: const TextStyle(
                                                color: primaryColor,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            scheduleList[index].status!,
                                            style: TextStyle(
                                                color: scheduleList[index]
                                                            .status ==
                                                        "pending"
                                                    ? Colors.red
                                                    : Colors.green,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.grey,
                                      size: 20,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                  ],
                ),
              ),
            ),
          );
  }
}
