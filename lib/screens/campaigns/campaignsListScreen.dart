import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmers/constant/textConstant.dart';
import 'package:shimmers/controllers/authController.dart';
import 'package:shimmers/controllers/campaignController.dart';
import 'package:shimmers/screens/campaigns/campaignsListWidget.dart';

import '../../constant/colorsConstant.dart';
import '../noDataFound/noDataFoundScreen.dart';

class CampaignsListScreen extends StatefulWidget {
  static const String name = 'campaignsListScreen';
  final String? empId;

  const CampaignsListScreen({Key? key, this.empId}) : super(key: key);

  @override
  State<CampaignsListScreen> createState() => _CampaignsListScreenState();
}

class _CampaignsListScreenState extends State<CampaignsListScreen> {
  @override
  void initState() {
    super.initState();

    String userId = Get.find<AuthController>().getUserId();

    if (widget.empId == "") {
      Get.find<CampaignController>().getEmployeeCampaignList(userId);
    } else {
      Get.find<CampaignController>().getEmployeeCampaignList(widget.empId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CampaignController>(builder: (campaignController) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Text(
            TextConstant.Campaigns,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        body: campaignController.isLoading &&
                campaignController.campaignListModel == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : campaignController.campaignListModel!.data == null
                ? Center(
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: const NoDataFoundScreen()))
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        campaignController.campaignListModel!.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CampaignsListWidget(
                        model:
                            campaignController.campaignListModel!.data![index],
                      );
                    },
                  ),
      );
    });
  }
}
