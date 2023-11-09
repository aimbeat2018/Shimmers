import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmers/controllers/tourController.dart';
import 'package:shimmers/screens/tourVisit/TourListWidget.dart';

import '../../constant/app_constants.dart';
import '../../constant/colorsConstant.dart';
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
            TextConstant.Campaigns,
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
            : ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: tourController
              .exeTourDetailModel!.data!.length,
          itemBuilder: (BuildContext context, int index) {
            return TourListWidget(
              model: tourController
                  .exeTourDetailModel!.data![index],
            );
          },
        ),
      );
    });
  }

}