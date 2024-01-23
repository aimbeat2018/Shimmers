import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmers/controllers/tourController.dart';
import 'package:shimmers/model/salonVisitModel.dart';
import 'package:shimmers/model/submitTourModel.dart';

import '../../constant/app_constants.dart';
import '../../constant/colorsConstant.dart';
import '../../constant/custom_snackbar.dart';
import '../../constant/globalFunction.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../model/commPhaseModel.dart';
import '../../model/salonDataModel.dart';
import '../noDataFound/noDataFoundScreen.dart';

class VisitDetailsSheet extends StatefulWidget {
  final String salonName,
      salonMob,
      brand,
      comm_phase,
      order_value,
      is_order,
      is_satisfy;

  VisitDetailsSheet(
      {required this.salonName,
      required this.salonMob,
      required this.brand,
      required this.comm_phase,
      required this.order_value,
      required this.is_order,
      required this.is_satisfy});

  /* final List<SalonVisitModel> salonVisitList;

  VisitDetailsSheet({required this.salonVisitList});*/

  @override
  State<StatefulWidget> createState() {
    return _VisitDetailsSheet();
  }
}

class _VisitDetailsSheet extends State<VisitDetailsSheet> {
  TextEditingController salonController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController phaseController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  CommPhaseModel? commPhaseModel;
  List<CommunicationPhase>? commPhaseList;
  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  String? selectedStatus, is_order, is_satisfy;
  SalonDataModel? salonDataModel;
  List<SalonNameModel>? salonNameList;
  bool isDetailsVisible = false;
  var focusNode = FocusNode();

