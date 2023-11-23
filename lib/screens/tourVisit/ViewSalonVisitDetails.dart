import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/app_constants.dart';
import '../../constant/colorsConstant.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../controllers/tourController.dart';
import '../../model/tourVisitModel.dart';
import '../../model/tourdetailsByIdModel.dart';
import '../noDataFound/noDataFoundScreen.dart';

class ViewSalonVisitDetails extends StatefulWidget{
  String tour_requestid;

  ViewSalonVisitDetails({required this.tour_requestid});

  @override
  State<StatefulWidget> createState() {
    return _ViewSalonVisitDetails();
  }

}
class _ViewSalonVisitDetails extends State<ViewSalonVisitDetails>{
  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  TourVisitModel? tourVisitModel;


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
    if (widget.tour_requestid! != '0') {
      if (_connectionStatus != AppConstants.connectivityCheck) {
        if (mounted) {
          Future.delayed(Duration.zero, () async {
            tourVisitModel = await Get.find<TourController>()
                .getTourVisitDetails(
                tour_reqid: widget.tour_requestid.toString());
            /* if (tourDetailsByIdModel != null) {
              // remarksController.text=tourDetailsByIdModel!.data![0].remark!;
              tourDetailsByIdModel!.data![0].executiveRemark == null ||
                  tourDetailsByIdModel!.data![0].executiveRemark! == ''
                  ? remarksController.text = ''
                  : remarksController.text =
              tourDetailsByIdModel!.data![0].executiveRemark!;
              purposeController.text = tourDetailsByIdModel!.data![0].purpose!;
              areaController.text =
                  tourDetailsByIdModel!.data![0].area!.toString();
              amountController.text =
                  tourDetailsByIdModel!.data![0].amount!.toString();
              selectedDate = tourDetailsByIdModel!.data![0].date!;
              selectedTime = tourDetailsByIdModel!.data![0].time!;
            }*/
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController remarksController = TextEditingController();
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<TourController>(builder: (tourController) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Text(
            'Tour Visit Details',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: tourVisitModel == null
            ? const Center(child: CircularProgressIndicator())
            : tourVisitModel!.tourVisitDetailModel == null ||
            tourVisitModel!.tourVisitDetailModel!.isEmpty
            ? Center(
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const NoDataFoundScreen()))
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 15.0, vertical: 20),
            child: Column(
              children: [
                Card(
                  elevation: 2,
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
                                'Area: ${tourVisitModel!.tourVisitDetailModel![0].area!}',
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight.bold),
                              ),
                            ),
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
                              'Date: ${tourVisitModel!.tourVisitDetailModel![0].date!}',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Time: ${tourVisitModel!.tourVisitDetailModel![0].time!}',
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
                          'Role: ${tourVisitModel!.tourVisitDetailModel![0].role!}',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Name: ${tourVisitModel!.tourVisitDetailModel![0].name}',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Contact: ${tourVisitModel!.tourVisitDetailModel![0].contact!.toString()}',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Description: ${tourVisitModel!.tourVisitDetailModel![0].description!.toString()}',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),

                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      );
    });
  }


}