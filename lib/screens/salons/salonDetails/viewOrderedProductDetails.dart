import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmers/constant/app_constants.dart';
import 'package:shimmers/constant/no_internet_screen.dart';

import '../../../constant/colorsConstant.dart';
import '../../../constant/internetConnectivity.dart';
import '../../../controllers/salonController.dart';
import '../../noDataFound/noDataFoundScreen.dart';

class ViewOrderedProductDetails extends StatefulWidget {
  String order_id;

  ViewOrderedProductDetails({required this.order_id});

  @override
  State<StatefulWidget> createState() {
    return _ViewOrderedProductDetails();
  }
}

class _ViewOrderedProductDetails extends State<ViewOrderedProductDetails> {
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
      Get.find<SalonController>()
          .viewProductsbyOrederId(order_id: widget.order_id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? NoInternetScreen()
        : GetBuilder<SalonController>(builder: (salonController) {
            return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
                backgroundColor: primaryColor,
                centerTitle: true,
                title: Text(
                  'List of Ordered Products',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: salonController.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : salonController.viewProductsModel!.data == null ||
                          salonController.viewProductsModel!.data!.isEmpty
                      ? Center(
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: const NoDataFoundScreen()))
                      : Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: salonController
                                  .viewProductsModel!.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  color: kBackgroundColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 15),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 10),
                                    child: Row(
                                      children: [
                                        salonController
                                                    .viewProductsModel!
                                                    .data![index]
                                                    .default_image !=
                                                ""
                                            ? Image.network(
                                                salonController
                                                    .viewProductsModel!
                                                    .data![index]
                                                    .default_image!,
                                                height: 50,
                                                width: 50,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset(
                                                'assets/images/avatar.png',
                                                height: 50,
                                                width: 50,
                                              ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Item Name: ${salonController.viewProductsModel!.data![index].itemName!}',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Amount: ${salonController.viewProductsModel!.data![index].amount!}',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Amount After Discount: ${salonController.viewProductsModel!.data![index].afterDiscountAmount!}',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
            );
          });
  }
}
