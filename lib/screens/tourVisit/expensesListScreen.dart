import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shimmers/constant/app_constants.dart';
import 'package:shimmers/constant/custom_snackbar.dart';
import 'package:shimmers/constant/no_internet_screen.dart';
import 'package:shimmers/screens/tourVisit/addExpensesScreen.dart';
import 'package:shimmers/screens/tourVisit/ticketPdfScreen.dart';
import 'package:shimmers/screens/tourVisit/tourImageScreen.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/route_helper.dart';
import '../../controllers/tourController.dart';
import '../noDataFound/noDataFoundScreen.dart';
import 'package:path/path.dart' as p;

class ExpensesListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExpensesListScreen();
  }
}

class _ExpensesListScreen extends State<ExpensesListScreen> {
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
      Get.find<TourController>().getExpensesList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? NoInternetScreen()
        : GetBuilder<TourController>(builder: (tourController) {
            return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
                backgroundColor: primaryColor,
                centerTitle: true,
                title: Text(
                  'Expenses List',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: tourController.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : tourController.totalExpensesModel!.data == null ||
                          tourController.totalExpensesModel!.data!.isEmpty
                      ? Center(
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: const NoDataFoundScreen()))
                      : Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: tourController
                                  .totalExpensesModel!.data!.length,
                              // physics: const NeverScrollableScrollPhysics(),
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 18, vertical: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Date: ${tourController.totalExpensesModel!.data![index].date!}',
                                                  style: TextStyle(
                                                      color: primaryColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    PersistentNavBarNavigator
                                                        .pushNewScreen(
                                                      context,
                                                      screen: AddExpensesScreen(
                                                          expenses_id:
                                                              tourController
                                                                  .totalExpensesModel!
                                                                  .data![index]
                                                                  .id!
                                                                  .toString()),
                                                      withNavBar: false,
                                                    ).then((value) {
                                                      setState(() {
                                                        Get.find<
                                                                TourController>()
                                                            .getExpensesList();
                                                      });
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: primaryColor,
                                                  )),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  deleteExpensesEntry(
                                                      tourController
                                                          .totalExpensesModel!
                                                          .data![index]
                                                          .id
                                                          .toString(),
                                                      tourController,
                                                      index);
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color: primaryColor,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
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
                                                  'Area Covered: ${tourController.totalExpensesModel!.data![index].areaCovered}',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              tourController
                                                              .totalExpensesModel!
                                                              .data![index]
                                                              .attachment ==
                                                          null ||
                                                      tourController
                                                              .totalExpensesModel!
                                                              .data![index]
                                                              .attachment ==
                                                          ''
                                                  ? SizedBox()
                                                  : InkWell(
                                                      onTap: () {
                                                        final extension = p
                                                            .extension(tourController
                                                                .totalExpensesModel!
                                                                .data![index]
                                                                .attachment!);
                                                        if (extension ==
                                                            '.pdf') {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => TicketPdfScreen(
                                                                      fileUrl: tourController
                                                                          .totalExpensesModel!
                                                                          .data![
                                                                              index]
                                                                          .attachment!,from: 'expenses',)));
                                                        } else {
                                                          //  showCustomSnackBar('File is Image',isError: false);
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          TourImageScreen(
                                                                            image_url:
                                                                                tourController.totalExpensesModel!.data![index].attachment!,
                                                                            extension:
                                                                                extension,from: 'expenses',
                                                                          )));
                                                        }
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5.0),
                                                        child: Text(
                                                          'View Attachment',
                                                          // 'Remark: ${widget.model.remark ??'vff':widget.model.remark}',
                                                          style: TextStyle(
                                                              color:
                                                                  primaryColor,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              'Approx Km: ${tourController.totalExpensesModel!.data![index].kilometer}',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              tourController
                                                              .totalExpensesModel!
                                                              .data![index]
                                                              .da ==
                                                          null ||
                                                      tourController
                                                              .totalExpensesModel!
                                                              .data![index]
                                                              .da ==
                                                          ''
                                                  ? 'DA: Rs.0'
                                                  : 'DA: Rs.${tourController.totalExpensesModel!.data![index].da}',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              tourController
                                                              .totalExpensesModel!
                                                              .data![index]
                                                              .ta ==
                                                          null ||
                                                      tourController
                                                              .totalExpensesModel!
                                                              .data![index]
                                                              .ta ==
                                                          ''
                                                  ? 'TA: Rs.0'
                                                  : 'TA: Rs.${tourController.totalExpensesModel!.data![index].ta}',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              tourController
                                                              .totalExpensesModel!
                                                              .data![index]
                                                              .hotel ==
                                                          null ||
                                                      tourController
                                                              .totalExpensesModel!
                                                              .data![index]
                                                              .hotel ==
                                                          ''
                                                  ? 'Hotel / Restaurant: Rs.0'
                                                  : 'Hotel / Restaurant: Rs.${tourController.totalExpensesModel!.data![index].hotel}',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              tourController
                                                              .totalExpensesModel!
                                                              .data![index]
                                                              .miscOther ==
                                                          null ||
                                                      tourController
                                                              .totalExpensesModel!
                                                              .data![index]
                                                              .miscOther ==
                                                          ''
                                                  ? 'Miscellaneous Amount: Rs.0'
                                                  : 'Miscellaneous Amount: Rs.${tourController.totalExpensesModel!.data![index].miscOther}',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              'Total: Rs.${tourController.totalExpensesModel!.data![index].total}',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(
                                            height: 5,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endDocked,
              floatingActionButton: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: FloatingActionButton(
                  // isExtended: true,
                  child: Icon(Icons.add),
                  backgroundColor: primaryColor,
                  onPressed: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: AddExpensesScreen(expenses_id: '0'),
                      withNavBar: false,
                    ).then((value) {
                      setState(() {
                        Get.find<TourController>().getExpensesList();
                      });
                    });
                  },
                ),
              ),
            );
          });
  }

  void deleteExpensesEntry(
      String expense_id, TourController tourController, int index) {
    Get.find<TourController>()
        .deleteExpenses(expenses_id: expense_id)
        .then((message) {
      if (message == 'Executive Expenses deleted successfully') {
        showCustomSnackBar(message!, isError: false);
        setState(() {
          tourController.totalExpensesModel!.data!.removeAt(index);
        });
      } else {
        showCustomSnackBar(message!, isError: false);
      }
    });
  }
}
