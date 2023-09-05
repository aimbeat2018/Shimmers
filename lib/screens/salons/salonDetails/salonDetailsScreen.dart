import 'package:flutter/material.dart';
import 'package:shimmers/screens/salonsActivity/collectPaymentScreen.dart';
import 'package:shimmers/screens/salonsActivity/salonCampaignListScreen.dart';
import 'package:shimmers/screens/salonsActivity/takeNoteScreen.dart';
import 'package:shimmers/screens/salonsActivity/takeOrder/productListScreen.dart';

import '../../../constant/colorsConstant.dart';
import '../../../constant/textConstant.dart';
import '../../salonsActivity/addFeedbackScreen.dart';

class SalonDetailsScreen extends StatefulWidget {
  static const String name = 'salonDetailsScreen';

  const SalonDetailsScreen({Key? key}) : super(key: key);

  @override
  State<SalonDetailsScreen> createState() => _SalonDetailsScreenState();
}

class _SalonDetailsScreenState extends State<SalonDetailsScreen> {
  bool isDetailsVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          TextConstant.Salon,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.28,
              color: isDetailsVisible ? primaryColor : Colors.transparent,
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Stack(
                      children: [
                        Image.network(
                          'https://cloudfront-us-east-1.images.arcpublishing.com/gmg/N5QM44RYCBFOLP6BIPM2YY3XYI.jpg',
                          height: MediaQuery.of(context).size.height * 0.25,
                          fit: BoxFit.fitWidth,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Positioned.fill(
                          child: Opacity(
                            opacity: 0.3,
                            child: Container(
                              color: const Color(0xFF000000),
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                    child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Abc Salon',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      'Sec - 10, Vashi, Navi Mumbai',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      '5 Km Away',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                )),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Icon(
                                      Icons.call,
                                      color: Colors.white,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: isDetailsVisible ? false : true,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: () {
                          setState(() {
                            isDetailsVisible = !isDetailsVisible;
                          });
                        },
                        child: Icon(
                          Icons.arrow_downward,
                          color: primaryColor,
                          size: 25,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Visibility(
              visible: isDetailsVisible ? true : false,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.37,
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.34,
                      color: primaryColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/images/take_stock.png',
                                    height: 28,
                                    width: 28,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    TextConstant.updateStock,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductListScreen())),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/take_order.png',
                                      height: 28,
                                      width: 28,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      TextConstant.takeOrder,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddFeedBackScreen())),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/take_feedback.png',
                                      height: 28,
                                      width: 28,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      TextConstant.takeFeedback,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CollectPaymentScreen())),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/collect_payment.png',
                                      height: 28,
                                      width: 28,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      TextConstant.collectPayment,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) => TakeNoteScreen(),
                                    backgroundColor: Colors.transparent,
                                  ).then((value) => {
                                        // setState(() {
                                        //   selectedLeaveType = value!;
                                        // })
                                      });
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/take_note.png',
                                      height: 28,
                                      width: 28,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      TextConstant.takeNote,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SalonCampaignListScreen())),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/report_campaign.png',
                                      height: 28,
                                      width: 28,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      TextConstant.reportCampaign,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/images/demonstrate.png',
                                    height: 28,
                                    width: 28,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    TextConstant.demonstrate,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: () {
                          setState(() {
                            isDetailsVisible = !isDetailsVisible;
                          });
                        },
                        child: Icon(
                          Icons.arrow_upward,
                          color: primaryColor,
                          size: 25,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 10.0, left: 10.0, bottom: 30, top: 15),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Image.asset(
                          'assets/images/schedule_salon.png',
                          height: 25,
                          width: 25,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            TextConstant.scheduleVisitsAndCalls,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            TextConstant.scheduleVisitsAndCallsMsg,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 10.0, left: 10.0, bottom: 15),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 10.0, left: 10.0, bottom: 30, top: 15),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Image.asset(
                          'assets/images/recent_note.png',
                          height: 25,
                          width: 25,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            TextConstant.recentNotes,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            TextConstant.recentNotesMsg,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 10.0, left: 10.0, bottom: 15),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 10.0, left: 10.0, bottom: 30, top: 15),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Image.asset(
                          'assets/images/stage.png',
                          height: 25,
                          width: 25,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                TextConstant.stage,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.edit,
                                color: primaryColor,
                                size: 16,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            TextConstant.stage,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 10.0, left: 10.0, bottom: 15),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 10.0, left: 10.0, bottom: 30, top: 15),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Image.asset(
                          'assets/images/outstanding_payment.png',
                          height: 25,
                          width: 25,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            TextConstant.outstandingPayment,
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '₹ 0.00',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 10.0, left: 10.0, bottom: 30),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 10.0, left: 10.0, bottom: 30, top: 15),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Image.asset(
                          'assets/images/available_credit.png',
                          height: 25,
                          width: 25,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            TextConstant.availableCredit,
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '₹ 0.00',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
