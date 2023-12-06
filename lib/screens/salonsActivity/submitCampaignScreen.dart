import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmers/model/campaignListModel.dart';
import 'package:shimmers/model/submitCampaignRequestmodel.dart';

import '../../constant/app_constants.dart';
import '../../constant/colorsConstant.dart';
import '../../constant/custom_snackbar.dart';
import '../../constant/globalFunction.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../constant/textConstant.dart';
import '../../controllers/salonController.dart';
import '../noDataFound/noDataFoundScreen.dart';
import 'answersListSheet.dart';

class SubmitCampaignScreen extends StatefulWidget {
  static const String name = 'submitCampaignScreen';
  final CampaignListData model;
  final int salonId;

  const SubmitCampaignScreen(
      {Key? key, required this.model, required this.salonId})
      : super(key: key);

  @override
  State<SubmitCampaignScreen> createState() => _SubmitCampaignScreenState();
}

class _SubmitCampaignScreenState extends State<SubmitCampaignScreen> {
  String? selectedValue;
  bool? isValueSelected = false;
  int selectedId = -1;

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

    if (_connectionStatus != AppConstants.connectivityCheck) {
      Get.find<SalonController>()
          .getCampaignQuestionList(campaignId: widget.model.id.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<SalonController>(builder: (salonController) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                centerTitle: true,
                title: Text(
                  TextConstant.Campaigns,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 15),
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
                                widget.model.name!,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              // SizedBox(
                              //   height: 5,
                              // ),
                              // Text(
                              //   'Please note - this is to be filled by the trainers whenever they do any market visit.',
                              //   style: TextStyle(
                              //       color: Colors.white,
                              //       fontSize: 13,
                              //       fontWeight: FontWeight.normal),
                              // ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'From: ${widget.model.startDate}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    'To: ${widget.model.endDate}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      salonController.isLoading &&
                              salonController.campaignQuestionListModel == null
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : salonController.campaignQuestionListModel!.data!
                                      .isEmpty ||
                                  salonController
                                          .campaignQuestionListModel!.data ==
                                      null
                              ? Center(
                                  child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                      child: const NoDataFoundScreen()))
                              : ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: salonController
                                      .campaignQuestionListModel!.data!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            salonController
                                                .campaignQuestionListModel!
                                                .data![index]
                                                .question!,
                                            style: const TextStyle(
                                                color: primaryColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          if (salonController
                                                  .campaignQuestionListModel!
                                                  .data![index]
                                                  .answerType! ==
                                              "dropdown")
                                            Column(
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    showModalBottomSheet(
                                                      context: context,
                                                      builder: (context) =>
                                                          AnswersListSheet(
                                                        answerList: salonController
                                                            .campaignQuestionListModel!
                                                            .data![index]
                                                            .answer!,
                                                      ),
                                                      backgroundColor:
                                                          Colors.transparent,
                                                    ).then((value) => {
                                                          setState(() {
                                                            selectedValue =
                                                                value!;

                                                            salonController
                                                                    .campaignQuestionListModel!
                                                                    .data![index]
                                                                    .userAnswer =
                                                                selectedValue;
                                                          })
                                                        });
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        border: Border.all(
                                                            color:
                                                                primaryColor)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                              child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0),
                                                            child: Text(
                                                              salonController
                                                                          .campaignQuestionListModel!
                                                                          .data![
                                                                              index]
                                                                          .userAnswer ==
                                                                      ""
                                                                  ? ""
                                                                  : salonController
                                                                      .campaignQuestionListModel!
                                                                      .data![
                                                                          index]
                                                                      .userAnswer!,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 14),
                                                            ),
                                                          )),
                                                          Icon(
                                                            Icons
                                                                .keyboard_arrow_down,
                                                            color: Colors
                                                                .grey.shade700,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          if (salonController
                                                  .campaignQuestionListModel!
                                                  .data![index]
                                                  .answerType! ==
                                              "multiple_dropdown")
                                            Column(
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                ListView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: salonController
                                                      .campaignQuestionListModel!
                                                      .data![index]
                                                      .answer!
                                                      .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index1) {
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8.0,
                                                          horizontal: 5),
                                                      child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            if (salonController
                                                                .campaignQuestionListModel!
                                                                .data![index]
                                                                .selectedAnswerList!
                                                                .contains(salonController
                                                                    .campaignQuestionListModel!
                                                                    .data![
                                                                        index]
                                                                    .answer![
                                                                        index1]
                                                                    .key!)) {
                                                              salonController
                                                                  .campaignQuestionListModel!
                                                                  .data![index]
                                                                  .selectedAnswerList!
                                                                  .remove(salonController
                                                                      .campaignQuestionListModel!
                                                                      .data![
                                                                          index]
                                                                      .answer![
                                                                          index1]
                                                                      .key!);
                                                            } else {
                                                              salonController
                                                                  .campaignQuestionListModel!
                                                                  .data![index]
                                                                  .selectedAnswerList!
                                                                  .add(salonController
                                                                      .campaignQuestionListModel!
                                                                      .data![
                                                                          index]
                                                                      .answer![
                                                                          index1]
                                                                      .key!);
                                                            }

                                                            // if (isValueSelected!) {
                                                            //   isValueSelected = false;
                                                            //   // campaignList[index].answers =
                                                            //   //     campaignList[index]
                                                            //   //         .answersList![index1]
                                                            //   //         .name!;
                                                            // } else {
                                                            //   isValueSelected = true;
                                                            // }
                                                          });
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Icon(!salonController
                                                                    .campaignQuestionListModel!
                                                                    .data![
                                                                        index]
                                                                    .selectedAnswerList!
                                                                    .contains(salonController
                                                                        .campaignQuestionListModel!
                                                                        .data![
                                                                            index]
                                                                        .answer![
                                                                            index1]
                                                                        .key!)
                                                                ? Icons
                                                                    .check_box_outline_blank_outlined
                                                                : Icons
                                                                    .check_box),
                                                            SizedBox(
                                                              width: 8,
                                                            ),
                                                            Text(
                                                              salonController
                                                                  .campaignQuestionListModel!
                                                                  .data![index]
                                                                  .answer![
                                                                      index1]
                                                                  .key!,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          if (salonController
                                                  .campaignQuestionListModel!
                                                  .data![index]
                                                  .answerType! ==
                                              "textbox")
                                            Column(
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextFormField(
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                  maxLines: 5,
                                                  decoration: GlobalFunctions
                                                      .getInputDecoration(""),
                                                  keyboardType:
                                                      TextInputType.text,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      salonController
                                                          .campaignQuestionListModel!
                                                          .data![index]
                                                          .userAnswer = value;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          if (salonController
                                                  .campaignQuestionListModel!
                                                  .data![index]
                                                  .answerType! ==
                                              "text")
                                            Column(
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextFormField(
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                  maxLines: 1,
                                                  decoration: GlobalFunctions
                                                      .getInputDecoration(""),
                                                  keyboardType:
                                                      TextInputType.text,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      salonController
                                                          .campaignQuestionListModel!
                                                          .data![index]
                                                          .userAnswer = value;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          if (salonController
                                                  .campaignQuestionListModel!
                                                  .data![index]
                                                  .answerType! ==
                                              "number")
                                            Column(
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextFormField(
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                  maxLines: 1,
                                                  decoration: GlobalFunctions
                                                      .getInputDecoration(""),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      salonController
                                                          .campaignQuestionListModel!
                                                          .data![index]
                                                          .userAnswer = value;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          if (salonController
                                                  .campaignQuestionListModel!
                                                  .data![index]
                                                  .answerType! ==
                                              "date")
                                            Column(
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    DateTime? pickedDate =
                                                        await showDatePicker(
                                                            context: context,
                                                            initialDate:
                                                                DateTime.now(),
                                                            firstDate:
                                                                DateTime(2000),
                                                            //DateTime.now() - not to allow to choose before today.
                                                            lastDate:
                                                                DateTime(2101));

                                                    if (pickedDate != null) {
                                                      print(
                                                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                      String formattedDate =
                                                          DateFormat(
                                                                  'yyyy-MM-dd')
                                                              .format(
                                                                  pickedDate);
                                                      print(
                                                          formattedDate); //formatted date output using intl package =>  2021-03-16
                                                      //you can implement different kind of Date Format here according to your requirement

                                                      setState(() {
                                                        salonController
                                                                .campaignQuestionListModel!
                                                                .data![index]
                                                                .userAnswer =
                                                            formattedDate;
                                                      });
                                                    } else {
                                                      print(
                                                          "Date is not selected");
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        border: Border.all(
                                                            color:
                                                                primaryColor)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                              child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0),
                                                            child: Text(
                                                              salonController
                                                                          .campaignQuestionListModel!
                                                                          .data![
                                                                              index]
                                                                          .userAnswer ==
                                                                      null
                                                                  ? ""
                                                                  : salonController
                                                                      .campaignQuestionListModel!
                                                                      .data![
                                                                          index]
                                                                      .userAnswer!,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 14),
                                                            ),
                                                          )),
                                                          Icon(
                                                            Icons
                                                                .calendar_month,
                                                            color: Colors
                                                                .grey.shade700,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: 200,
                        child: salonController.isLoading
                            ? Center(
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
                                  SubmitCampaignRequestModel model =
                                      SubmitCampaignRequestModel();
                                  model.campaignId = widget.model.id;
                                  model.salonId = widget.salonId;
                                  model.is_on_tour=int.parse(Get.find<SalonController>().getonTour());
                                  List<UsersAnswer> userAnswersList = [];
                                  for (var campaignQuestionData
                                      in salonController
                                          .campaignQuestionListModel!.data!) {
                                    UsersAnswer userAnswer = UsersAnswer();
                                    userAnswer.questionId =
                                        campaignQuestionData.id;

                                    List<Answers> answersList = [];
                                    for (var string in campaignQuestionData
                                        .selectedAnswerList!) {
                                      Answers userAnswer = Answers();
                                      userAnswer.key = string;

                                      answersList.add(userAnswer);
                                    }
                                    userAnswer.answers = answersList;
                                    userAnswer.singleAnswer =
                                        campaignQuestionData.userAnswer;

                                    userAnswersList.add(userAnswer);
                                  }
                                  model.answer = userAnswersList;

                                  submitCampaignData(salonController, model);
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
          });
  }

  Future<void> submitCampaignData(
      SalonController salonController, SubmitCampaignRequestModel model) async {
    salonController.submitCampaignData(model).then((message) async {
      if (message == 'Answer submitted successfully.') {
        showCustomSnackBar(message!, isError: false);
        Navigator.pop(context);
      } else {
        showCustomSnackBar(message!);
      }
    });
  }
}