  @override
  void initState() {
    CheckInternet.initConnectivity().then((value) => setState(() {
          _connectionStatus = value;
        }));
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      CheckInternet.updateConnectionStatus(result).then((value) => setState(() {
            _connectionStatus = value;
          }));
    });
    getPhaseList();
    if(widget.salonName!='') {
      salonController.text = widget.salonName;
      contactController.text = widget.salonMob;
      brandController.text = widget.brand;
      selectedStatus = widget.comm_phase;
      is_order=widget.is_order;
      is_satisfy=widget.is_satisfy;
      valueController.text = widget.order_value;
    }

  }

  Future<void> getPhaseList() async {
    commPhaseList = [];
    Future.delayed(Duration.zero, () async {
      commPhaseModel = await Get.find<TourController>().getCommPhaseList();
      commPhaseList = commPhaseModel!.data!;
    });
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<TourController>(builder: (tourController) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Salon Name',
                            style: const TextStyle(
                                color: primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: salonController,
                        focusNode: focusNode,
                        decoration:
                            GlobalFunctions.getInputDecoration('Salon Name'),
                        style: TextStyle(fontSize: 14),
                        keyboardType: TextInputType.text,
                        onChanged: onSearchTextChanged,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: isDetailsVisible ? true : false,
                        child: salonNameList == null || salonNameList!.isEmpty
                            ? Center(child: SizedBox())
                            : Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: salonNameList!.length,
                                    physics: ScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return (Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 1),
                                        child: InkWell(
                                          onTap: () {
                                            salonController.text =
                                                salonNameList![index].name!;
                                            contactController.text =
                                                salonNameList![index].mobile!;
                                            focusNode.requestFocus();
                                            setState(() {
                                              isDetailsVisible = false;
                                            });
                                            /* Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ExecutivesTourRequestList(excutive_id: _searchResult![index]!.id.toString())));*/
                                          },
                                          child: Card(
                                            elevation: 2,
                                            shadowColor: primaryColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 18, vertical: 5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Name: ${salonNameList![index].name!.toString()}',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    'Mobile: ${salonNameList![index].mobile!.toString()}',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ));
                                    }),
                              ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Salon Mobile Number',
                            style: const TextStyle(
                                color: primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: contactController,
                        decoration:
                            GlobalFunctions.getInputDecoration('Mobile Number'),
                        style: TextStyle(fontSize: 14),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(10),
                        ],
                        onSaved: (value) {
                          contactController.text = value as String;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Existing Brand',
                            style: const TextStyle(
                                color: primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: brandController,
                        decoration: GlobalFunctions.getInputDecoration(
                            'Existing Brand'),
                        style: TextStyle(fontSize: 14),
                        keyboardType: TextInputType.text,
                        onSaved: (value) {
                          brandController.text = value as String;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Communication Phase',
                            style: const TextStyle(
                                color: primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: primaryColor)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: selectedStatus,
                              dropdownColor: Colors.white,
                              isDense: true,
                              isExpanded: true,
                              iconEnabledColor: Colors.black,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedStatus = value;
                                });
                              },
                              items: commPhaseList!.map((list) {
                                return DropdownMenuItem(
                                  value: list.name,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(list.name!),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Order Received',
                            style: const TextStyle(
                                color: primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: RadioListTile(
                              title: Text("Yes"),
                              value: "yes",
                              groupValue: is_order,
                              onChanged: (value) {
                                setState(() {
                                  is_order = value.toString();
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              title: Text("No"),
                              value: "no",
                              groupValue: is_order,
                              onChanged: (value) {
                                setState(() {
                                  is_order = value.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      is_order == 'yes'
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        'Order Value',
                                        textAlign: TextAlign.left,
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
                                      controller: valueController,
                                      decoration:
                                          GlobalFunctions.getInputDecoration(
                                              'Order Value'),
                                      style: TextStyle(fontSize: 14),
                                      keyboardType: TextInputType.number,
                                      onSaved: (value) {
                                        valueController.text = value as String;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Client Satisfy',
                            style: const TextStyle(
                                color: primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: RadioListTile(
                              title: Text("Yes"),
                              value: "yes",
                              groupValue: is_satisfy,
                              onChanged: (value) {
                                setState(() {
                                  is_satisfy = value.toString();
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              title: Text("No"),
                              value: "no",
                              groupValue: is_satisfy,
                              onChanged: (value) {
                                setState(() {
                                  is_satisfy = value.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(primaryColor),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(primaryColor),
                            textStyle: MaterialStateProperty.all<TextStyle>(
                              const TextStyle(fontSize: 16),
                            ),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (salonController.text.isEmpty) {
                              showCustomSnackBar('Select Salon Name',
                                  isError: false);
                            } else if (contactController.text.isEmpty) {
                              showCustomSnackBar(
                                  'Enter Contact Number of Salon',
                                  isError: false);
                            } else if (brandController.text.isEmpty) {
                              showCustomSnackBar('Enter Existing Brand',
                                  isError: false);
                            } else if (selectedStatus == null ||
                                selectedStatus == '') {
                              showCustomSnackBar('Select Communication Phase ',
                                  isError: false);
                            } else if (is_order == null || is_order == '') {
                              showCustomSnackBar('Select Order Received Field',
                                  isError: false);
                            } else if (is_order == 'yes' &&
                                valueController.text.isEmpty) {
                              showCustomSnackBar('Enter Order Value',
                                  isError: false);
                            } else if (is_satisfy == null || is_satisfy == '') {
                              showCustomSnackBar('Select Client Satisfy Field',
                                  isError: false);
                            } else {
                              VisitData salonVisitModel = VisitData();
                              salonVisitModel.salonName = salonController.text;
                              salonVisitModel.mobile = contactController.text;
                              salonVisitModel.existingBrand =
                                  brandController.text;
                              salonVisitModel.commPhase = selectedStatus;
                              salonVisitModel.isOrder = is_order;
                              is_order == 'yes'
                                  ? salonVisitModel.orderValue =
                                      int.parse(valueController.text)
                                  : salonVisitModel.orderValue = 0;
                              salonVisitModel.isSatisfy = is_satisfy;

                              Navigator.pop(context, salonVisitModel);
                              //submitTourVisitDetails(tourController);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              'Add'.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            );
          });
  }

  onSearchTextChanged(String text) async {
    // salonNameList!.clear();

    if (text.isNotEmpty && text.length > 4) {
      Future.delayed(Duration.zero, () async {
        salonDataModel =
            await Get.find<TourController>().getSalonNameList(key: text);
        salonNameList = salonDataModel!.data!;
        if (salonNameList!.isNotEmpty) {
          isDetailsVisible = true;
        }
        else{
          showCustomSnackBar('Salon Name is not found in list!',isError: false);
        }
      });
      setState(() {});
      return;
    } else {
      isDetailsVisible = false;
      setState(() {
        contactController.clear();
      });
    }
  }
}
