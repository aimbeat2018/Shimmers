import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmers/screens/noDataFound/noDataFoundScreen.dart';
import 'package:shimmers/screens/salonsActivity/campaignsSalonListWidget.dart';

import '../../constant/app_constants.dart';
import '../../constant/colorsConstant.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../constant/textConstant.dart';
import '../../controllers/salonController.dart';

class SalonCampaignListScreen extends StatefulWidget {
  static const String name = 'SalonCampaignListScreen';
  final int salonId;

  const SalonCampaignListScreen({Key? key, required this.salonId})
      : super(key: key);

  @override
  State<SalonCampaignListScreen> createState() =>
      _SalonCampaignListScreenState();
}

class _SalonCampaignListScreenState extends State<SalonCampaignListScreen> {
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
      Get.find<SalonController>().getCampaignList();
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
                      horizontal: 10.0, vertical: 25),
                  child: Column(
                    children: [
                      // TextFormField(
                      //   style: const TextStyle(fontSize: 14),
                      //   decoration: const InputDecoration(
                      //       enabledBorder: OutlineInputBorder(
                      //         borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      //         borderSide: BorderSide(color: primaryColor, width: 1),
                      //       ),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      //         borderSide: BorderSide(color: primaryColor, width: 1),
                      //       ),
                      //       contentPadding:
                      //           EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      //       hintText: 'Search',
                      //       suffixIcon: Icon(
                      //         CupertinoIcons.search,
                      //         size: 28,
                      //       )),
                      //   keyboardType: TextInputType.text,
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      salonController.isLoading &&
                              salonController.campaignListModel == null
                          ? salonController.campaignListModel!.data!.isEmpty
                              ? Center(
                                  child: NoDataFoundScreen(),
                                )
                              : const Center(
                                  child: CircularProgressIndicator(),
                                )
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: salonController
                                  .campaignListModel!.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return CampaignsSalonListWidget(
                                  model: salonController
                                      .campaignListModel!.data![index],
                                  salonId: widget.salonId,
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ),
            );
          });
  }
}
