import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmers/constant/app_constants.dart';
import 'package:shimmers/constant/colorsConstant.dart';
import 'package:shimmers/constant/no_internet_screen.dart';
import 'package:shimmers/controllers/scoreController.dart';
import 'package:shimmers/screens/scoreCard/scoreCampaignDetailsScreen.dart';

import '../../constant/internetConnectivity.dart';
import '../noDataFound/noDataFoundScreen.dart';

class EmployeeCampaignDetails extends StatefulWidget {
  String userID, activityType, fromDate, toDate;

  EmployeeCampaignDetails(
      {required this.userID,
      required this.activityType,
      required this.fromDate,
      required this.toDate});

  @override
  State<StatefulWidget> createState() {
    return _EmployeeCampaignDetails();
  }
}

class _EmployeeCampaignDetails extends State<EmployeeCampaignDetails> {
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
      Get.find<ScoreController>().scoreCampaignDetailsList(
          user_id: widget.userID,
          activity_type: widget.activityType,
          from_date: widget.fromDate,
          to_Date: widget.toDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? NoInternetScreen()
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
              body: scoreController.isLoading &&
                      scoreController.scoreCampaignModel == null
                  ? Center(child: CircularProgressIndicator())
                  : scoreController.scoreCampaignModel!.data == null &&
                          scoreController.scoreCampaignModel!.data!.isEmpty
                      ? Center(
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: const NoDataFoundScreen()))
                      : Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: scoreController
                                  .scoreCampaignModel!.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 5.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                                  ScoreCampaignDetailsScreen(
                                                    userId: widget.userID,
                                                    campaignId: scoreController
                                                        .scoreCampaignModel!
                                                        .data![index]
                                                        .campaignId
                                                        .toString(),
                                                    salonId: scoreController
                                                        .scoreCampaignModel!
                                                        .data![index].salonId.toString(),fromDate: widget.fromDate,toDate: widget.toDate,
                                                  )));
                                    },
                                    child: Card(
                                      elevation: 5,
                                      shadowColor: primaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 18, vertical: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Campaign Name: ${scoreController.scoreCampaignModel!.data![index].campaignName!}',
                                              style: TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                                'Campaign Start Date: ${scoreController.scoreCampaignModel!.data![index].startDate!}',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                                'Campaign End Date: ${scoreController.scoreCampaignModel!.data![index].endDate!}',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                                'Salon Name: ${scoreController.scoreCampaignModel!.data![index].salonName!}',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            SizedBox(
                                              height: 5,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
            );
          });
  }
}
