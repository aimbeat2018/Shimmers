import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmers/screens/attendance/applyLeaveScreen.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/textConstant.dart';
import '../../controllers/attendanceController.dart';

class LeavesScreen extends StatefulWidget {
  static const name = '/leavesScreen';

  const LeavesScreen({Key? key}) : super(key: key);

  @override
  State<LeavesScreen> createState() => _LeavesScreenState();
}

class _LeavesScreenState extends State<LeavesScreen> {
  @override
  void initState() {
    super.initState();

    Get.find<AttendanceController>().getLeaveList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AttendanceController>(builder: (attendanceController) {
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
                      builder: (context) => const ApplyLeaveScreen()));
                },
                child: Image.asset('assets/images/apply_leave.png',
                    height: 30, width: 30, color: Colors.white),
              ),
            )
          ],
        ),
        body: attendanceController.isLoading &&
                attendanceController.leaveListModel == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : attendanceController.leaveListModel!.data!.isEmpty
                ? Center(
                    child: Text('No Data Found'),
                  )
                : ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        attendanceController.leaveListModel!.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 10),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        attendanceController
                                            .leaveListModel!.data![index].date!,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        attendanceController.leaveListModel!
                                            .data![index].reason!,
                                        style: const TextStyle(
                                            color: primaryColor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        attendanceController.leaveListModel!
                                            .data![index].leaveType!,
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: attendanceController.leaveListModel!
                                                .data![index].status! ==
                                            'pending'
                                        ? Colors.orange
                                        : attendanceController.leaveListModel!
                                                    .data![index].status! ==
                                                'approved'
                                            ? Colors.green
                                            : Colors.red,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                  ),
                                  child: Text(
                                    attendanceController
                                        .leaveListModel!.data![index].status!,
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
    });
  }
}
