import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmers/model/feedBackPurposeModel.dart';

import '../../../../constant/colorsConstant.dart';
import '../../../../constant/textConstant.dart';
import '../../../../controllers/salonController.dart';

class FeedbackPurposeScreen extends StatefulWidget {
  const FeedbackPurposeScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackPurposeScreen> createState() => _FeedbackPurposeScreenState();
}

class _FeedbackPurposeScreenState extends State<FeedbackPurposeScreen> {
  @override
  void initState() {
    super.initState();

    Get.find<SalonController>().getFeedbackPurpose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalonController>(builder: (salonController) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: salonController.isLoading ||
                  salonController.feedBackPurposeModel == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              TextConstant.selectPurpose,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // Navigator.of(context).pop();
                              Navigator.pop(context, FeedbackData());
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
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            salonController.feedBackPurposeModel!.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 10),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 1.0, vertical: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(
                                            context,
                                            salonController
                                                .feedBackPurposeModel!
                                                .data![index]);
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            salonController
                                                .feedBackPurposeModel!
                                                .data![index]
                                                .feedbackType!,
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
                          return const Divider();
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
