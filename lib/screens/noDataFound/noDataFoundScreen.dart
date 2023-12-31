import 'package:flutter/material.dart';

import '../../constant/colorsConstant.dart';

class NoDataFoundScreen extends StatefulWidget {
  const NoDataFoundScreen({Key? key}) : super(key: key);

  @override
  State<NoDataFoundScreen> createState() => _NoDataFoundScreenState();
}

class _NoDataFoundScreenState extends State<NoDataFoundScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/no_data.png",
          height: 100,
          width: 100,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'No Data Found',
          style: TextStyle(
              color: primaryColor, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
