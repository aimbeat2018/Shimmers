import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmers/model/setTargetModel.dart';
import 'package:shimmers/screens/setTarget/setProductListWidget.dart';

import '../../constant/app_constants.dart';
import '../../constant/colorsConstant.dart';
import '../../constant/custom_snackbar.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../constant/textConstant.dart';
import '../../controllers/targetController.dart';
import '../../model/employeeListModel.dart';
import '../../model/productModel.dart';
import '../noDataFound/noDataFoundScreen.dart';

class SetProductTargetScreen extends StatefulWidget {
  final Members membersModel;

  const SetProductTargetScreen({Key? key, required this.membersModel})
      : super(key: key);

  @override
  State<SetProductTargetScreen> createState() => _SetProductTargetScreenState();
}

class _SetProductTargetScreenState extends State<SetProductTargetScreen> {
  TextEditingController searchController = TextEditingController();
  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  ProductModel? model;

  List<ProductData>? _searchResult;

  List<ProductData>? _productData;

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

    getProductList();
  }

  Future<void> getProductList() async {
    _productData = [];
    _searchResult = [];
    model = await Get.find<TargetController>().getProducts();
    _productData = model!.data!;

    if (mounted) {
      setState(() {});
    }
  }

  onSearchTextChanged(String text) async {
    _searchResult!.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    for (var product in _productData!) {
      if (product.name!.toLowerCase().contains(text)) {
        _searchResult!.add(product);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<TargetController>(builder: (targetController) {
            return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
                backgroundColor: primaryColor,
                centerTitle: true,
                title: Text(
                  TextConstant.SetTarget,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 25),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: searchController,
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide:
                                  BorderSide(color: primaryColor, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide:
                                  BorderSide(color: primaryColor, width: 1),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            hintText: 'Search',
                            suffixIcon: Icon(
                              CupertinoIcons.search,
                              size: 28,
                            )),
                        keyboardType: TextInputType.text,
                        // onChanged: (value) {
                        //   onSearchTextChanged(value);
                        // },
                        onChanged: onSearchTextChanged,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      targetController.isLoading || model == null
                          ? const Center(child: CircularProgressIndicator())
                          : model!.data == null
                              ? const Center(
                                  child: NoDataFoundScreen(),
                                )
                              : _searchResult!.isNotEmpty ||
                                      searchController.text.isNotEmpty
                                  ? ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _searchResult!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return SetProductListWidget(
                                          productData: _searchResult![index],
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const Divider();
                                      },
                                    )
                                  : ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _productData!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return SetProductListWidget(
                                          productData: _productData![index],
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const Divider();
                                      },
                                    ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: targetController.isTargetLoading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              primaryColor),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              primaryColor),
                                      textStyle:
                                          MaterialStateProperty.all<TextStyle>(
                                        const TextStyle(fontSize: 16),
                                      ),
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                        const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
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
                                      _productData;
                                      _productData;
                                      SetTargetModel setTargetModel =
                                          new SetTargetModel();

                                      List<ProductDataModel> productTargetList =
                                          [];

                                      for (var targetModel in _productData!) {
                                        ProductDataModel productDataModel =
                                            new ProductDataModel();
                                        productDataModel.productId =
                                            targetModel.id;
                                        productDataModel.target =
                                            targetModel.target;
                                        productTargetList.add(productDataModel);
                                      }
                                      setTargetModel.employeeId =
                                          widget.membersModel.id;
                                      setTargetModel.productData =
                                          productTargetList;

                                      submitTargetData(
                                          setTargetModel, targetController);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        TextConstant.SetTarget.toUpperCase(),
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
                ),
              ),
            );
          });
  }

  void submitTargetData(
      SetTargetModel setTargetModel, TargetController targetController) async {
    targetController
        .submitProductWiseTarget(setTargetModel: setTargetModel)
        .then((value) async{
      if (value! == 'Target assigned successfully')
      {
        showCustomSnackBar(value!,
            isError: false);
        Navigator.pop(context);

      }
      else
      {
        showCustomSnackBar(value!,
            isError: false);
      }
            });
  }
}
