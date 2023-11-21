import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../constant/app_constants.dart';
import '../../constant/colorsConstant.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../constant/route_helper.dart';
import '../../constant/textConstant.dart';
import '../../controllers/tourController.dart';
import '../noDataFound/noDataFoundScreen.dart';

class HeadOfficerTourRequests extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HeadOfficerTourRequests();
  }

}
class _HeadOfficerTourRequests extends State{
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
      Get.find<TourController>().getHeadOfficeToursList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<TourController>(builder: (tourController) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Text(
            TextConstant.TourRequestList,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: tourController.isLoading &&
            tourController.headOfficeRequestList == null
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : tourController.headOfficeRequestList!.data == null
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
            itemCount:
            tourController.headOfficeRequestList!.data!.length,
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
                                'Area: ${tourController.headOfficeRequestList!.data![index].area!}',
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight.bold),
                              ),
                            ),
                            tourController.headOfficeRequestList!
                                .data![index].status! ==
                                1
                                ? InkWell(
                                onTap: () {
                                  Get.toNamed(RouteHelper
                                      .updateTourdetailsByHeadOffice(
                                      tourController
                                          .headOfficeRequestList!
                                          .data![index]
                                          .id!
                                          .toString()));

                                  /*Navigator.of(context).push(MaterialPageRoute(
                                                          builder: (context) => TourVisitScreen(
                                                              tour_requestid:
                                                                  tourController
                                                                      .headOfficeRequestList!
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
                              'Date: ${tourController.headOfficeRequestList!.data![index].date!}',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Time: ${tourController.headOfficeRequestList!.data![index].time!}',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Amount: ${tourController.headOfficeRequestList!.data![index].amount!.toString()}',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Status: ${tourController.headOfficeRequestList!.data![index].status! == 0 ? 'Pending' : tourController.headOfficeRequestList!.data![index].status! == 1 ? 'Approved' : 'Rejected'}',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        tourController
                            .headOfficeRequestList!
                            .data![index]
                            .executiveRemark ==
                            null ||
                            tourController
                                .headOfficeRequestList!
                                .data![index]
                                .executiveRemark ==
                                ''
                            ? SizedBox()
                            : Text(
                          'Executive Remark: ${tourController.headOfficeRequestList!.data![index].executiveRemark!}',
                          // 'Remark: ${widget.model.remark ??'vff':widget.model.remark}',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight:
                              FontWeight.w500),
                        ),
                        tourController.headOfficeRequestList!
                            .data![index].remark ==
                            null ||
                            tourController
                                .headOfficeRequestList!
                                .data![index]
                                .remark ==
                                ''
                            ? SizedBox()
                            : Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0),
                          child: Text(
                            'Manager Remark: ${tourController.headOfficeRequestList!.data![index].remark}',
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
                    .headOfficeRequestList!.data![index],
              )*/
              ;
            },
          ),
        ),

      );
    });
  }

}