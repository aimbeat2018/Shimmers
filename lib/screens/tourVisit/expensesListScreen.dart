import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmers/constant/app_constants.dart';
import 'package:shimmers/constant/no_internet_screen.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/internetConnectivity.dart';
import '../../controllers/tourController.dart';

class ExpensesListScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ExpensesListScreen();
  }

}
class _ExpensesListScreen extends State<ExpensesListScreen>{
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
    return _connectionStatus==AppConstants.connectivityCheck ? NoInternetScreen():
    GetBuilder<TourController>(builder: (tourController)
    {
      return Scaffold(
        appBar: AppBar(
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

      );
    });
  }


}