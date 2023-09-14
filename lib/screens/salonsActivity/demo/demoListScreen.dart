import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmers/screens/salonsActivity/demo/demoListWidget.dart';

import '../../../constant/colorsConstant.dart';
import '../../../constant/route_helper.dart';
import '../../../constant/textConstant.dart';
import '../../../controllers/salonController.dart';
import '../../../model/salonDetailsModel.dart';

class DemoListScreen extends StatefulWidget {
  final SalonDetails model;

  const DemoListScreen({Key? key, required this.model}) : super(key: key);

  @override
  State<DemoListScreen> createState() => _DemoListScreenState();
}

class _DemoListScreenState extends State<DemoListScreen> {
  @override
  void initState() {
    super.initState();

    Get.find<SalonController>().getDemoList(widget.model.id!.toString());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalonController>(builder: (salonController) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: false,
          title: Text(
            TextConstant.demonstrate,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          actions: [
            Center(
              child: InkWell(
                onTap: () {
                  Get.toNamed(RouteHelper.getDemoRequestRoute(
                          widget.model.id.toString()))!
                      .then((value) => setState(() {
                            salonController
                                .getDemoList(widget.model.id!.toString());
                          }));

                  // Get.toNamed(
                  //   context,
                  //   AddDemoScreen.name,
                  //   arguments: {'salonId': widget.model.id!.toString()},
                  // ).then((_) => setState(() {
                  //       salonController
                  //           .getDemoList(widget.model.id!.toString());
                  //     }));
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => AddDemoScreen(
                  //           salonId: widget.model.id!.toString(),
                  //         )));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    TextConstant.addRequest,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 25),
            child: Column(
              children: [
                salonController.isLoading &&
                        salonController.demoListModel == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: salonController.demoListModel!.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return DemoListWidget(
                            model: salonController.demoListModel!.data![index],
                            salonId: widget.model.id.toString(),
                          );
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
