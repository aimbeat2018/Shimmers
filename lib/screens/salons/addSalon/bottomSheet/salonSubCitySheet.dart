import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmers/constant/no_internet_screen.dart';
import 'package:shimmers/model/employeeRouteListModel.dart';

import '../../../../constant/app_constants.dart';
import '../../../../constant/colorsConstant.dart';
import '../../../../constant/custom_snackbar.dart';
import '../../../../constant/globalFunction.dart';
import '../../../../constant/internetConnectivity.dart';
import '../../../../constant/textConstant.dart';
import '../../../../controllers/salonController.dart';

class SalonSubCitySheet extends StatefulWidget {
  //Salon Sub City selection screen
  @override
  State<StatefulWidget> createState() {
    return _SalonSubCitySheet();
  }

}

class _SalonSubCitySheet extends State<SalonSubCitySheet> {
  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  EmployeeRouteListModel? employeeRouteListModel;
  List<EmpRouteModel>? empRouteList;
  TextEditingController subCityController = TextEditingController();
  bool isDetailsVisible = false;


  @override
  void initState() {
    super.initState();
    CheckInternet.initConnectivity().then((value) =>
        setState(() {
          _connectionStatus = value;
        }));
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
          CheckInternet.updateConnectionStatus(result).then((value) =>
              setState(() {
                _connectionStatus = value;
              }));
        });
    //Get.find<SalonController>().getEmpRouteList();
  }

  @override
  Widget build(BuildContext context) {
    var focusNode = FocusNode();

    return _connectionStatus == AppConstants.connectivityCheck
        ? NoInternetScreen()
        : GetBuilder<SalonController>(builder: (salonControlller){
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          // Navigator.of(context).pop();
                          Navigator.pop(context, EmpRouteModel());
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.grey.shade900,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'City Name',
                        style: const TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: subCityController,
                      focusNode: focusNode,
                      decoration:
                      GlobalFunctions.getInputDecoration('Search City Name'),
                      style: TextStyle(fontSize: 14),
                      keyboardType: TextInputType.text,
                      onChanged: onSearchTextChanged,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: isDetailsVisible ? true : false,
                      child: empRouteList == null || empRouteList!.isEmpty
                          ? Center(child: SizedBox())
                          : Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child:ListView.separated(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                          salonControlller.employeeRouteListModel!.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 10),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 1.0, vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pop(
                                              context,
                                              salonControlller
                                                  .employeeRouteListModel!
                                                  .data![index]);
                                          isDetailsVisible=false;
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              salonControlller
                                                  .employeeRouteListModel!
                                                  .data![index]
                                                  .name!,
                                              style: const TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );

    });
  }
  onSearchTextChanged(String text) async {
    if (text.isNotEmpty && text.length > 3) {
      Future.delayed(Duration.zero, () async {
        employeeRouteListModel =
        await Get.find<SalonController>().getEmpRouteList(key: text);
        empRouteList = employeeRouteListModel!.data!;
        if (empRouteList!.isNotEmpty) {
          isDetailsVisible = true;
        }
        else{
          showCustomSnackBar('City not found in list!',isError: false);
        }
      });
      setState(() {});
      return;
    } else {
      isDetailsVisible = false;

     setState(() {

     });
    }
  }


}