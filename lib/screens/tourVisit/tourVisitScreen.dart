import 'package:flutter/material.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/textConstant.dart';

class TourVisitScreen extends StatefulWidget {
  static const String name = 'TourVisitScreen';

  const TourVisitScreen({Key? key}) : super(key: key);

  @override
  State<TourVisitScreen> createState() => _TourVisitScreenState();
}

class _TourVisitScreenState extends State<TourVisitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          TextConstant.tourVisit,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
