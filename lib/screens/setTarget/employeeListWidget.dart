import 'package:flutter/material.dart';
import 'package:shimmers/screens/setTarget/setProductTargetScreen.dart';

import '../../constant/colorsConstant.dart';
import '../../model/employeeListModel.dart';

class EmployeeListWidget extends StatefulWidget {
  final Members membersModel;

  const EmployeeListWidget({Key? key, required this.membersModel})
      : super(key: key);

  @override
  State<EmployeeListWidget> createState() => _EmployeeListWidgetState();
}

class _EmployeeListWidgetState extends State<EmployeeListWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SetProductTargetScreen(
                  membersModel: widget.membersModel,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Row(
          children: [
            widget.membersModel.imageUrl == ""
                ? Image.asset(
                    'assets/images/avatar.png',
                    height: 50,
                    width: 50,
                  )
                : Image.network(
                    widget.membersModel.imageUrl!,
                    height: 50,
                    width: 50,
                  ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.membersModel.name!,
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.membersModel.role!,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
