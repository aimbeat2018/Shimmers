import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmers/constant/app_constants.dart';
import 'package:shimmers/constant/custom_snackbar.dart';
import 'package:shimmers/constant/no_internet_screen.dart';
import 'package:shimmers/screens/salons/salonDetails/viewOrderedProductDetails.dart';

import '../../../constant/colorsConstant.dart';
import '../../../constant/internetConnectivity.dart';
import '../../../constant/textConstant.dart';
import '../../../controllers/salonController.dart';
import '../../noDataFound/noDataFoundScreen.dart';

class ManagerOrderApproval extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ManagerOrderApproval();
  }
}

class _ManagerOrderApproval extends State<ManagerOrderApproval> {
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
      Get.find<SalonController>().getapprovalorderList();
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
                  : salonController.orderApprovalModel!.orderApproveDetail ==
                              null ||
                          salonController
                              .orderApprovalModel!.orderApproveDetail!.isEmpty
                      ? Center(
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: const NoDataFoundScreen()))
                      : Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: ListView.builder(
                            shrinkWrap: true,
                              itemCount: salonController.orderApprovalModel!.orderApproveDetail!.length,
                              itemBuilder:
                                  (BuildContext context, int index) {
                              return Container(
                                color: kBackgroundColor,
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                margin: EdgeInsets.symmetric(vertical:10 ),
                                child: Padding(padding: EdgeInsets.symmetric(horizontal: 18,vertical: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Salon Name: ${salonController.orderApprovalModel!.orderApproveDetail![index].salonName!}',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(
                                        'Executive Name: ${salonController.orderApprovalModel!.orderApproveDetail![index].executiveName}',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(
                                        'Number of Products: ${salonController.orderApprovalModel!.orderApproveDetail![index].noOfProducts}',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(
                                        'Total Amount: Rs.${salonController.orderApprovalModel!.orderApproveDetail![index].total}',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: 10,),
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
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewOrderedProductDetails(order_id: salonController.orderApprovalModel!.orderApproveDetail![index].id.toString())));
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
                                                showApproveDialog(context,salonController,salonController.orderApprovalModel!.orderApproveDetail![index].id.toString());
                                               // updateOrderApprovalStatus(salonController,salonController.orderApprovalModel!.orderApproveDetail![index].id);
                                              },
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    5.0),
                                                child: Text(
                                                  'Approve',
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

                              );


                                  }),
                        ),
            );
          });
  }
  showApproveDialog(BuildContext parentContext,SalonController salonController,String order_id) {
    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Order Approval'),
          content: Text('Are you sure you want to approve this Order?'),
          actions: [
            TextButton(
              child: Text(TextConstant.cancel),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(TextConstant.yes),
              onPressed: () {
                Navigator.pop(context);
                updateOrderApprovalStatus(salonController,order_id);
              },
            )
          ],
        );
      },
    );
  }

  void updateOrderApprovalStatus(SalonController salonController, String? id) {
    salonController.updateOrderApproval(order_id: id,status: '1').then((message){
      if(message=='Order approval status changed successfully.')
        {
         showCustomSnackBar(message!,isError: false);
         Get.find<SalonController>().getapprovalorderList();
        }
      else{
        showCustomSnackBar(message!,isError: false);
      }
    });
  }
}
