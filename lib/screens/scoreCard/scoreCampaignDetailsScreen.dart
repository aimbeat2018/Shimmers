import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shimmers/controllers/salonController.dart';
import 'package:shimmers/controllers/scoreController.dart';

import '../../constant/internetConnectivity.dart';

class ScoreCampaignDetailsScreen extends StatefulWidget{
  String userId,campaignId,salonId,fromDate,toDate;

  ScoreCampaignDetailsScreen(
      {required this.userId, required this.campaignId, required this.salonId, required this.fromDate, required this.toDate});

  @override
  State<StatefulWidget> createState() {
    return _ScoreCampaignDetailsScreen();
  }

}
class _ScoreCampaignDetailsScreen extends State<ScoreCampaignDetailsScreen>{
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
    if(mounted)
      {
       // Get.find<ScoreController>().userCampaignAnswerList(userid: widget.userId,campaignid: widget.campaignId,fr)
      }

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }


}