import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant/internetConnectivity.dart';

class EmployeeCampaignDetails extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _EmployeeCampaignDetails();
  }

}
class _EmployeeCampaignDetails extends State{
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

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }


}