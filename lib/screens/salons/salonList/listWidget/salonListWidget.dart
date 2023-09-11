import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant/colorsConstant.dart';
import '../../../../constant/route_helper.dart';
import '../../../../model/salonRouteModel.dart';

class SalonListWidget extends StatefulWidget {
  final SalonsModel model;

  const SalonListWidget({Key? key, required this.model}) : super(key: key);

  @override
  State<SalonListWidget> createState() => _SalonListWidgetState();
}

class _SalonListWidgetState extends State<SalonListWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
            RouteHelper.getSalonDetailsRoute(widget.model.id.toString()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Row(
          children: [
            widget.model.image == ""
                ? Image.asset(
                    'assets/images/avatar.png',
                    height: 50,
                    width: 50,
                  )
                : Image.network(
                    widget.model.image!,
                    height: 50,
                    width: 50,
                  ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.model.name!,
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.model.address!,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: primaryColor),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 13,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${widget.model.distance!} Away',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
