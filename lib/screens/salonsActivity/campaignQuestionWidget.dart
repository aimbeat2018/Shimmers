import 'package:flutter/material.dart';
import 'package:shimmers/constant/colorsConstant.dart';

import '../../constant/globalFunction.dart';
import '../../constant/textConstant.dart';
import '../../model/campaignModel.dart';

class CampaignQuestionWidget extends StatefulWidget {
  final CampaignModel model;

  const CampaignQuestionWidget({Key? key, required this.model})
      : super(key: key);

  @override
  State<CampaignQuestionWidget> createState() => _CampaignQuestionWidgetState();
}

class _CampaignQuestionWidgetState extends State<CampaignQuestionWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.model.question!,
            style: const TextStyle(
                color: primaryColor, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          if (widget.model.type! == "list")
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    // showModalBottomSheet(
                    //   context: context,
                    //   builder: (context) => LeaveTypeSheet(),
                    //   backgroundColor: Colors.transparent,
                    // ).then((value) => {
                    //   setState(() {
                    //     selectedLeaveType = value!;
                    //   })
                    // });
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
                              TextConstant.selectEmployee,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                            ),
                          )),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey.shade700,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          if (widget.model.type! == "image")
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {},
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
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: primaryColor)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35.0, vertical: 50),
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            TextConstant.takePhoto,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          if (widget.model.type! == "multiple")
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.model.answersList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 5),
                      child: Row(
                        children: [
                          Icon(Icons.check_box_outline_blank_outlined),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            widget.model.answersList![index].name!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          if (widget.model.type! == "input")
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    // showModalBottomSheet(
                    //   context: context,
                    //   builder: (context) => LeaveTypeSheet(),
                    //   backgroundColor: Colors.transparent,
                    // ).then((value) => {
                    //   setState(() {
                    //     selectedLeaveType = value!;
                    //   })
                    // });
                  },
                  child: TextFormField(
                    style: const TextStyle(fontSize: 14),
                    maxLines: 5,
                    decoration: GlobalFunctions.getInputDecoration(
                        TextConstant.remarks),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ],
            ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
