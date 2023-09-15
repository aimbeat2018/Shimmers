import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmers/model/leaveTypeModel.dart';
import 'package:shimmers/screens/attendance/leaveDurationSheet.dart';
import 'package:shimmers/screens/attendance/leaveTypeSheet.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/custom_snackbar.dart';
import '../../constant/globalFunction.dart';
import '../../constant/textConstant.dart';
import '../../controllers/attendanceController.dart';

class ApplyLeaveScreen extends StatefulWidget {
  static const name = '/applyLeavesScreen';

  const ApplyLeaveScreen({Key? key}) : super(key: key);

  @override
  State<ApplyLeaveScreen> createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> {
  bool _isLoading = false;
  String? selectedLeaveType, selectedLeaveDuration, selectedLeaveTypeId;
  String toDate = "";
  String _selectedDate = '';
  TextEditingController reasonController = TextEditingController();

  DateTime _focusedDay = DateTime.now();

  DateTime? _selectedDay;

  Future<void> _selectDate(BuildContext context, String from) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _focusedDay,
        firstDate: _focusedDay,
        lastDate: DateTime(2101));
    if (picked != null && picked != _focusedDay) {
      setState(() {
        _selectedDay = picked;
        if (from == "1") {
          _selectedDate = DateFormat('dd-MM-yyyy').format(_selectedDay!);
        } else {
          toDate = DateFormat('dd-MM-yyyy').format(_selectedDay!);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();

    Get.find<AttendanceController>().getLeaveTypeList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AttendanceController>(builder: (attendanceController) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Text(
            TextConstant.applyForLeave,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        body: attendanceController.isLoading &&
                attendanceController.leaveTypeModel == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 25),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          TextConstant.applyForNewLeaves,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              TextConstant.leaveType,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => LeaveTypeSheet(
                                leaveTypeList:
                                    attendanceController.leaveTypeModel!.data!,
                              ),
                              backgroundColor: Colors.transparent,
                            ).then((leaveTypeModel) => {
                                  setState(() {
                                    LeaveTypeData model = leaveTypeModel;
                                    selectedLeaveType = model.typeName!;
                                    selectedLeaveTypeId = model.id!.toString();
                                  })
                                });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: primaryColor,
                                  blurRadius: 12.0, // soften the shadow
                                  spreadRadius: 0.5, //extend the shadow
                                  offset: Offset(
                                    1.0, // Move to right 5  horizontally
                                    1.0, // Move to bottom 5 Vertically
                                  ),
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      selectedLeaveType == null
                                          ? TextConstant.leaveType
                                          : selectedLeaveType!,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                  )),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.grey.shade900,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              TextConstant.leaveDuration,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => const LeaveDurationSheet(),
                              backgroundColor: Colors.transparent,
                            ).then((value) => {
                                  setState(() {
                                    selectedLeaveDuration = value!;
                                  })
                                });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: primaryColor,
                                  blurRadius: 12.0, // soften the shadow
                                  spreadRadius: 0.5, //extend the shadow
                                  offset: Offset(
                                    1.0, // Move to right 5  horizontally
                                    1.0, // Move to bottom 5 Vertically
                                  ),
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      selectedLeaveDuration == null
                                          ? TextConstant.leaveDuration
                                          : selectedLeaveDuration!,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                  )),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.grey.shade900,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  TextConstant.fromDate,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            InkWell(
                              onTap: () {
                                _selectDate(context, "1");
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: primaryColor,
                                      blurRadius: 12.0, // soften the shadow
                                      spreadRadius: 0.5, //extend the shadow
                                      offset: Offset(
                                        1.0, // Move to right 5  horizontally
                                        1.0, // Move to bottom 5 Vertically
                                      ),
                                    )
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          _selectedDate == ''
                                              ? TextConstant.fromDate
                                              : _selectedDate,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                        ),
                                      )),
                                      Icon(
                                        Icons.calendar_month,
                                        color: Colors.grey.shade900,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                        if (selectedLeaveDuration == 'Multiple' ||
                            selectedLeaveDuration == TextConstant.leaveDuration)
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    TextConstant.toDate,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                onTap: () {
                                  _selectDate(context, "2");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        color: primaryColor,
                                        blurRadius: 12.0, // soften the shadow
                                        spreadRadius: 0.5, //extend the shadow
                                        offset: Offset(
                                          1.0, // Move to right 5  horizontally
                                          1.0, // Move to bottom 5 Vertically
                                        ),
                                      )
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            toDate == ""
                                                ? TextConstant.toDate
                                                : toDate,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                          ),
                                        )),
                                        Icon(
                                          Icons.calendar_month,
                                          color: Colors.grey.shade900,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              TextConstant.reason,
                              style: const TextStyle(
                                  color: primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          style: const TextStyle(fontSize: 14),
                          maxLines: 5,
                          decoration: GlobalFunctions.getInputDecoration(
                              TextConstant.reason),
                          controller: reasonController,
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: 200,
                          // height: 45,
                          child: attendanceController.isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            primaryColor),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            primaryColor),
                                    textStyle:
                                        MaterialStateProperty.all<TextStyle>(
                                      const TextStyle(fontSize: 16),
                                    ),
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                      const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (selectedLeaveTypeId == null) {
                                      showCustomSnackBar("Select Leave type",
                                          isError: true);
                                    } else if (selectedLeaveDuration == null) {
                                      showCustomSnackBar(
                                          "Select Leave duration",
                                          isError: true);
                                    } else if (reasonController.text.isEmpty) {
                                      showCustomSnackBar("Enter leave reason",
                                          isError: true);
                                    } else if (selectedLeaveDuration ==
                                        'Multiple') {
                                      if (_selectedDate == "") {
                                        showCustomSnackBar("Select From Date",
                                            isError: true);
                                      } else if (_selectedDate == "") {
                                        showCustomSnackBar("Select To Date",
                                            isError: true);
                                      } else {
                                        applyLeave(attendanceController);
                                      }
                                    } else if (_selectedDate == "") {
                                      showCustomSnackBar("Select Date",
                                          isError: true);
                                    } else {
                                      applyLeave(attendanceController);
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      TextConstant.applyForLeave.toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      );
    });
  }

  Future<void> applyLeave(
    AttendanceController attendanceController,
  ) async {
    if (toDate == "") {
      toDate = _selectedDate;
    }

    if (selectedLeaveDuration == "Single") {
      selectedLeaveDuration = "single";
    } else if (selectedLeaveDuration == "Multiple") {
      selectedLeaveDuration = "multiple";
    } else if (selectedLeaveDuration == "First Half") {
      selectedLeaveDuration = "first_half";
    } else if (selectedLeaveDuration == "Second Half") {
      selectedLeaveDuration = "second_half";
    }

    attendanceController
        .applyForLeave(
            fromDate: _selectedDate,
            toDate: toDate,
            reason: reasonController.text,
            leaveType: selectedLeaveTypeId,
            duration: selectedLeaveDuration)
        .then((message) async {
      if (message == 'Leave applied successfully.') {
        showCustomSnackBar(message!, isError: false);
        Navigator.pop(context);
      } else {
        showCustomSnackBar(message!);
      }
    });
  }
}
