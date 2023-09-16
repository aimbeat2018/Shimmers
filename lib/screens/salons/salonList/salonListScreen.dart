import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shimmers/screens/salons/salonList/existingSalonsScreen.dart';
import 'package:shimmers/screens/salons/salonList/newSalonsScreen.dart';

import '../../../constant/app_constants.dart';
import '../../../constant/colorsConstant.dart';
import '../../../constant/internetConnectivity.dart';
import '../../../constant/no_internet_screen.dart';
import '../../../constant/textConstant.dart';

class SalonListScreen extends StatefulWidget {
  static const String name = 'salonListScreen';

  const SalonListScreen({Key? key}) : super(key: key);

  @override
  State<SalonListScreen> createState() => _SalonListScreenState();
}

class _SalonListScreenState extends State<SalonListScreen> {
  int selectedTab = 1;
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
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                centerTitle: true,
                title: Text(
                  TextConstant.Salon,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                // actions: [
                //   Padding(
                //     padding: const EdgeInsets.only(right: 10.0),
                //     child: Image.asset(
                //       'assets/images/sort.png',
                //       height: 20,
                //       width: 20,
                //     ),
                //   ),
                //   Padding(
                //     padding: const EdgeInsets.only(right: 10.0),
                //     child: Image.asset(
                //       'assets/images/filter.png',
                //       height: 25,
                //       width: 25,
                //     ),
                //   ),
                // ],
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(
                      text: TextConstant.newStr,
                    ),
                    Tab(
                      text: TextConstant.existing,
                    ),
                    // Tab(
                    //   text: TextConstant.notAssigned,
                    // )
                  ],
                ),
              ),
              body: const TabBarView(
                children: [
                  NewSalonsScreen(),
                  ExistingSalonsScreen(),
                  // NotAssignedSalonsScreen()
                ],
              ),
            ),
          );
  }
}
