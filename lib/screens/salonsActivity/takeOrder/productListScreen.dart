import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmers/controllers/cartController.dart';
import 'package:shimmers/model/salonDetailsModel.dart';
import 'package:shimmers/model/unitTypeModel.dart';
import 'package:shimmers/screens/salons/salonDetails/qtyTypeScreen.dart';
import 'package:shimmers/screens/salonsActivity/takeOrder/finalOrderScreen.dart';
import 'package:shimmers/screens/salonsActivity/takeOrder/suggestedProductListScreen.dart';

import '../../../constant/colorsConstant.dart';
import '../../../constant/globalFunction.dart';
import '../../../constant/textConstant.dart';
import '../../../controllers/salonController.dart';

class ProductListScreen extends StatefulWidget {
  final SalonDetailsModel model;

  const ProductListScreen({Key? key, required this.model}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  TextEditingController shippingAddressController = TextEditingController();
  TextEditingController clientNoteController = TextEditingController();
  String? unitTypeId, unitType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.find<SalonController>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    shippingAddressController.text = widget.model.data!.shippingAddress!;

    return GetBuilder<CartController>(builder: (cartController) {
      return GetBuilder<SalonController>(builder: (salonController) {
        return Scaffold(
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
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 15),
                          color: kBackgroundColor,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  widget.model.data!.name!,
                                  style: TextStyle(
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
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  widget.model.data!.address!,
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              RichText(
                                  text: TextSpan(
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      children: <TextSpan>[
                                    TextSpan(
                                      text: TextConstant.shippingAddress,
                                    ),
                                    TextSpan(
                                      text: ' *',
                                      style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ])),
                              const SizedBox(
                                height: 3,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0.0, vertical: 8),
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 14),
                                  maxLines: 2,
                                  decoration:
                                      GlobalFunctions.getInputDecoration(
                                          TextConstant.shippingAddress),
                                  controller: shippingAddressController,
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              RichText(
                                  text: TextSpan(
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      children: <TextSpan>[
                                    TextSpan(
                                      text: TextConstant.unitType,
                                    ),
                                    TextSpan(
                                      text: ' *',
                                      style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ])),
                              const SizedBox(
                                height: 3,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0.0, vertical: 8),
                                child: InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          const QtyTypeScreen(),
                                      backgroundColor: Colors.transparent,
                                    ).then((unitTypeModel) => {
                                          setState(() {
                                            UnitTypeData model = unitTypeModel;
                                            unitTypeId = model.id.toString();
                                            unitType = model.unitType;
                                          })
                                        });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      // boxShadow: const [
                                      //   BoxShadow(
                                      //     color: primaryColor,
                                      //     blurRadius: 12.0, // soften the shadow
                                      //     spreadRadius: 0.5, //extend the shadow
                                      //     offset: Offset(
                                      //       1.0, // Move to right 5  horizontally
                                      //       1.0, // Move to bottom 5 Vertically
                                      //     ),
                                      //   )
                                      // ],
                                      border: Border.all(color: primaryColor),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              unitType == null ? "" : unitType!,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14),
                                            ),
                                          )),
                                          Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.grey.shade900,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${TextConstant.clientNote} :",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0.0, vertical: 8),
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 14),
                                  maxLines: 2,
                                  decoration:
                                      GlobalFunctions.getInputDecoration(
                                          TextConstant.clientNote),
                                  controller: clientNoteController,
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                      salonController.isLoading ||
                              salonController.productModel == null
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  salonController.productModel!.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  color: kBackgroundColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 15),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      if (salonController.productModel!
                                              .data![index].imageUrl !=
                                          "")
                                        Image.network(
                                          salonController.productModel!
                                              .data![index].imageUrl!,
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
                                            salonController.productModel!
                                                .data![index].name!,
                                            style: TextStyle(
                                                color: primaryColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '₹ ${salonController.productModel!.data![index].price!}',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: InkWell(
                                              onTap: () {
                                                showModalBottomSheet(
                                                        context: context,
                                                        useSafeArea: true,
                                                        builder: (context) =>
                                                            SuggestedProductListScreen(
                                                                suggestedProductsList:
                                                                    salonController
                                                                        .productModel!
                                                                        .data![
                                                                            index]
                                                                        .suggestedProducts!),
                                                        backgroundColor:
                                                            Colors.white,
                                                        isScrollControlled:
                                                            true)
                                                    .then((value) => {
                                                          setState(() {
                                                            // selectedLeaveType = value!;
                                                          })
                                                        });
                                              },
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                          color: primaryColor),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 8.0,
                                                        horizontal: 35),
                                                    child: Text(
                                                      TextConstant.add
                                                          .toUpperCase(),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ))
                                    ],
                                  ),
                                );
                              },
                            ),
                      const SizedBox(
                        height: 45,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FinalOrderScreen(),
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            TextConstant.createOrder.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        )),
                  ),
                ),
              ),
            ],
          ),
        );
      });
    });
  }
}
