import 'package:flutter/material.dart';
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

    return Scaffold(

      body: getBody(),
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