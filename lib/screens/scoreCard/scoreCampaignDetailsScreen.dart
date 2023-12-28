import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmers/constant/api/api_client.dart';
import 'package:shimmers/constant/app_constants.dart';
import 'package:shimmers/constant/no_internet_screen.dart';
import 'package:shimmers/controllers/salonController.dart';
import 'package:shimmers/controllers/scoreController.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/globalFunction.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/textConstant.dart';
import '../noDataFound/noDataFoundScreen.dart';

class ScoreCampaignDetailsScreen extends StatefulWidget {
  String userId,
      campaignId,
      salonId,
      fromDate,
      toDate,
      cstartDate,
      cendDate,
      salonName,
      campaignName;

  ScoreCampaignDetailsScreen(
      {required this.userId,
      required this.campaignId,
      required this.salonId,
      required this.fromDate,
      required this.toDate,
      required this.cstartDate,
      required this.cendDate,
      required this.salonName,
      required this.campaignName});

  @override
  State<StatefulWidget> createState() {
    return _ScoreCampaignDetailsScreen();
  }
}

class _ScoreCampaignDetailsScreen extends State<ScoreCampaignDetailsScreen> {
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
    if (mounted) {
      Get.find<ScoreController>().userCampaignAnswerList(
          userid: widget.userId,
          campaignid: widget.campaignId,
          salonid: widget.salonId,
          fromdate: widget.fromDate,
          todate: widget.toDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? Center(child: NoInternetScreen())
        : GetBuilder<ScoreController>(builder: (scoreController) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                centerTitle: true,
                title: Text(
                  'Campaign Details',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                                widget.campaignName!,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'From: ${widget.cstartDate}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    'To: ${widget.cendDate}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.salonName,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      scoreController.isLoading
                          ? Center(child: CircularProgressIndicator())
                          : scoreController.userCampaignAnswerModel!.data ==
                                      null ||
                                  scoreController
                                      .userCampaignAnswerModel!.data!.isEmpty
                              ? Center(
                                  child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                      child: const NoDataFoundScreen()))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: scoreController
                                      .userCampaignAnswerModel!.data!.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            scoreController
                                                .userCampaignAnswerModel!
                                                .data![index]
                                                .question!,
                                            style: TextStyle(
                                                color: primaryColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16),
                                          ),
                                          if (scoreController
                                                  .userCampaignAnswerModel!
                                                  .data![index]
                                                  .answerType! ==
                                              'dropdown')
                                            Column(
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    /*showModalBottomSheet(
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
                                                    });*/
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
                                                              scoreController
                                                                          .userCampaignAnswerModel!
                                                                          .data![
                                                                              index]
                                                                          .userAnswer ==
                                                                      ""
                                                                  ? ""
                                                                  : scoreController
                                                                      .userCampaignAnswerModel!
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
                                          if (scoreController
                                                  .userCampaignAnswerModel!
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
                                                  itemCount: scoreController
                                                      .userCampaignAnswerModel!
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
/*
                                                          setState(() {
                                                            if (scoreController
                                                                .userCampaignAnswerModel!
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
*/
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Icon(!scoreController
                                                                    .userCampaignAnswerModel!
                                                                    .data![
                                                                        index]
                                                                    .userAnswer!
                                                                    .contains(scoreController
                                                                        .userCampaignAnswerModel!
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
                                                              scoreController
                                                                  .userCampaignAnswerModel!
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
                                          if (scoreController
                                                  .userCampaignAnswerModel!
                                                  .data![index]
                                                  .answerType! ==
                                              'textbox')
                                            Column(
                                              children: [
                                                SizedBox(
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
                                                  controller: TextEditingController(
                                                      text:
                                                          "${scoreController.userCampaignAnswerModel!.data![index].userAnswer}"),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      scoreController
                                                          .userCampaignAnswerModel!
                                                          .data![index]
                                                          .userAnswer = value;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          if (scoreController
                                                  .userCampaignAnswerModel!
                                                  .data![index]
                                                  .answerType! ==
                                              'text')
                                            Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                TextFormField(
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                  maxLines: 1,
                                                  decoration: GlobalFunctions
                                                      .getInputDecoration(""),
                                                  keyboardType:
                                                      TextInputType.text,
                                                  controller: TextEditingController(
                                                      text: scoreController
                                                          .userCampaignAnswerModel!
                                                          .data![index]
                                                          .userAnswer),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      scoreController
                                                          .userCampaignAnswerModel!
                                                          .data![index]
                                                          .userAnswer = value;
                                                    });
                                                  },
                                                )
                                              ],
                                            ),
                                          if (scoreController
                                                  .userCampaignAnswerModel!
                                                  .data![index]
                                                  .answerType ==
                                              'number')
                                            Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                TextFormField(
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                  maxLines: 1,
                                                  decoration: GlobalFunctions
                                                      .getInputDecoration(''),
                                                  keyboardType:
                                                      TextInputType.text,
                                                  controller: TextEditingController(
                                                      text: scoreController
                                                          .userCampaignAnswerModel!
                                                          .data![index]
                                                          .userAnswer),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      scoreController
                                                          .userCampaignAnswerModel!
                                                          .data![index]
                                                          .userAnswer = value;
                                                    });
                                                  },
                                                )
                                              ],
                                            ),
                                          if (scoreController
                                                  .userCampaignAnswerModel!
                                                  .data![index]
                                                  .answerType ==
                                              'date')
                                            Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                TextFormField(
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                  controller: TextEditingController(
                                                      text: scoreController
                                                          .userCampaignAnswerModel!
                                                          .data![index]
                                                          .userAnswer),
                                                  maxLines: 1,
                                                  decoration: GlobalFunctions.getInputDecoration(''),
                                                  keyboardType: TextInputType.text,
                                                  onChanged: (value){
                                                    setState(() {
                                                      scoreController
                                                          .userCampaignAnswerModel!
                                                          .data![index]
                                                          .userAnswer = value;
                                                    });
                                                  },

                                                )
                                              ],
                                            )
                                        ],
                                      ),
                                    );
                                  })
                    ],
                  ),
                ),
              ),
            );
          });
  }
}
