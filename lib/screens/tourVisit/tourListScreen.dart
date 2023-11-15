import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmers/controllers/tourController.dart';
import 'package:shimmers/screens/tourVisit/TourListWidget.dart';
import 'package:shimmers/screens/tourVisit/tourVisitDetails.dart';
import 'package:shimmers/screens/tourVisit/tourVisitScreen.dart';

import '../../constant/app_constants.dart';
import '../../constant/colorsConstant.dart';
import '../../constant/custom_snackbar.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../constant/textConstant.dart';
import '../campaigns/campaignsListWidget.dart';
import '../noDataFound/noDataFoundScreen.dart';

class TourListScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _TourListScreen();
  }

}
class _TourListScreen extends State<TourListScreen>{
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
            tourController.exeTourDetailModel == null
            ? const Center(
          child: CircularProgressIndicator(),
        )
            :  tourController.exeTourDetailModel!.data == null
            ? Center(
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const NoDataFoundScreen()))
            : Padding(padding: EdgeInsets.only(bottom: 10),
              child: ListView.builder(
         // physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: tourController
                .exeTourDetailModel!.data!.length,
          itemBuilder: (BuildContext context, int index) {
              return
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5.0),
                  child: Card(
                    elevation: 5,
                    shadowColor: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Area: ${tourController.exeTourDetailModel!.data![index].area!}',
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              tourController.exeTourDetailModel!.data![index].status! == 0?
                              InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => TourVisitScreen(
                                            tour_requestid: tourController.exeTourDetailModel!.data![index].id!)));
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: primaryColor,
                                  )) : SizedBox(),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: (){
                                  deleteTourRequest(tourController.exeTourDetailModel!.data![index].id.toString(),tourController,index);
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => TourVisitDetails(
                                          tour_requestid: tourController.exeTourDetailModel!.data![index].id!.toString())));                                },
                                child: Icon(
                                  Icons.file_copy_outlined,
                                  color: primaryColor,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Date: ${tourController.exeTourDetailModel!.data![index].date!}',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Time: ${tourController.exeTourDetailModel!.data![index].time!}',
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
                            'Amount: ${tourController.exeTourDetailModel!.data![index].amount!.toString()}',
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
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            tourController.exeTourDetailModel!.data![index].remark == null || tourController.exeTourDetailModel!.data![index].remark == ''
                                ? ''
                                : 'Remark: ${tourController.exeTourDetailModel!.data![index].remark}',
                            // 'Remark: ${widget.model.remark ??'vff':widget.model.remark}',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),

                        ],
                      ),
                    ),
                  ),
                )
                /*TourListWidget(
                model: tourController
                    .exeTourDetailModel!.data![index],
              )*/;
          },
        ),
            ),

        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: FloatingActionButton(
            // isExtended: true,
            child: Icon(Icons.add),
            backgroundColor: primaryColor,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TourVisitScreen(tour_requestid: 0)));

            },
          ),
        ),

      );
    });
  }
  void deleteTourRequest(String? id,TourController tourController,int index) {
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