import 'package:flutter/material.dart';
import 'package:shimmers/constant/colorsConstant.dart';

import '../../model/campaignQuestionListModel.dart';

class AnswersListSheet extends StatefulWidget {
  final List<Answer> answerList;

  const AnswersListSheet({Key? key, required this.answerList})
      : super(key: key);

  @override
  State<AnswersListSheet> createState() => _AnswersListSheetState();
}

class _AnswersListSheetState extends State<AnswersListSheet> {
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
                      "Select Answer",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).pop();
                      Navigator.pop(context, "");
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
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.answerList.length,
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
                                    context, widget.answerList[index].key);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.answerList[index].key!,
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
