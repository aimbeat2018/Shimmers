import 'package:flutter/material.dart';
import 'package:moony_nav_bar/moony_nav_bar.dart';
import 'package:shimmers/constant/colorsConstant.dart';

import 'homeScreen.dart';


void main() {
  runApp(MainScreen());
}
class MainScreen extends StatefulWidget {
  static const routeName = '/mainScreen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _screen1 = HomeScreen();
  Widget _screen2 = HomeScreen();
  Widget _screen3 = HomeScreen();
  Widget _screen4 = HomeScreen();
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Moony navigation bar'),
        // ),
        body: getBody(),
        bottomNavigationBar: MoonyNavigationBar(
          items: <NavigationBarItem>[
            NavigationBarItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                color: Colors.white,
                indicatorColor: Colors.white,
                onTap: () {
                  onTapHandler(0);
                }),
            NavigationBarItem(
                icon: Icons.calendar_month_outlined,
                activeIcon: Icons.calendar_month,
                color: Colors.white,
                indicatorColor: Colors.white,
                onTap: () {
                  onTapHandler(1);
                }),
            NavigationBarItem(
                icon: Icons.school_outlined,
                activeIcon: Icons.school,
                color: Colors.white,
                indicatorColor: Colors.white,
                onTap: () {
                  onTapHandler(2);
                }),
            NavigationBarItem(
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                color: Colors.white,
                indicatorColor: Colors.white,
                onTap: () {
                  onTapHandler(3);
                })
          ],
          style: MoonyNavStyle(
            activeColor: Colors.white,
            indicatorPosition: IndicatorPosition.TOP,
            indicatorType: IndicatorType.LINE,
            indicatorColor: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
        ),
      ),
    );
  }

  Widget getBody() {
    if (this.selectedIndex == 0) {
      return this._screen1;
    } else if (this.selectedIndex == 1) {
      return this._screen2;
    } else if (this.selectedIndex == 2) {
      return this._screen3;
    }else {
      return this._screen4;
    }
  }

  void onTapHandler(int index) {
    this.setState(() {
      this.selectedIndex = index;
    });
  }
}