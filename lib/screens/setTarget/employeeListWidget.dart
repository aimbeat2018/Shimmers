import 'package:flutter/material.dart';

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
    return const Placeholder();
  }
}
