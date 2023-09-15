import 'package:flutter/material.dart';
import 'package:shimmers/screens/distributors/distributorWiseSalonScreen.dart';

import '../../../../constant/colorsConstant.dart';
import '../../model/distributorListModel.dart';

class DistributorListWidget extends StatefulWidget {
  final DistributorData model;

  const DistributorListWidget({Key? key, required this.model})
      : super(key: key);

  @override
  State<DistributorListWidget> createState() => _DistributorListWidgetState();
}

class _DistributorListWidgetState extends State<DistributorListWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DistributorWiseSalonScreen(
                  distributorName: widget.model.name!,
                  id: widget.model.id!.toString(),
                )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
        child: Row(
          children: [
            // Center(
            //   child: SizedBox(
            //     height: 60,
            //     width: 60,
            //     child: CircleAvatar(
            //       backgroundColor: Colors.transparent,
            //       foregroundImage: AssetImage(
            //         'assets/images/distribution.png',
            //       ),
            //     ),
            //   ),
            // ),
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
            // Align(
            //   alignment: Alignment.bottomRight,
            //   child: Padding(
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8),
            //     child: Row(
            //       mainAxisSize: MainAxisSize.min,
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         const Icon(
            //           Icons.location_on,
            //           color: Colors.grey,
            //           size: 13,
            //         ),
            //         const SizedBox(
            //           width: 5,
            //         ),
            //         Text(
            //           '5 Km Away',
            //           style: const TextStyle(
            //               color: Colors.grey,
            //               fontSize: 11,
            //               fontWeight: FontWeight.normal),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
