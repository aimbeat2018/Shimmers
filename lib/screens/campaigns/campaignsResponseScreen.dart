import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/app_constants.dart';
import '../../constant/colorsConstant.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../constant/textConstant.dart';
import '../../controllers/campaignController.dart';
import '../../model/campaignListModel.dart';
import '../noDataFound/noDataFoundScreen.dart';
import 'campaignResponseListWidget.dart';

class CampaignsResponseScreen extends StatefulWidget {
  static const String name = 'campaignsResponseScreen';
  final CampaignListData model;

  const CampaignsResponseScreen({Key? key, required this.model})
      : super(key: key);

  @override
  State<CampaignsResponseScreen> createState() =>
      _CampaignsResponseScreenState();
}

class _CampaignsResponseScreenState extends State<CampaignsResponseScreen> {
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

    Get.find<CampaignController>()
        .getEmployeeCampaignResponse(widget.model.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<CampaignController>(builder: (campaignController) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                centerTitle: true,
                title: Text(
                  TextConstant.campaignsReport,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 20),
                        width: MediaQuery.of(context).size.width,
                        color: primaryColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.model.name!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            // SizedBox(
                            //   height: 8,
                            // ),
                            // Text(
                            //   'Please note - This is to filled by the trainers whenever they do any market visit.',
                            //   style: TextStyle(
                            //       color: Colors.white,
                            //       fontSize: 13,
                            //       fontWeight: FontWeight.normal),
                            // ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Status : ${widget.model.status}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Date : ${widget.model.startDate}  - ${widget.model.endDate}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      //   child: Text(
                      //     TextConstant.teamRole,
                      //     style: TextStyle(
                      //         color: Colors.black,
                      //         fontSize: 15,
                      //         fontWeight: FontWeight.normal),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 8,
                      // ),
                      // Container(
                      //   padding:
                      //       const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                      //   width: MediaQuery.of(context).size.width,
                      //   color: kBackgroundColor,
                      //   child: Row(
                      //     children: [
                      //       Center(
                      //         child: SizedBox(
                      //           height: 60,
                      //           width: 60,
                      //           child: CircleAvatar(
                      //             backgroundColor: Colors.transparent,
                      //             foregroundImage: AssetImage(
                      //               'assets/images/distribution.png',
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         width: 20,
                      //       ),
                      //       Expanded(
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text(
                      //               'ABC Technology',
                      //               style: TextStyle(
                      //                   color: primaryColor,
                      //                   fontSize: 14,
                      //                   fontWeight: FontWeight.bold),
                      //             ),
                      //             SizedBox(
                      //               height: 5,
                      //             ),
                      //             Text(
                      //               'Role',
                      //               style: TextStyle(
                      //                   color: Colors.black,
                      //                   fontSize: 10,
                      //                   fontWeight: FontWeight.normal),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          TextConstant.response,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      campaignController.isLoading &&
                              campaignController.campaignResponseModel == null
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : campaignController
                                  .campaignResponseModel!.data!.isEmpty
                              ? Center(
                                  child: NoDataFoundScreen(),
                                )
                              : Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 20),
                                  width: MediaQuery.of(context).size.width,
                                  color: primaryColor,
                                  child: ListView.separated(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: campaignController
                                        .campaignResponseModel!.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CampaignResponseListWidget(
                                        index: index,
                                        model: campaignController
                                            .campaignResponseModel!
                                            .data![index],
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                        color: Colors.white.withOpacity(0.5),
                                      );
                                    },
                                  ),
                                ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
  }
}
