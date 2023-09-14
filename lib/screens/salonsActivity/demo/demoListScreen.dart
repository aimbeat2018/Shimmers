import 'package:flutter/material.dart';

import '../../../constant/colorsConstant.dart';
import '../../../constant/textConstant.dart';
import '../../../model/salonDetailsModel.dart';

class DemoListScreen extends StatefulWidget {
  final SalonDetailsModel model;

  const DemoListScreen({Key? key, required this.model}) : super(key: key);

  @override
  State<DemoListScreen> createState() => _DemoListScreenState();
}

class _DemoListScreenState extends State<DemoListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          TextConstant.demonstrate,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
