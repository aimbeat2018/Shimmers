import 'package:flutter/material.dart';
import 'package:shimmers/screens/salons/existingSalonsScreen.dart';
import 'package:shimmers/screens/salons/newSalonsScreen.dart';
import 'package:shimmers/screens/salons/notAssignedSalonsScreen.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/textConstant.dart';

class SalonListScreen extends StatefulWidget {
  static const String name = 'salonListScreen';

  const SalonListScreen({Key? key}) : super(key: key);

  @override
  State<SalonListScreen> createState() => _SalonListScreenState();
}

class _SalonListScreenState extends State<SalonListScreen> {
  int selectedTab = 1;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Text(
            TextConstant.Salon,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Image.asset(
                'assets/images/sort.png',
                height: 20,
                width: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Image.asset(
                'assets/images/filter.png',
                height: 25,
                width: 25,
              ),
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                text: TextConstant.newStr,
              ),
              Tab(
                text: TextConstant.existing,
              ),
              Tab(
                text: TextConstant.notAssigned,
              )
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            NewSalonsScreen(),
            ExistingSalonsScreen(),
            NotAssignedSalonsScreen()
          ],
        ),
      ),
    );
  }
}
