import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmers/constant/textConstant.dart';
import 'package:shimmers/controllers/authController.dart';
import 'package:shimmers/controllers/campaignController.dart';
import 'package:shimmers/screens/campaigns/campaignsListWidget.dart';

import '../../constant/app_constants.dart';
import '../../constant/colorsConstant.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../noDataFound/noDataFoundScreen.dart';

class CampaignsListScreen extends StatefulWidget {
  static const String name = 'campaignsListScreen';
  final String? empId;

  const CampaignsListScreen({Key? key, this.empId}) : super(key: key);

  @override
  State<CampaignsListScreen> createState() => _CampaignsListScreenState();
}

class _CampaignsListScreenState extends State<CampaignsListScreen> {
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

    String userId = Get.find<AuthController>().getUserId();

    if (widget.empId == "") {
      Get.find<CampaignController>().getEmployeeCampaignList(userId);
    } else {
      Get.find<CampaignController>().getEmployeeCampaignList(widget.empId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<CampaignController>(builder: (campaignController) {
            return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
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
              body: campaignController.isLoading &&
                      campaignController.campaignListModel == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : campaignController.campaignListModel!.data == null
                      ? Center(
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: const NoDataFoundScreen()))
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: campaignController
                              .campaignListModel!.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CampaignsListWidget(
                              model: campaignController
                                  .campaignListModel!.data![index],
                            );
                          },
                        ),
            );
          });
  }
}
