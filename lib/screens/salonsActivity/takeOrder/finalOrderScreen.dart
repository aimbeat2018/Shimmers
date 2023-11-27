import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmers/model/placeOrderModel.dart';

import '../../../constant/app_constants.dart';
import '../../../constant/colorsConstant.dart';
import '../../../constant/custom_snackbar.dart';
import '../../../constant/globalFunction.dart';
import '../../../constant/internetConnectivity.dart';
import '../../../constant/no_internet_screen.dart';
import '../../../constant/textConstant.dart';
import '../../../controllers/salonController.dart';
import '../../../model/cartModel.dart';

class FinalOrderScreen extends StatefulWidget {
  static const String name = 'finalOrderScreen';
  final String salonId;
  final String salonName;
  final String shippingAddress;
  final String address;
  final String unitTypeId;
  final String note;
  final List<CartModel> cartList;

  const FinalOrderScreen(
      {Key? key,
      required this.salonId,
      required this.shippingAddress,
      required this.address,
      required this.unitTypeId,
      required this.note,
      required this.cartList,
      required this.salonName})
      : super(key: key);

  @override
  State<FinalOrderScreen> createState() => _FinalOrderScreenState();
}

class _FinalOrderScreenState extends State<FinalOrderScreen> {
  List<String> discountType = ['Percentage', 'Amount'];
  String? selectedDiscountType = "Percentage";

