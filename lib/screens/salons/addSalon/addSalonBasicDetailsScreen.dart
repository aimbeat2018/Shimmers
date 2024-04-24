import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shimmers/constant/custom_snackbar.dart';
import 'package:shimmers/constant/textConstant.dart';
import 'package:shimmers/model/brandDetailModel.dart';
import 'package:shimmers/model/salonCategoryModel.dart';
import 'package:shimmers/screens/salons/addSalon/addSalonPersonalDetailsScreen.dart';
import 'package:shimmers/screens/salons/addSalon/bottomSheet/brandListScreen.dart';
import 'package:shimmers/screens/salons/addSalon/bottomSheet/salonCatgeoryScreen.dart';

import '../../../constant/colorsConstant.dart';
import '../../../constant/globalFunction.dart';
import '../../../controllers/salonController.dart';

class AddSalonBasicDetailsScreen extends StatefulWidget {
  static const String name = 'addSalonBasicDetailsScreen';

  const AddSalonBasicDetailsScreen({Key? key}) : super(key: key);

  @override
  State<AddSalonBasicDetailsScreen> createState() =>
      _AddSalonBasicDetailsScreenState();
}

class _AddSalonBasicDetailsScreenState
    extends State<AddSalonBasicDetailsScreen> {
  showBackDialog(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(TextConstant.backTitle),
          content: Text(TextConstant.backDescription),
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

  TextEditingController salonNameController = TextEditingController();
  TextEditingController beatrouteidController = TextEditingController();
  String salonCategory = '', salonId = '';
  String brandName = '', brandId = '';
  List<String> customerTypeList=['SALON ','RETAIL SHOP','WHOLESALE SHOP','FREELANCER'];
  String? selectedCustType;


  @override
  void initState() {
    super.initState();
    if (mounted) {
      Future.delayed(Duration.zero, () async {
        Get.find<SalonController>().getSalonCategory().then((value) async{
          Get.find<SalonController>().getBrandList();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalonController>(builder: (salonController) {
      return WillPopScope(
          child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.white, //change your color here
              ),
              backgroundColor: primaryColor,
              centerTitle: true,
              title: Text(
                TextConstant.addSalon,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 200.0,
                        child: Row(
                          children: [
                            const Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: primaryColor,
                                  size: 24.0,
                                ),
                                Text(
                                  '1',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 50.0,
                              child: Divider(
                                color: Colors.grey.shade300,
                                thickness: 1.5,
                              ),
                            ),
                            const Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.grey,
                                  size: 22.0,
                                ),
                                Text(
                                  '2',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 50.0,
                              child: Divider(
                                color: Colors.grey.shade300,
                                thickness: 1.5,
                              ),
                            ),
                            const Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.grey,
                                  size: 22.0,
                                ),
                                Text(
                                  '3',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                TextConstant.salonCategory,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) =>
                                    const SalonCatgeoryScreen(),
                                backgroundColor: Colors.transparent,
                              ).then((value) => {
                                    setState(() {
                                      SalonCategoryData model = value;
                                      salonCategory = model.categoryName!;
                                      salonId = model.id!.toString();
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
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text(
                                        salonCategory == ''
                                            ? "Select Salon Category"
                                            : salonCategory,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
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
                          const SizedBox(
                            height: 25,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: RichText(
                                    text: TextSpan(
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                        children: <TextSpan>[
                                      TextSpan(
                                        text: TextConstant.salonName,
                                      ),
                                      TextSpan(
                                        text: ' *',
                                        style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ]))),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
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
                            child: TextFormField(
                              style: const TextStyle(fontSize: 14),
                              decoration:
                                  GlobalFunctions.getInputDecorationWhite(""),
                              controller: salonNameController,
                              keyboardType: TextInputType.text,
                              onSaved: (value) {
                                salonNameController.text = value as String;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                                child: RichText(
                                    text: TextSpan(
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Customer Sub type',
                                          ),
                                          TextSpan(
                                            text: ' *',
                                            style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ]))),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              border: Border.all(color: primaryColor),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: Text('Select Customer Sub Type'),
                                  isExpanded: true,
                                  value: selectedCustType,
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedCustType = newValue;
                                    });
                                  },
                                  items: customerTypeList.map((ratingType) {
                                    return DropdownMenuItem(
                                      child: new Text(ratingType),
                                      value: ratingType,
                                    );
                                  }).toList()),
                            ),

                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Customer Existing Brand',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) =>
                                 BrandListScreen(),
                                backgroundColor: Colors.transparent,
                              ).then((value) => {
                                setState(() {
                                  BrandListData model = value;
                                  brandName = model!.brandName!;
                                  brandId = model.id!.toString();
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
                                          padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Text(
                                            brandName == ''
                                                ? "Select Customer Existing Brand"
                                                : brandName,
                                            style: TextStyle(
                                                color: Colors.black, fontSize: 14),
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
                          const SizedBox(
                            height: 25,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                                child: RichText(
                                    text: TextSpan(
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Beatroute ID',
                                          ),
                                         /* TextSpan(
                                            text: ' *',
                                            style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),*/
                                        ]))),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
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
                            child: TextFormField(
                              style: const TextStyle(fontSize: 14),
                              decoration:
                              GlobalFunctions.getInputDecorationWhite(""),
                              controller: beatrouteidController,
                              keyboardType: TextInputType.text,
                              onSaved: (value) {
                                beatrouteidController.text = value as String;
                              },
                            ),
                          ),
                          const SizedBox(height: 50),

                          SizedBox(
                            width: 200,
                            // height: 45,
                            child: ElevatedButton(
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
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  if (salonNameController.text.isEmpty) {
                                    showCustomSnackBar('Enter salon name',
                                        isError: true);
                                  }else if(selectedCustType==null){
                                    showCustomSnackBar('Select customer sub type',
                                        isError: true);
                                } else{
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: AddSalonPersonalDetailsScreen(
                                          salonCategory: salonId,
                                          salonName:
                                          salonNameController.text),
                                      withNavBar: false,
                                    );
                                    /*Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) =>
                                          AddSalonPersonalDetailsScreen(
                                              salonCategory: salonId,
                                              salonName:
                                                  salonNameController.text),
                                    ));*/
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    TextConstant.submit.toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          onWillPop: () async {
            return showBackDialog(context);
          });
    });
  }
}
