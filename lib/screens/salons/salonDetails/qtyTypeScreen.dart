import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant/colorsConstant.dart';
import '../../../../constant/textConstant.dart';
import '../../../../controllers/salonController.dart';
import '../../../model/unitTypeModel.dart';

class QtyTypeScreen extends StatefulWidget {
  const QtyTypeScreen({Key? key}) : super(key: key);

  @override
  State<QtyTypeScreen> createState() => _QtyTypeScreenState();
}

class _QtyTypeScreenState extends State<QtyTypeScreen> {
  @override
  void initState() {
    super.initState();

    Get.find<SalonController>().getUnitType();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalonController>(builder: (salonController) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: salonController.isLoading ||
                  salonController.unitTypeModel == null
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
                            TextConstant.unitType,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // Navigator.of(context).pop();
                            Navigator.pop(context, UnitTypeModel());
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
                      physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: salonController.unitTypeModel!.data!.length,
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
                                          salonController
                                              .unitTypeModel!.data![index]);
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          salonController.unitTypeModel!
                                              .data![index].unitType!,
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
      );
    });
  }
}
