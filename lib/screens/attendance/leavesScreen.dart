import 'package:flutter/material.dart';
import 'package:shimmers/screens/attendance/applyLeaveScreen.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/textConstant.dart';
import '../../model/AttendanceModel.dart';

class LeavesScreen extends StatefulWidget {
  static const name = '/leavesScreen';

  const LeavesScreen({Key? key}) : super(key: key);

  @override
  State<LeavesScreen> createState() => _LeavesScreenState();
}

class _LeavesScreenState extends State<LeavesScreen> {
  List<AttendanceModel> attendanceList = [
    AttendanceModel(
        date: 'Fri, 12 Aug 2023',
        description: 'Full Day Application',
        type: 'Sick Leave',
        status: 'Awaiting'),
    AttendanceModel(
        date: 'Fri, 12 Aug 2023',
        description: 'Full Day Application',
        type: 'Paid Leave',
        status: 'Approved'),
    AttendanceModel(
        date: 'Fri, 12 Aug 2023',
        description: 'Full Day Application',
        type: 'Sick Leave',
        status: 'Rejected'),
    AttendanceModel(
        date: 'Fri, 12 Aug 2023',
        description: 'Full Day Application',
        type: 'Sick Leave',
        status: 'Rejected'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          TextConstant.leaves,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ApplyLeaveScreen()));
              },
              child: Image.asset('assets/images/apply_leave.png',
                  height: 30, width: 30, color: Colors.white),
            ),
          )
        ],
      ),
      body: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: attendanceList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              attendanceList[index].date!,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              attendanceList[index].description!,
                              style: const TextStyle(
                                  color: primaryColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              attendanceList[index].type!,
                              style: TextStyle(
                                  color: attendanceList[index].type! ==
                                          'Sick Leave'
                                      ? Colors.red
                                      : Colors.green,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: attendanceList[index].status! == 'Awaiting'
                              ? Colors.orange
                              : attendanceList[index].status! == 'Approved'
                                  ? Colors.green
                                  : Colors.red,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          attendanceList[index].status!,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
