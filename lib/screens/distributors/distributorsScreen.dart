import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmers/controllers/distributorController.dart';
import 'package:shimmers/screens/distributors/distributorListWidget.dart';
import 'package:shimmers/screens/noDataFound/noDataFoundScreen.dart';

import '../../constant/app_constants.dart';
import '../../constant/colorsConstant.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../constant/textConstant.dart';

class DistributorsScreen extends StatefulWidget {
  static const String name = 'distributorScreen';

  const DistributorsScreen({Key? key}) : super(key: key);

  @override
  State<DistributorsScreen> createState() => _DistributorsScreenState();
}

class _DistributorsScreenState extends State<DistributorsScreen> {
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

    Get.find<DistributorController>().getDistributorList();
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<DistributorController>(builder: (distributorController) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                centerTitle: true,
                title: Text(
                  TextConstant.Distributor,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: distributorController.isLoading &&
                      distributorController.distributorListModel == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : distributorController.distributorListModel!.data == null
                      ? Center(
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: const NoDataFoundScreen()))
                      : ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: distributorController
                              .distributorListModel!.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return DistributorListWidget(
                              model: distributorController
                                  .distributorListModel!.data![index],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                        ),
            );
          });
  }
}
