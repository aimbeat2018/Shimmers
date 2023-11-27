import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmers/constant/app_constants.dart';
import 'package:shimmers/constant/custom_snackbar.dart';
import 'package:shimmers/constant/no_internet_screen.dart';
import 'package:shimmers/controllers/salonController.dart';
import 'package:shimmers/screens/noDataFound/noDataFoundScreen.dart';

import '../../../constant/colorsConstant.dart';
import '../../../constant/internetConnectivity.dart';

class OrderListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrderListScreen();
  }
}

class _OrderListScreen extends State {
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
      Get.find<SalonController>().getNotDeliveredOrderList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? NoInternetScreen()
        : GetBuilder<SalonController>(builder: (salonController) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                centerTitle: true,
                title: Text(
                  'Non Delivered Order List',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: salonController.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : salonController.deliveredOrderModel!.data == null ||
                          salonController.deliveredOrderModel!.data!.isEmpty
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
                                  .deliveredOrderModel!.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 5),
                                  child: Card(
                                    elevation: 5,
                                    shadowColor: primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18.0, vertical: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Order Id: ${salonController.deliveredOrderModel!.data![index].id!}',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Order Date: ${salonController.deliveredOrderModel!.data![index].orderDate!}',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              'Order Amount: Rs.${salonController.deliveredOrderModel!.data![index].total}',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              'Number of Products: ${salonController.deliveredOrderModel!.data![index].no_of_products}',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                primaryColor),
                                                    foregroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                primaryColor),
                                                    textStyle:
                                                        MaterialStateProperty
                                                            .all<TextStyle>(
                                                      const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                    padding:
                                                        MaterialStateProperty
                                                            .all<EdgeInsets>(
                                                      const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16,
                                                          vertical: 8),
                                                    ),
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Text(
                                                      'View Products',
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  )),
                                              ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                primaryColor),
                                                    foregroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                primaryColor),
                                                    textStyle:
                                                        MaterialStateProperty
                                                            .all<TextStyle>(
                                                      const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                    padding:
                                                        MaterialStateProperty
                                                            .all<EdgeInsets>(
                                                      const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16,
                                                          vertical: 8),
                                                    ),
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    updateOrderStatus(salonController,salonController.deliveredOrderModel!.data![index].id);
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Text(
                                                      'Delivered',
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  )),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
            );
          });
  }

  Future<void> updateOrderStatus(SalonController salonController, int? id) async {
    salonController.updateorderStatus(order_id: id.toString(),status: 'completed').then((message) {
      if(message=='Order status changed successfully.')
        {
          showCustomSnackBar(message!,isError: false);
          Get.find<SalonController>().getNotDeliveredOrderList();
        }
      else{
        Navigator.pop(context);
      }
    });

  }
}
