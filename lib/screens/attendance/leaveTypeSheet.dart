import 'package:flutter/material.dart';
import 'package:shimmers/constant/colorsConstant.dart';

import '../../constant/textConstant.dart';
import '../../model/leaveTypeModel.dart';

class LeaveTypeSheet extends StatefulWidget {
  final List<LeaveTypeData> leaveTypeList;

  const LeaveTypeSheet({Key? key, required this.leaveTypeList})
      : super(key: key);

  @override
  State<LeaveTypeSheet> createState() => _LeaveTypeSheetState();
}

class _LeaveTypeSheetState extends State<LeaveTypeSheet> {
  // List<String> leaveType = [
  //   'Sick Leave',
  //   'Paid Leave',
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      TextConstant.leaveType,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).pop();
                      Navigator.pop(context, TextConstant.leaveType);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.grey.shade900,
                    ),
                  )
                ],
              ),
              Divider(
                color: Colors.grey.shade500,
              ),
              ListView.separated(
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.leaveTypeList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 1.0, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(
                                    context, widget.leaveTypeList[index]);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.leaveTypeList[index].typeName!,
                                    style: const TextStyle(
                                        color: primaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
