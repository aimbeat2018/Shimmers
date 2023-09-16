import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shimmers/constant/colorsConstant.dart';
import 'package:shimmers/screens/attendance/attendanceScreen.dart';
import 'package:shimmers/screens/profile/profileScreen.dart';
import 'package:shimmers/screens/schedule/scheduleScreen.dart';

import '../../constant/app_constants.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import 'homeScreen.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/mainScreen';

  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      ScheduleScreen(),
      AttendanceScreen(),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.calendar_today),
        title: ("My Schedule"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.clock_fill),
        title: ("Attendance"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person_alt),
        title: ("Profile"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.black,
      ),
    ];
  }

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

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
        : PersistentTabView(
            context,
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarsItems(),
            confineInSafeArea: true,
            backgroundColor: primaryColor,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: false,
            hideNavigationBarWhenKeyboardShows: false,
            decoration: const NavBarDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0)),
              colorBehindNavBar: Colors.white,
            ),
            itemAnimationProperties: const ItemAnimationProperties(
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: const ScreenTransitionAnimation(
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
            navBarStyle: NavBarStyle.style1,
          );
  }
}
