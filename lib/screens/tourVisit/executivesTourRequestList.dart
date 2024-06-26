import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/app_constants.dart';
import '../../constant/colorsConstant.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../constant/route_helper.dart';
import '../../constant/textConstant.dart';
import '../../controllers/tourController.dart';
import '../noDataFound/noDataFoundScreen.dart';

class ExecutivesTourRequestList extends StatefulWidget {
  String? excutive_id;

  ExecutivesTourRequestList({this.excutive_id});

  @override
  State<StatefulWidget> createState() {
    return _ExecutivesTourRequestList();
  }
}

class _ExecutivesTourRequestList extends State<ExecutivesTourRequestList> {
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
      // Get.find<CampaignController>().getEmployeeCampaignList(userId);

      Get.find<TourController>().getExecutivesTourRequestList(
          exe_id: widget.excutive_id); //pass the executives ID here
    }
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<TourController>(builder: (tourController) {
            return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
                backgroundColor: primaryColor,
                centerTitle: true,
                title: Text(
                  'Executives Tour Request List',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: tourController.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : tourController.tourRequestListModel!.tourRequestList ==
                              null ||
                          tourController
                              .tourRequestListModel!.tourRequestList!.isEmpty
                      ? Center(
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: const NoDataFoundScreen()))
                      : Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: ListView.builder(
                            // physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: tourController
                                .tourRequestListModel!.tourRequestList!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 5.0),
                                child: Card(
                                  elevation: 5,
                                  shadowColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18.0, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Travel From: ${tourController.tourRequestListModel!.tourRequestList![index].travelFrom!}',
                                                style: TextStyle(
                                                    color: primaryColor,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            tourController
                                                        .tourRequestListModel!
                                                        .tourRequestList![index]
                                                        .status! ==
                                                    0
                                                ? InkWell(
                                                    onTap: () {
                                                      Get.toNamed(RouteHelper
                                                              .getexecutiveTourRequestDetails(
                                                                  tourController
                                                                      .tourRequestListModel!
                                                                      .tourRequestList![
                                                                          index]
                                                                      .id!
                                                                      .toString()))!
                                                          .then((value) {
                                                        setState(() {
                                                          Get.find<
                                                                  TourController>()
                                                              .getExecutivesTourRequestList(
                                                                  exe_id: widget
                                                                      .excutive_id);
                                                        });
                                                      });

                                                      /*Navigator.of(context).push(MaterialPageRoute(
                                                          builder: (context) => TourVisitScreen(
                                                              tour_requestid:
                                                                  tourController
                                                                      .exeTourDetailModel!
                                                                      .data![
                                                                          index]
                                                                      .id!
                                                                      .toString())));*/
                                                    },
                                                    child: Icon(
                                                      Icons.edit,
                                                      color: primaryColor,
                                                    ))
                                                : SizedBox(),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            tourController.tourRequestListModel!
                                                .tourRequestList![index].isVisited! ==
                                                1
                                                ? InkWell(
                                              onTap: () {
                                                Get.toNamed(RouteHelper
                                                    .viewSalonVisitDetailsRoute(
                                                    tourController
                                                        .tourRequestListModel!
                                                        .tourRequestList![index]
                                                        .id!
                                                        .toString()));
                                                /* Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => TourVisitDetails(
                                          tour_requestid: tourController.exeTourDetailModel!.data![index].id!.toString())));*/
                                              },
                                              child:Icon(
                                                Icons.remove_red_eye,
                                                color: primaryColor,
                                              ),
                                            )
                                                : SizedBox(),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Travel To: ${tourController.tourRequestListModel!.tourRequestList![index].travelTo!}',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                           /* Text(
                                              'Time: ${tourController.tourRequestListModel!.tourRequestList![index].time!}',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),*/
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Depature Date: ${tourController.tourRequestListModel!.tourRequestList![index].deptDate!.toString()}',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Return Date: ${tourController.tourRequestListModel!.tourRequestList![index].returnDate!.toString()}',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'No. of Days: ${tourController.tourRequestListModel!.tourRequestList![index].noOfDays!}',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Status: ${tourController.tourRequestListModel!.tourRequestList![index].status! == 0 ? 'Pending' : tourController.tourRequestListModel!.tourRequestList![index].status! == 1 ? 'Approved' : 'Rejected'}',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        tourController
                                                        .tourRequestListModel!
                                                        .tourRequestList![index]
                                                        .executiveRemark ==
                                                    null ||
                                                tourController
                                                        .tourRequestListModel!
                                                        .tourRequestList![index]
                                                        .executiveRemark ==
                                                    ''
                                            ? SizedBox()
                                            : Padding(
                                              padding: const EdgeInsets.only(top: 5.0),
                                              child: Text(
                                                  'Executive Remark: ${tourController.tourRequestListModel!.tourRequestList![index].executiveRemark!}',
                                                  // 'Remark: ${widget.model.remark ??'vff':widget.model.remark}',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                            ),
                                        tourController
                                                        .tourRequestListModel!
                                                        .tourRequestList![index]
                                                        .remark ==
                                                    null ||
                                                tourController
                                                        .tourRequestListModel!
                                                        .tourRequestList![index]
                                                        .remark ==
                                                    ''
                                            ? SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5.0),
                                                child: Text(
                                                  'Manager Remark: ${tourController.tourRequestListModel!.tourRequestList![index].remark}',
                                                  // 'Remark: ${widget.model.remark ??'vff':widget.model.remark}',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                                  /*TourListWidget(
                model: tourController
                    .exeTourDetailModel!.data![index],
              )*/
                                  ;
                            },
                          ),
                        ),
            );
          });
  }
}
