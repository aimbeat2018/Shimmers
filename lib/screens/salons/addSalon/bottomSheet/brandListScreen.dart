import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmers/controllers/salonController.dart';
import 'package:shimmers/model/brandDetailModel.dart';

import '../../../../constant/colorsConstant.dart';
import '../../../../constant/textConstant.dart';
import '../../../../model/salonCategoryModel.dart';

class BrandListScreen extends StatefulWidget {
  const BrandListScreen({Key? key}) : super(key: key);

  @override
  State<BrandListScreen> createState() => _BrandListScreen();
}

class _BrandListScreen extends State<BrandListScreen> {
  @override
  void initState() {
    super.initState();

    Get.find<SalonController>().getBrandList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalonController>(builder: (salonController) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: salonController.isLoading ||
                salonController.brandDetailModel == null
                ? Center(
              child: CircularProgressIndicator(),
            )
                : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        'Select Customer Brand Name',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.of(context).pop();
                        Navigator.pop(context, BrandListData());
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.grey.shade900,
                      ),
                    )
                  ],
                ),
                Divider(
                  color: Colors.grey.shade500,
                ),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                  salonController.brandDetailModel!.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 1.0, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(
                                      context,
                                      salonController.brandDetailModel!
                                          .data![index]);
                                },
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      salonController.brandDetailModel!
                                          .data![index].brandName!,
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
              ],
            ),
          ),
        ),
      );
    });
  }
}
