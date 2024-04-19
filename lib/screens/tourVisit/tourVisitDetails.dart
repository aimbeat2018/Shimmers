import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmers/controllers/tourController.dart';
import 'package:shimmers/model/salonVisitModel.dart';
import 'package:shimmers/model/submitTourModel.dart';
import 'package:shimmers/screens/tourVisit/visitDetailsSheet.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/custom_snackbar.dart';
import '../../constant/globalFunction.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/textConstant.dart';

class TourVisitDetails extends StatefulWidget {
  final String tour_requestid;

  const TourVisitDetails({Key? key, required this.tour_requestid})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TourVisitDetails();
  }
}

class _TourVisitDetails extends State<TourVisitDetails> {
  TextEditingController contactController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController descriController = TextEditingController();

  String? selectedDate, selectedTime;
  List<VisitData> salonVisitDetailsList = [];
  bool isListVisible = false;

  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    CheckInternet.initConnectivity().then((value) => setState(() {
          _connectionStatus = value;
        }));
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      CheckInternet.updateConnectionStatus(result).then((value) => setState(() {
            _connectionStatus = value;
          }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TourController>(builder: (tourController) {
      return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Text(
            'Fill Tour Visit Details',
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Column(
              children: [
                /* Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Area',
                      style: const TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: areaController,
                  decoration: GlobalFunctions.getInputDecoration('Area'),
                  style: TextStyle(fontSize: 14),
                  keyboardType: TextInputType.text,
                  onSaved: (value) {
                    areaController.text = value as String;
                  },
                ),
                SizedBox(
                  height: 25,
                ),*/
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Date',
                      style: const TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        selectedDate = formattedDate;
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: primaryColor)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              selectedDate == null
                                  ? TextConstant.selectDate
                                  : selectedDate!,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                            ),
                          )),
                          Icon(
                            Icons.calendar_month,
                            color: Colors.grey.shade700,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Remark',
                      style: const TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  style: const TextStyle(fontSize: 14),
                  maxLines: 5,
                  decoration: GlobalFunctions.getInputDecoration('Enter Remark'),
                  controller: descriController,
                  keyboardType: TextInputType.text,
                  onSaved: (value) {
                    descriController.text = value as String;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                salonVisitDetailsList.isNotEmpty
                    ? Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: ListView.builder(
                      itemCount: salonVisitDetailsList!.length,
                      shrinkWrap: true,
                     physics: NeverScrollableScrollPhysics(),
                     // physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: Card(
                            elevation: 2,
                            shadowColor: primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10))),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Salon Name: ${salonVisitDetailsList![index].salonName!.toString()}',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            salonVisitDetailsList
                                                .removeAt(index);
                                          });
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: primaryColor,
                                          size: 20,
                                        ),
                                      ),

                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Salon Mobile: ${salonVisitDetailsList![index].mobile!.toString()}',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) => VisitDetailsSheet(
                                              salonName: salonVisitDetailsList![index].salonName!.toString(),
                                              salonMob: salonVisitDetailsList![index].mobile!.toString(),
                                              brand: salonVisitDetailsList![index].existingBrand!.toString(),
                                              comm_phase: salonVisitDetailsList![index].commPhase!.toString(),
                                              order_value: salonVisitDetailsList![index].orderValue!.toString(),
                                              is_order:salonVisitDetailsList![index].isOrder!.toString(),
                                              is_satisfy: salonVisitDetailsList![index].isSatisfy!.toString(),
                                            ),
                                            backgroundColor: Colors.transparent,
                                          ).then((salonDetails) => {
                                            setState(() {
                                              VisitData model = salonDetails;
                                              if (model.salonName != null) {
                                                salonVisitDetailsList[index].salonName=model.salonName;
                                                salonVisitDetailsList[index].mobile=model.mobile;
                                                salonVisitDetailsList[index].existingBrand=model.existingBrand;
                                                salonVisitDetailsList[index].commPhase=model.commPhase;
                                                salonVisitDetailsList[index].isOrder=model.isOrder;
                                                salonVisitDetailsList[index].orderValue=model.orderValue;
                                                salonVisitDetailsList[index].isSatisfy=model.isSatisfy;
                                               // salonVisitDetailsList.add(model);
                                              }
                                            })
                                          });

                                        },
                                        child: Icon(
                                          Icons.edit,
                                          color: primaryColor,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Existing Brand: ${salonVisitDetailsList![index].existingBrand!.toString()}',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Communication Phase: ${salonVisitDetailsList![index].commPhase!.toString()}',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Order Received: ${salonVisitDetailsList![index].isOrder!.toString()}',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  salonVisitDetailsList![index]
                                      .isOrder ==
                                      'yes'
                                      ? Padding(
                                        padding: const EdgeInsets.only(top: 5.0),
                                        child: Text(
                                    'Order Value: Rs. ${salonVisitDetailsList![index].orderValue!.toString()}',
                                    style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                          fontWeight:
                                          FontWeight.w500),
                                  ),
                                      )
                                      : SizedBox(),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      'Client Satisfy: ${salonVisitDetailsList![index].isSatisfy!.toString()}',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                )
                    : SizedBox(),
                /*Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      TextConstant.selectTime,
                      style: const TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () async {
                    final TimeOfDay? result = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    if (result != null) {
                      setState(() {
                        selectedTime = result.format(context);
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: primaryColor)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              selectedTime == null
                                  ? TextConstant.selectTime
                                  : selectedTime!,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                            ),
                          )),
                          Icon(
                            Icons.watch_later,
                            color: Colors.grey.shade700,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Role',
                      style: const TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: roleController,
                  decoration: GlobalFunctions.getInputDecoration('Role'),
                  style: TextStyle(fontSize: 14),
                  keyboardType: TextInputType.text,
                  onSaved: (value) {
                    roleController.text = value as String;
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Name',
                      style: const TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: nameController,
                  decoration: GlobalFunctions.getInputDecoration('Name'),
                  style: TextStyle(fontSize: 14),
                  keyboardType: TextInputType.text,
                  onSaved: (value) {
                    nameController.text = value as String;
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Contact',
                      style: const TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: contactController,
                  decoration: GlobalFunctions.getInputDecoration('Contact'),
                  style: TextStyle(fontSize: 14),
                  keyboardType: TextInputType.text,
                  onSaved: (value) {
                    contactController.text = value as String;
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                */
                const SizedBox(height: 30),
                SizedBox(
                  width: 200,
                  child: tourController.isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
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
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => VisitDetailsSheet(salonName: '',
                                salonMob: '',
                                brand: '',
                                comm_phase: '',
                                order_value: '',
                                is_order:'',
                                is_satisfy: '',),
                              backgroundColor: Colors.transparent,
                            ).then((salonDetails) => {
                                  setState(() {
                                    VisitData model = salonDetails;
                                    if (model.salonName != null) {
                                      salonVisitDetailsList.add(model);
                                    }
                                  })
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              'Fill Salon Details'.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  width: 200,
                  child: tourController.isLoading
                      ? Center(
                    child: CircularProgressIndicator(),
                  )
                      : ElevatedButton(
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
                        if (selectedDate == null) {
                              showCustomSnackBar(TextConstant.selectDate,
                                  isError: false);
                            } else if (descriController.text.isEmpty) {
                              showCustomSnackBar('Enter Remark',
                                  isError: false);
                            } else {
                              SubmitTourModel submitTourModel=SubmitTourModel();
                              submitTourModel.tourReqId=int.parse(widget.tour_requestid);
                              submitTourModel.resubmitDate=selectedDate;
                              submitTourModel.executiveRemark=descriController.text;
                              submitTourModel.visitData=salonVisitDetailsList;

                              submitTourVisitDetails(tourController,submitTourModel);
                            }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Submit'.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      )),
                ),

              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> submitTourVisitDetails(TourController tourController,SubmitTourModel submitTourModel) async {
    tourController
        .submitTourVisitDetails(submitTourModel)
        .then((message) async {
      if (message == 'Tour Visit Details submitted successfully.') {
        showCustomSnackBar(message!, isError: false);
        Navigator.pop(context);
        /* Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TourListScreen()));*/
      } else {
        showCustomSnackBar(message!);
      }
    });
  }
}
