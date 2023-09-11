import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant/colorsConstant.dart';
import '../../../../constant/custom_snackbar.dart';
import '../../../../constant/textConstant.dart';
import '../../../../controllers/salonController.dart';

class SalonTypeScreen extends StatefulWidget {
  final String salonId;

  const SalonTypeScreen({Key? key, required this.salonId}) : super(key: key);

  @override
  State<SalonTypeScreen> createState() => _SalonTypeScreenState();
}

class _SalonTypeScreenState extends State<SalonTypeScreen> {
  List<String> salonTypeList = ['New', 'Existing']; // Option 2

  @override
  void initState() {
    super.initState();

    Get.find<SalonController>().getSalonCategory();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalonController>(builder: (salonController) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      TextConstant.salonType,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).pop();
                      Navigator.pop(context, "");
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
                itemCount: salonTypeList.length,
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
                                updateSalonType(
                                    salonController, salonTypeList[index]);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    salonTypeList[index],
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

  Future<void> updateSalonType(
      SalonController salonController, String salonType) async {
    salonController
        .updateSalonType(salonId: widget.salonId, salonType: salonType)
        .then((message) async {
      if (message == 'Salon stage updated successfully') {
        showCustomSnackBar(message!, isError: false);
        Navigator.pop(context, salonType);
      } else {
        showCustomSnackBar(message!);
      }
    });
  }
}
