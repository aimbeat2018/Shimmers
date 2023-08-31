import 'package:flutter/material.dart';
import 'package:shimmers/constant/colorsConstant.dart';

import '../../constant/textConstant.dart';

class LeaveDurationSheet extends StatefulWidget {
  const LeaveDurationSheet({Key? key}) : super(key: key);

  @override
  State<LeaveDurationSheet> createState() => _LeaveDurationSheetState();
}

class _LeaveDurationSheetState extends State<LeaveDurationSheet> {
  List<String> leaveType = [
    'Single',
    'Multiple',
    'First Half',
    'Second Half',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    TextConstant.leaveDuration,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Navigator.of(context).pop();
                    Navigator.pop(context, TextConstant.leaveDuration);
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
              itemCount: leaveType.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 1.0, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context, leaveType[index]);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  leaveType[index],
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
    );
  }
}
