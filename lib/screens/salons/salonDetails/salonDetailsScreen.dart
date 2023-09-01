import 'package:flutter/material.dart';

import '../../../constant/colorsConstant.dart';
import '../../../constant/textConstant.dart';

class SalonDetailsScreen extends StatefulWidget {
  static const String name = 'salonDetailsScreen';

  const SalonDetailsScreen({Key? key}) : super(key: key);

  @override
  State<SalonDetailsScreen> createState() => _SalonDetailsScreenState();
}

class _SalonDetailsScreenState extends State<SalonDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              height: 200,
              child: Stack(
                children: [
                  Image.network(
                    'https://cloudfront-us-east-1.images.arcpublishing.com/gmg/N5QM44RYCBFOLP6BIPM2YY3XYI.jpg',
                    height: 200,
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.2,
                      child: Container(
                        color: const Color(0xFF000000),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
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
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Sec - 10, Vashi, Navi Mumbai',
                                style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                '5 Km Away',
                                style: const TextStyle(
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
            Stack(
              children: [
                Container(
                  color: primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
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
                              SizedBox(
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
                          Column(
                            children: [
                              Image.asset(
                                'assets/images/take_order.png',
                                height: 28,
                                width: 28,
                              ),
                              SizedBox(
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
                          Column(
                            children: [
                              Image.asset(
                                'assets/images/take_feedback.png',
                                height: 28,
                                width: 28,
                              ),
                              SizedBox(
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
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                'assets/images/collect_payment.png',
                                height: 28,
                                width: 28,
                              ),
                              SizedBox(
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
                          Column(
                            children: [
                              Image.asset(
                                'assets/images/take_note.png',
                                height: 28,
                                width: 28,
                              ),
                              SizedBox(
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
                          Column(
                            children: [
                              Image.asset(
                                'assets/images/report_campaign.png',
                                height: 28,
                                width: 28,
                              ),
                              SizedBox(
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
                          )
                        ],
                      ),
                      SizedBox(
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
                              SizedBox(
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
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
