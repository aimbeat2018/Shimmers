import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmers/controllers/tourController.dart';
import 'package:shimmers/screens/tourVisit/TourListWidget.dart';
import 'package:shimmers/screens/tourVisit/ticketPdfScreen.dart';
import 'package:shimmers/screens/tourVisit/tourImageScreen.dart';
import 'package:shimmers/screens/tourVisit/tourVisitDetails.dart';
import 'package:shimmers/screens/tourVisit/tourVisitScreen.dart';

import '../../constant/app_constants.dart';
import '../../constant/colorsConstant.dart';
import '../../constant/custom_snackbar.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../constant/route_helper.dart';
import '../../constant/textConstant.dart';
import '../campaigns/campaignsListWidget.dart';
import '../noDataFound/noDataFoundScreen.dart';
import 'package:path/path.dart' as p;

class TourListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TourListScreen();
  }
}

class _TourListScreen extends State<TourListScreen> {
  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool tour_allowed = true;

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
      Get.find<TourController>().getTourRequestList();
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
                  TextConstant.TourRequestList,
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
                  : tourController.exeTourDetailModel!.data == null ||
                          tourController.exeTourDetailModel!.data!.isEmpty
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
                                tourController.exeTourDetailModel!.data!.length,
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
                                                'Travel From: ${tourController.exeTourDetailModel!.data![index].travelFrom!}',
                                                style: TextStyle(
                                                    color: primaryColor,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            tourController.exeTourDetailModel!
                                                        .data![index].status! ==
                                                    0
                                                ? InkWell(
                                                    onTap: () {
                                                      Get.toNamed(RouteHelper
                                                              .getaddTourRequestRoute(
                                                                  tourController
                                                                      .exeTourDetailModel!
                                                                      .data![
                                                                          index]
                                                                      .id!
                                                                      .toString()))!
                                                          .then((value) {
                                                        setState(() {
                                                          Get.find<
                                                                  TourController>()
                                                              .getTourRequestList();
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
                                            tourController.exeTourDetailModel!
                                                        .data![index].status! ==
                                                    0
                                                ? InkWell(
                                                    onTap: () {
                                                      deleteTourRequest(
                                                          tourController
                                                              .exeTourDetailModel!
                                                              .data![index]
                                                              .id
                                                              .toString(),
                                                          tourController,
                                                          index);
                                                    },
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: primaryColor,
                                                    ),
                                                  )
                                                : SizedBox(),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            tourController
                                                            .exeTourDetailModel!
                                                            .data![index]
                                                            .status! ==
                                                        1 &&
                                                    tourController
                                                            .exeTourDetailModel!
                                                            .data![index]
                                                            .isVisited! ==
                                                        0
                                                ? InkWell(
                                                    onTap: () {
                                                      Get.toNamed(RouteHelper
                                                              .getaddTourVisitDetails(
                                                                  tourController
                                                                      .exeTourDetailModel!
                                                                      .data![
                                                                          index]
                                                                      .id!
                                                                      .toString()))
                                                          ?.then((value) {
                                                        setState(() {
                                                          Get.find<
                                                                  TourController>()
                                                              .getTourRequestList();
                                                        });
                                                      });
                                                      /* Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => TourVisitDetails(
                                          tour_requestid: tourController.exeTourDetailModel!.data![index].id!.toString())));*/
                                                    },
                                                    child: Icon(
                                                      Icons.save_as,
                                                      color: primaryColor,
                                                    ),
                                                  )
                                                : SizedBox(),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            tourController
                                                            .exeTourDetailModel!
                                                            .data![index]
                                                            .status! ==
                                                        1 &&
                                                    tourController
                                                            .exeTourDetailModel!
                                                            .data![index]
                                                            .isVisited! ==
                                                        1
                                                ? InkWell(
                                                    onTap: () {
                                                      Get.toNamed(RouteHelper
                                                          .viewSalonVisitDetailsRoute(
                                                              tourController
                                                                  .exeTourDetailModel!
                                                                  .data![index]
                                                                  .id!
                                                                  .toString()));
                                                      /* Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => TourVisitDetails(
                                          tour_requestid: tourController.exeTourDetailModel!.data![index].id!.toString())));*/
                                                    },
                                                    child: Icon(
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
                                              'Travel To: ${tourController.exeTourDetailModel!.data![index].travelTo!}',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            /*Text(
                                              'Travel To: ${tourController.exeTourDetailModel!.data![index].travelTo!}',
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
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Departure Date: ${tourController.exeTourDetailModel!.data![index].deptDate!.toString()}',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            tourController
                                                            .exeTourDetailModel!
                                                            .data![index]
                                                            .attachment ==
                                                        null ||
                                                    tourController
                                                            .exeTourDetailModel!
                                                            .data![index]
                                                            .attachment ==
                                                        ''
                                                ? SizedBox()
                                                : InkWell(
                                                    onTap: () {
                                                      final extension = p
                                                          .extension(tourController
                                                              .exeTourDetailModel!
                                                              .data![index]
                                                              .attachment!);
                                                      if (extension == '.pdf') {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => TicketPdfScreen(
                                                                    fileUrl: tourController
                                                                        .exeTourDetailModel!
                                                                        .data![
                                                                            index]
                                                                        .attachment!,from:'tour')));
                                                      } else {
                                                        //  showCustomSnackBar('File is Image',isError: false);
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        TourImageScreen(
                                                                          image_url: tourController
                                                                              .exeTourDetailModel!
                                                                              .data![index]
                                                                              .attachment!,
                                                                          extension:
                                                                              extension,from: 'tour',
                                                                        )));
                                                      }
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5.0),
                                                      child: Text(
                                                        'View Ticket',
                                                        // 'Remark: ${widget.model.remark ??'vff':widget.model.remark}',
                                                        style: TextStyle(
                                                            color: primaryColor,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Return Date: ${tourController.exeTourDetailModel!.data![index].returnDate!}',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'RSM Name: ${tourController.exeTourDetailModel!.data![index].rsmName!}',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Status: ${tourController.exeTourDetailModel!.data![index].status! == 0 ? 'Pending' : tourController.exeTourDetailModel!.data![index].status! == 1 ? 'Approved' : 'Rejected'}',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        tourController
                                                        .exeTourDetailModel!
                                                        .data![index]
                                                        .executiveRemark ==
                                                    null ||
                                                tourController
                                                        .exeTourDetailModel!
                                                        .data![index]
                                                        .executiveRemark ==
                                                    ''
                                            ? SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5.0),
                                                child: Text(
                                                  'Executive Remark: ${tourController.exeTourDetailModel!.data![index].executiveRemark!}',
                                                  // 'Remark: ${widget.model.remark ??'vff':widget.model.remark}',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                        tourController.exeTourDetailModel!
                                                        .data![index].remark ==
                                                    null ||
                                                tourController
                                                        .exeTourDetailModel!
                                                        .data![index]
                                                        .remark ==
                                                    ''
                                            ? SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5.0),
                                                child: Text(
                                                  'Manager Remark: ${tourController.exeTourDetailModel!.data![index].remark}',
                                                  // 'Remark: ${widget.model.remark ??'vff':widget.model.remark}',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                        tourController
                                                        .exeTourDetailModel!
                                                        .data![index]
                                                        .officeRemark ==
                                                    null ||
                                                tourController
                                                        .exeTourDetailModel!
                                                        .data![index]
                                                        .officeRemark ==
                                                    ''
                                            ? SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5.0),
                                                child: Text(
                                                  'Head Office Remark: ${tourController.exeTourDetailModel!.data![index].officeRemark}',
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
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endDocked,
              floatingActionButton: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: FloatingActionButton(
                  // isExtended: true,
                  child: Icon(Icons.add),
                  backgroundColor: primaryColor,
                  onPressed: () {
                   /* for(int i=0;i<tourController.exeTourDetailModel!.data!.length;i++)
                      {
                        if(tourController.exeTourDetailModel!.data![i].isVisited==0)
                          {
                            tour_allowed=false;
                          }
                      }*/
                    for(var tours in tourController.exeTourDetailModel!.data!)
                      {
                        if(tours.isVisited==0)
                          {
                            tour_allowed=false;
                          }
                      }
                    if (tour_allowed) {
                      Get.toNamed(RouteHelper.getaddTourRequestRoute('0'))
                          ?.then((value) {
                        setState(() {
                          Get.find<TourController>().getTourRequestList();
                        });
                      });
                    } else {
                      showCustomSnackBar(
                          'Please complete previous tour visit before adding new!',
                          isError: false);
                    }
                    /*Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TourVisitScreen(tour_requestid: 0)));*/
                  },
                ),
              ),
            );
          });
  }

  void deleteTourRequest(String? id, TourController tourController, int index) {
    Get.find<TourController>()
        .deleteTourRequest(tour_reqid: id)
        .then((message) async {
      if (message == 'Tour Request deleted successfully') {
        showCustomSnackBar(message!, isError: false);
        setState(() {
          tourController.exeTourDetailModel!.data!.removeAt(index);
        });
      } else {
        showCustomSnackBar(message!);
      }
    });
  }
}
