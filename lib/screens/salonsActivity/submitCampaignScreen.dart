import 'package:flutter/material.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/globalFunction.dart';
import '../../constant/textConstant.dart';
import '../../model/campaignModel.dart';
import 'answersListSheet.dart';

class SubmitCampaignScreen extends StatefulWidget {
  static const String name = 'submitCampaignScreen';

  const SubmitCampaignScreen({Key? key}) : super(key: key);

  @override
  State<SubmitCampaignScreen> createState() => _SubmitCampaignScreenState();
}

class _SubmitCampaignScreenState extends State<SubmitCampaignScreen> {
  List<CampaignModel> campaignList = [
    CampaignModel(
        question: "Upload Salon images?",
        answers: "",
        answersList: [],
        type: "image",
        image: ""),
    CampaignModel(
        question: "What is salon Category?",
        answers: "",
        answersList: [
          AnswersList(name: "New"),
          AnswersList(name: "Existing"),
        ],
        type: "list",
        image: ""),
    CampaignModel(
        question: "What is salon Category?",
        answers: "",
        answersList: [
          AnswersList(name: "New"),
          AnswersList(name: "Existing"),
          AnswersList(name: "Existing"),
          AnswersList(name: "Existing"),
          AnswersList(name: "Existing"),
          AnswersList(name: "Existing"),
          AnswersList(name: "Existing"),
          AnswersList(name: "Existing"),
        ],
        type: "multiple",
        image: ""),
    CampaignModel(
        question: "What is salon Category?",
        answers: "",
        answersList: [],
        type: "input",
        image: ""),
    CampaignModel(
        question: "What is salon Category?",
        answers: "",
        answersList: [
          AnswersList(name: "New"),
          AnswersList(name: "Existing"),
        ],
        type: "list",
        image: ""),
    CampaignModel(
        question: "Enter salon Address?",
        answers: "",
        answersList: [],
        type: "input",
        image: ""),
    CampaignModel(
        question: "What is salon Category?",
        answers: "",
        answersList: [],
        type: "image",
        image: ""),
    CampaignModel(
        question: "Is Salon Open?",
        answers: "",
        answersList: [
          AnswersList(name: "Yes"),
          AnswersList(name: "No"),
        ],
        type: "multiple",
        image: ""),
  ];
  String? selectedValue;
  bool? isValueSelected = false;
  int selectedId = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          TextConstant.Campaigns,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
          child: Column(
            children: [
              Card(
                elevation: 5,
                shadowColor: primaryColor,
                color: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Purple - The Family Salon',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Please note - this is to be filled by the trainers whenever they do any market visit.',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'From: 18Aug2023',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'To: 18Aug2023',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: campaignList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          campaignList[index].question!,
                          style: const TextStyle(
                              color: primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        if (campaignList[index].type! == "list")
                          Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => AnswersListSheet(),
                                    backgroundColor: Colors.transparent,
                                  ).then((value) => {
                                        setState(() {
                                          selectedValue = value!;
                                        })
                                      });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: primaryColor)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            selectedValue == null
                                                ? ""
                                                : selectedValue!,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                          ),
                                        )),
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.grey.shade700,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if (campaignList[index].type! == "image")
                          Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                      // boxShadow: const [
                                      //   BoxShadow(
                                      //     color: primaryColor,
                                      //     blurRadius: 12.0, // soften the shadow
                                      //     spreadRadius: 0.5, //extend the shadow
                                      //     offset: Offset(
                                      //       1.0, // Move to right 5  horizontally
                                      //       1.0, // Move to bottom 5 Vertically
                                      //     ),
                                      //   )
                                      // ],
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: primaryColor)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 35.0, vertical: 50),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          TextConstant.takePhoto,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if (campaignList[index].type! == "multiple")
                          Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    campaignList[index].answersList!.length,
                                itemBuilder:
                                    (BuildContext context, int index1) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 5),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (isValueSelected!) {
                                            isValueSelected = false;
                                            // campaignList[index].answers =
                                            //     campaignList[index]
                                            //         .answersList![index1]
                                            //         .name!;
                                          } else {
                                            isValueSelected = true;
                                          }
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Icon(!isValueSelected!
                                              ? Icons
                                                  .check_box_outline_blank_outlined
                                              : Icons.check_box),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            campaignList[index]
                                                .answersList![index1]
                                                .name!,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        if (campaignList[index].type! == "input")
                          Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  // showModalBottomSheet(
                                  //   context: context,
                                  //   builder: (context) => LeaveTypeSheet(),
                                  //   backgroundColor: Colors.transparent,
                                  // ).then((value) => {
                                  //   setState(() {
                                  //     selectedLeaveType = value!;
                                  //   })
                                  // });
                                },
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 14),
                                  maxLines: 5,
                                  decoration:
                                      GlobalFunctions.getInputDecoration(""),
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ],
                          ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(primaryColor),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(primaryColor),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        const TextStyle(fontSize: 16),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () {
                      // Navigator.of(context)
                      //     .push(MaterialPageRoute(
                      //   builder: (context) =>
                      //       MainScreen(),
                      // ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        TextConstant.submit.toUpperCase(),
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
    );
  }
}
