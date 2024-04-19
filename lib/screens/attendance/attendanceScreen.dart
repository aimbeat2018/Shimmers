import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shimmers/controllers/attendanceController.dart';
import 'package:shimmers/model/attendanceStatusModel.dart';
import 'package:shimmers/screens/attendance/leavesScreen.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../constant/app_constants.dart';
import '../../constant/colorsConstant.dart';
import '../../constant/globalFunction.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../constant/textConstant.dart';
import '../../model/attendanceHistoryModel.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<Summary> eventList = [];

  /*"total_working_days": 21,
        "total_presents": 0,
        "total_absents": 4, */

  int? total_working_days, total_presents, total_absents;
  String? _currentAddress;
  double? lat, longi;
  Position? _currentPosition;
  AttendanceStatusModel? statusModel;
  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

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

    int month = _focusedDay.month;
    int year = _focusedDay.year;

    if (mounted) {
      Future.delayed(Duration.zero, () async {
        getAttendanceHistory(month, year);
        getStatus();

        _getCurrentPosition();
      });
    }
  }

  Future<void> getStatus() async {
    statusModel = await Get.find<AttendanceController>().getAttendanceStatus();
    if (mounted) {
      setState(() {});
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      // openAppSettings();
      // if (permission == LocationPermission.denied) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(content: Text('Location permissions are denied')));
      //   return false;
      // }
    }
    if (permission == LocationPermission.deniedForever) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text(
      //         'Location permissions are permanently denied, we cannot request permissions.')));

      // setState(() async {
      permission = await Geolocator.requestPermission();
      // });

      // openAppSettings();

      // return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _currentPosition = position;
      if (mounted) {
        setState(() {});
      }
      // setState(() {});
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e!);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      lat = _currentPosition!.latitude;
      longi = _currentPosition!.longitude;
      /*, ${place.subAdministrativeArea}*/
      _currentAddress = ' ${place.locality}, ${place.postalCode}';
      // locationController.text = _currentAddress!;
      // isLoaded = true;

      print(lat.toString() + longi.toString());
      if (mounted) {
        setState(() {});
      }
    }).catchError((e) {
      debugPrint(e);
    });
  }

  getAttendanceHistory(int month, int year) {
    Get.find<AttendanceController>()
        .getAttendanceHistory(month, year)
        .then((attendanceHistoryModel) async {
      if (attendanceHistoryModel!.history != null) {
        total_working_days = attendanceHistoryModel.history!.totalWorkingDays;
        total_presents = attendanceHistoryModel.history!.totalPresents;
        total_absents = attendanceHistoryModel.history!.totalAbsents;

        eventList.addAll(attendanceHistoryModel.history!.summary!);
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<AttendanceController>(builder: (attendanceController) {
            return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
                backgroundColor: primaryColor,
                centerTitle: false,
                title: Text(
                  TextConstant.attendance,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                actions: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LeavesScreen()));
                        },
                        child: Text(
                          TextConstant.leaves,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      child: InkWell(
                        onTap: () {
                          if (statusModel != null) {
                            if (statusModel!.status == 'punch-out') {
                              Get.find<AttendanceController>()
                                  .employeePunchOut(
                                      lat: lat.toString(),
                                      long: longi.toString(),
                                      id: statusModel!.data!.id.toString(),
                                      address: _currentAddress)
                                  .then((value) async {
                                if (value == 'Clocked out successfully') {
                                  // statusModel = await Get.find<AttendanceController>()
                                  //     .getAttendanceStatus();

                                  setState(() {
                                    statusModel!.status = 'punch-in';
                                  });
                                }
                              });
                            } else {
                              Get.find<AttendanceController>()
                                  .employeePunchIn(
                                      lat: lat.toString(),
                                      long: longi.toString(),
                                      workingFrom: 'office',
                                      workFromType: 'office',
                                      address: _currentAddress)
                                  .then((value) async {
                                if (value == 'Clocked in successfully') {
                                  // statusModel = await Get.find<AttendanceController>()
                                  //     .getAttendanceStatus();

                                  setState(() {
                                    statusModel!.status = 'punch-out';
                                  });
                                }
                              });
                            }
                          } else {
                            Get.find<AttendanceController>()
                                .employeePunchIn(
                                    lat: lat.toString(),
                                    long: longi.toString(),
                                    workingFrom: 'office',
                                    workFromType: 'office',
                                    address: _currentAddress)
                                .then((value) async {
                              if (value == 'Clocked in successfully') {
                                // statusModel = await Get.find<AttendanceController>()
                                //     .getAttendanceStatus();

                                setState(() {
                                  statusModel!.status = 'punch-out';
                                });
                              }
                            });
                          }
                        },
                        child: Text(
                          statusModel == null
                              ? TextConstant.punchIn
                              : statusModel!.status == 'punch-out'
                                  ? TextConstant.punchOut
                                  : TextConstant.punchIn,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              body: attendanceController.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          children: [
                            TableCalendar(
                              firstDay: GlobalFunctions.getFirstDay(),
                              lastDay: GlobalFunctions.getLastDay(),
                              focusedDay: _focusedDay,
                              weekendDays: [DateTime.sunday],
                              calendarStyle: CalendarStyle(
                                weekendTextStyle: TextStyle(color: Colors.red),
                              ),
                              selectedDayPredicate: (day) =>
                                  isSameDay(_selectedDay, day),
                              headerStyle: const HeaderStyle(
                                  titleCentered: true,
                                  formatButtonVisible: false),
                              calendarFormat: CalendarFormat.month,
                              onDaySelected: (selectedDay, focusedDay) {
                                setState(() {
                                  _selectedDay = selectedDay;
                                  _focusedDay = focusedDay;
                                });
                              },
                              onPageChanged: (focusedDay) {
                                _focusedDay = focusedDay;
                                getAttendanceHistory(
                                    _focusedDay.month, focusedDay.year);
                              },
                              calendarBuilders: CalendarBuilders(
                                defaultBuilder: (context, day, focusedDay) {
                                  for (Summary d in eventList) {
                                    DateTime dateList = DateTime.parse(d.date!);
                                    // print(d.day);
                                    // print(d.month);
                                    // print(d.year);
                                    //
                                    // print("day" + day.day.toString());
                                    // print("month" + day.month.toString());
                                    // print("year" + day.year.toString());

                                    if (day.day == dateList.day &&
                                        day.month == dateList.month &&
                                        day.year == dateList.year) {
                                      return Container(
                                        margin: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: d.status == 'Absent'
                                              ? Colors.red
                                              : Colors.lightGreen,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8.0),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${day.day}',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      TextConstant.totalWorkingDays,
                                      style: const TextStyle(
                                          color: primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                    child: Text(
                                      total_working_days == null
                                          ? ''
                                          : total_working_days.toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 5,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          TextConstant.totalAbsents,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            total_absents == null
                                                ? ''
                                                : total_absents.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 5,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          TextConstant.totalPresent,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            total_presents == null
                                                ? ''
                                                : total_presents.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
            );
          });
  }
}