  late int totalAmount, totalDiscountAmount, totalPayableAmount, need_approval,count;

  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    CheckInternet.initConnectivity().then((value) => setState(() {
          _connectionStatus = value;
        }));
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      CheckInternet.updateConnectionStatus(result).then((value) => setState(() {
            _connectionStatus = value;
          }));
    });

    totalAmount = 0;
    totalDiscountAmount = 0;
    totalPayableAmount = 0;
    need_approval = 0;
    count=0;
    for (var cartModel in widget.cartList) {
      totalAmount += cartModel.amount!;
      totalPayableAmount += cartModel.amount!;
      cartModel.discountType = selectedDiscountType;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<SalonController>(builder: (salonController) {
            return WillPopScope(
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: primaryColor,
                    centerTitle: true,
                    title: Text(
                      TextConstant.takeOrder,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  body: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 15),
                                  color: kBackgroundColor,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${TextConstant.salonName} :",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          widget.salonName,
                                          style: const TextStyle(
                                              color: primaryColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${TextConstant.shippingAddress} :",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          widget.shippingAddress,
                                          style: const TextStyle(
                                              color: primaryColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${TextConstant.billingAddress} :",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          widget.address,
                                          style: const TextStyle(
                                              color: primaryColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  )),
                              const SizedBox(
                                height: 25,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    TextConstant.productList,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: widget.cartList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    color: kBackgroundColor,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 15),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Row(
                                      children: [
                                        if (widget.cartList[index].image != "")
                                          Image.network(
                                            widget.cartList[index].image!,
                                            height: 70,
                                            width: 70,
                                            fit: BoxFit.cover,
                                          ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.cartList[index].itemName!,
                                              style: const TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              widget.cartList[index]
                                                          .amountWithQty ==
                                                      null
                                                  ? '₹ ${widget.cartList[index].amount}'
                                                  : '₹ ${widget.cartList[index].amountWithQty}',
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.45,
                                                  child: TextFormField(
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                    maxLines: 1,
                                                    decoration: GlobalFunctions
                                                        .getInputDecoration(
                                                            TextConstant
                                                                .discount),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    onChanged: (value) {
                                                      if (value.isNotEmpty) {
                                                        if (selectedDiscountType ==
                                                            "Percentage") {
                                                            calculateDiscountPercentageAmount(
                                                                value, index);
                                                        } else {
                                                          calculateDiscountAmount(
                                                              value, index);
                                                        }
                                                      }
                                                      /* else{
                                                        widget.cartList[index].afterDiscountAmount=0;
                                                      }*/
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(
                                                  Icons.percent_sharp,
                                                  size: 20,
                                                ),

/*
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.35,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 15),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: primaryColor),
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child: DropdownButton(
                                                        isExpanded: true,
                                                        value:
                                                            selectedDiscountType,
                                                        onChanged: (newValue) {
                                                          setState(() {
                                                            selectedDiscountType =
                                                                newValue;

                                                            widget
                                                                    .cartList[index]
                                                                    .discountType =
                                                                selectedDiscountType;

                                                            if (widget
                                                                    .cartList[
                                                                        index]
                                                                    .discountValue !=
                                                                0) {
                                                              if (selectedDiscountType ==
                                                                  "Percentage") {
                                                                calculateDiscountPercentageAmount(
                                                                    widget
                                                                        .cartList[
                                                                            index]
                                                                        .discountValue
                                                                        .toString(),
                                                                    index);
                                                              } else {
                                                                calculateDiscountAmount(
                                                                    widget
                                                                        .cartList[
                                                                            index]
                                                                        .discountValue
                                                                        .toString(),
                                                                    index);
                                                              }
                                                            }
                                                          });
                                                        },
                                                        items: discountType.map(
                                                            (discountType) {
                                                          return DropdownMenuItem(
                                                            child: new Text(
                                                                discountType),
                                                            value: discountType,
                                                          );
                                                        }).toList()),
                                                  ),
                                                ),
*/
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              'Discount Price : ₹ ${widget.cartList[index].afterDiscountAmount}',
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      minusQty(index);
                                                    },
                                                    child: Container(
                                                      height: 22,
                                                      width: 22,
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10),
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            width: 1,
                                                            color:
                                                                primaryColor),
                                                        color: primaryColor,
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: const Icon(
                                                        Icons.remove,
                                                        size: 15,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                      widget.cartList[index]
                                                          .quantity!
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                  InkWell(
                                                    onTap: () {
                                                      addQty(index);
                                                    },
                                                    child: Container(
                                                      height: 22,
                                                      width: 22,
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10),
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            width: 1,
                                                            color:
                                                                primaryColor),
                                                        color: primaryColor,
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: const Icon(
                                                        Icons.add,
                                                        size: 15,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ))
                                      ],
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          TextConstant.totalAmount,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "₹ $totalAmount",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          TextConstant.totalDiscount,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "₹ $totalDiscountAmount",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      ],
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      child: Divider(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          TextConstant.totalPayable,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "₹ $totalPayableAmount",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 20),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: salonController.isLoading
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(primaryColor),
                                              foregroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(primaryColor),
                                              textStyle: MaterialStateProperty
                                                  .all<TextStyle>(
                                                const TextStyle(fontSize: 16),
                                              ),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsets>(
                                                const EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 8),
                                              ),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              for(var productCartlist in widget.cartList!)
                                                {
                                                  int actual_discount=productCartlist!.discountValue!;
                                                  int stand_discount=productCartlist!.standalon_discount!;
                                                 if(actual_discount>stand_discount)
                                                   {
                                                     need_approval=1;
                                                   }
                                                }
                                              if(need_approval==1)
                                                {
                                                  PlaceOrderModel model =
                                                  PlaceOrderModel(
                                                      clientId: int.parse(
                                                          widget.salonId),
                                                      shippingAddress: widget
                                                          .shippingAddress,
                                                      address: widget.address,
                                                      unitTypeId: int.parse(
                                                          widget.unitTypeId),
                                                      products: widget.cartList,
                                                      subTotal: totalAmount,
                                                      afterSubTotal:
                                                      totalDiscountAmount,
                                                      note: widget.note,
                                                      need_approval:
                                                      need_approval);
                                                  showDiscountDialog(context,salonController,model);
                                                }
                                              else{
                                                PlaceOrderModel model =
                                                PlaceOrderModel(
                                                    clientId: int.parse(
                                                        widget.salonId),
                                                    shippingAddress: widget
                                                        .shippingAddress,
                                                    address: widget.address,
                                                    unitTypeId: int.parse(
                                                        widget.unitTypeId),
                                                    products: widget.cartList,
                                                    subTotal: totalAmount,
                                                    afterSubTotal:
                                                    totalDiscountAmount,
                                                    note: widget.note,
                                                    need_approval:
                                                    need_approval);
                                                placeOrder(
                                                    salonController, model);
                                              }

                                            /*  placeOrder(
                                                  salonController, model);*/
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                TextConstant.placeOrder
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onWillPop: () async {
                  return showBackDialog(context);
                });
          });
  }

  showBackDialog(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(TextConstant.backTitle),
          content: Text(TextConstant.backDescription1),
          actions: [
            TextButton(
              child: Text(TextConstant.cancel),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(TextConstant.yes),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(parentContext);
              },
            )
          ],
        );
      },
    );
  }

  showDiscountDialog(BuildContext parentContext,SalonController salonController,PlaceOrderModel model) {
    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(TextConstant.discountTitle),
          content: Text(TextConstant.discountDescription),
          actions: [
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
                placeOrder(
                    salonController, model);
              },
            ),
             TextButton(
              child: Text(TextConstant.cancel),
              onPressed: () {
                setState(() {
                  need_approval=0;
                });
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void calculateDiscountPercentageAmount(String value, int index) {
    setState(() {
      widget.cartList[index].discountValue = int.parse(value);

      if (widget.cartList[index].amountWithQty == null) {
        double discountValue =
            widget.cartList[index].amount! * int.parse(value) / 100;

        double discountAmount = widget.cartList[index].amount! - discountValue;
        int discountAmountStr = discountAmount.round();

        widget.cartList[index].afterDiscountAmount = discountAmountStr;
      } else {
        double discountValue =
            widget.cartList[index].amountWithQty! * int.parse(value) / 100;

        double discountAmount =
            widget.cartList[index].amountWithQty! - discountValue;
        int discountAmountStr = discountAmount.round();

        widget.cartList[index].afterDiscountAmount = discountAmountStr;
      }
      calculateTotalAmount();
    });
  }

  void calculateDiscountAmount(String value, int index) {
    setState(() {
      if (widget.cartList[index].amountWithQty == null) {
        widget.cartList[index].discountValue = int.parse(value);

        int discountAmount = widget.cartList[index].amount! -
            widget.cartList[index].discountValue!;

        print(discountAmount);

        widget.cartList[index].afterDiscountAmount =
            int.parse(discountAmount.toString());

        print(widget.cartList[index].afterDiscountAmount);
      } else {
        widget.cartList[index].discountValue = int.parse(value);

        int discountAmount = widget.cartList[index].amountWithQty! -
            widget.cartList[index].discountValue!;

        print(discountAmount);

        widget.cartList[index].afterDiscountAmount =
            int.parse(discountAmount.toString());

        print(widget.cartList[index].afterDiscountAmount);
      }

      calculateTotalAmount();
    });
  }

  void calculateTotalAmount() {
    setState(() {
      totalAmount = 0;
      totalDiscountAmount = 0;
      totalPayableAmount = 0;

      for (var cartModel in widget.cartList) {
        // totalAmount += cartModel.amount!;
        if (cartModel.amountWithQty == null) {
          totalAmount += cartModel.amount!;
        } else {
          totalAmount += cartModel.amountWithQty!;
        }
        if (cartModel.afterDiscountAmount! == 0) {
          if (cartModel.amountWithQty == null) {
            totalDiscountAmount += cartModel.amount!;
            totalPayableAmount += cartModel.amount!;
          } else {
            totalDiscountAmount += cartModel.amountWithQty!;
            totalPayableAmount += cartModel.amountWithQty!;
          }
        } else {
          totalDiscountAmount += cartModel.afterDiscountAmount!;
          totalPayableAmount += cartModel.afterDiscountAmount!;
        }
      }
    });
  }

  void minusQty(int index) {
    setState(() {
      if (widget.cartList[index].quantity! == 1) {
        widget.cartList.removeAt(index);

        if (widget.cartList.isEmpty) {
          totalPayableAmount = 0;
          totalAmount = 0;
          totalDiscountAmount = 0;
        } else {
          calculateTotalAmount();
        }
      } else {
        widget.cartList[index].quantity = widget.cartList[index].quantity! - 1;

        widget.cartList[index].amountWithQty =
            widget.cartList[index].amount! * widget.cartList[index].quantity!;

        if (widget.cartList[index].discountType == "Percentage") {
          calculateDiscountPercentageAmount(
              widget.cartList[index].discountValue.toString(), index);
        } else {
          calculateDiscountAmount(
              widget.cartList[index].discountValue.toString(), index);
        }
      }
    });
  }

  void addQty(int index) {
    setState(() {
      widget.cartList[index].quantity = widget.cartList[index].quantity! + 1;

      widget.cartList[index].quantity = widget.cartList[index].quantity!;

      widget.cartList[index].amountWithQty =
          widget.cartList[index].amount! * widget.cartList[index].quantity!;

      if (widget.cartList[index].discountType == "Percentage") {
        calculateDiscountPercentageAmount(
            widget.cartList[index].discountValue.toString(), index);
      } else {
        calculateDiscountAmount(
            widget.cartList[index].discountValue.toString(), index);
      }
    });
  }

  Future<void> placeOrder(
      SalonController salonController, PlaceOrderModel model) async {
    salonController.placeOrder(model).then((message) async {
      if (message == 'Order placed successfully.') {
        showCustomSnackBar(message!, isError: false);
        Navigator.pop(context);
      } else {
        showCustomSnackBar(message!);
      }
    });
  }
}
