import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/textConstant.dart';

class HomeScreen extends StatefulWidget {
  static const String name = 'home';

  HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  String username = "User ABC";

  @override
  void initState() {
    super.initState();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          tooltip: 'Menu',
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Text(
          'Hello! ' + username + '',
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            tooltip: 'Notifications',
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Center(
                            child: SizedBox(
                              height: 135,
                              width: 115,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Image.asset(
                                  'assets/images/hair-salon.png',
                                  width: 35,
                                  height: 35,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    TextConstant.Salon,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                        color: primaryColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),

                              ],
                            ),
                          ),),
                           VerticalDividerFadeUp(),
                          Center(
                            child: SizedBox(
                              height: 135,
                              width: 115,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Image.asset(
                                  'assets/images/distribution.png',
                                  width: 35,
                                  height: 35,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    TextConstant.Distributor,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                        color: primaryColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ),

                         VerticalDividerFadeUp(

                          ),
                          Center(
                            child: SizedBox(
                              height: 135,
                              width: 115,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Image.asset(
                                  'assets/images/digital-campaign.png',
                                  width: 35,
                                  height: 35,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    TextConstant.Campaigns,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                        color: primaryColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ),
                      ]),
                    ),
                    Divider(),
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Center(
                            child: SizedBox(
                              height: 135,
                              width: 115,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Image.asset(
                                  'assets/images/machine-learning.png',
                                  width: 35,
                                  height: 35,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    TextConstant.Learn,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                        color: primaryColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),),
                          VerticalDivider(),
                          Center(
                            child: SizedBox(
                              height: 135,
                              width: 115,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Image.asset(
                                  'assets/images/mobile.png',
                                  width: 35,
                                  height: 35,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    TextConstant.Activity,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                        color: primaryColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ),
                          VerticalDivider(),
                          Center(
                            child: SizedBox(
                              height: 135,
                              width: 115,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Image.asset(
                                  'assets/images/student-grades.png',
                                  width: 35,
                                  height: 35,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    TextConstant.ScoreCardAnalytics,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                        color:primaryColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ),
                      ]),
                    ),
                    Divider(),
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Center(
                            child: SizedBox(
                              height: 135,
                              width: 115,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Image.asset(
                                  'assets/images/partners.png',
                                  width: 35,
                                  height: 35,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    TextConstant.Team,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                        color: primaryColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,),
                                  ),
                                ),
                              ],
                            ),
                          ),),
                          VerticalDivider(),
                          Center(
                            child: SizedBox(
                              height: 135,
                              width: 115,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Image.asset(
                                  'assets/images/report.png',
                                  width: 35,
                                  height: 35,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                      TextConstant.ReportTourVisit,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                        color: primaryColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),),
                          VerticalDivider(),
                          Center(
                            child: SizedBox(
                              height: 135,
                              width: 115,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Image.asset(
                                  'assets/images/work.png',
                                  width: 35,
                                  height: 35,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                      TextConstant.Scheme,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                        color: primaryColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ),
                      ]),
                    ),
                    Divider(),
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Center(
                            child: SizedBox(
                              height: 135,
                              width: 115,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Image.asset(
                                  'assets/images/target-audience.png',
                                  width: 35,
                                  height: 35,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    TextConstant.SetTarget,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                        color: primaryColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                            ),
                          VerticalDividerFadeDown(),
                          Center(
                            child: SizedBox(
                              height: 135,
                              width: 115,
                              child: Column(
                                children: [

                                SizedBox(
                                height: 20,
                              ),
                                  Image.asset(
                                    'assets/images/list.png',
                                    width: 35,
                                    height: 35,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      TextConstant.NCE,
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      style: const TextStyle(
                                          color: primaryColor,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                          ),
                          ),
                          VerticalDividerFadeDown(),
                          Center(
                            child: SizedBox(
                              height: 135,
                              width: 115,
                            ),),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),

      ),

      bottomNavigationBar:BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        selectedLabelStyle: TextStyle(
          color: Colors.white
        ),
        unselectedLabelStyle:TextStyle(
          color: Colors.black
        ) ,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
              icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
              label: 'My Schedule',
              icon: Icon(Icons.date_range)
          ),
          BottomNavigationBarItem(
              label: 'Attendance',
              icon: Icon(Icons.lock_clock)
          ),
          BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(Icons.person)
          )

        ],),

    );

  }


  Widget VerticalDividerFadeUp (){
    return Container(
      // height: 20,
      width: 1,
      decoration: BoxDecoration(
        // border: Border(
        //   top: BorderSide(
        //     color: Colors.grey,
        //     width: 1.0,
        //   ),
        // ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white60,
            Colors.grey,
            Colors.grey,
            Colors.grey,
          ],
        ),
      ),
    );
  }
  Widget VerticalDividerFadeDown (){
    return Container(
      // height: 20,
      width: 1,
      decoration: BoxDecoration(
        // border: Border(
        //   top: BorderSide(
        //     color: Colors.grey,
        //     width: 1.0,
        //   ),
        // ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.grey,
            Colors.grey,
            Colors.grey,
            Colors.white,
          ],
        ),
      ),
    );
  }
  Widget VerticalDivider (){
    return Container(
      // height: 20,
      width: 1,
      decoration: BoxDecoration(
        // border: Border(
        //   top: BorderSide(
        //     color: Colors.grey,
        //     width: 1.0,
        //   ),
        // ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.grey,
            Colors.grey,
          ],
        ),
      ),
    );
  }
  Widget Divider(){
    return Container(
      height: 1,
      // width: 1,
      decoration: BoxDecoration(
        // border: Border(
        //   top: BorderSide(
        //     color: Colors.grey,
        //     width: 1.0,
        //   ),
        // ),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.white,
            Colors.grey,
            Colors.grey,
            Colors.grey,
            Colors.white,
          ],
        ),
      ),
    );
  }
}
