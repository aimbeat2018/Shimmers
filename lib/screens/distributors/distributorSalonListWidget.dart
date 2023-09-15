import 'package:flutter/material.dart';
import 'package:shimmers/screens/salons/salonDetails/salonDetailsScreen.dart';

import '../../../../constant/colorsConstant.dart';
import '../../model/distributorSalonListModel.dart';

class DistributorSalonListWidget extends StatefulWidget {
  final Salons model;

  const DistributorSalonListWidget({Key? key, required this.model})
      : super(key: key);

  @override
  State<DistributorSalonListWidget> createState() =>
      _DistributorSalonListWidgetState();
}

class _DistributorSalonListWidgetState
    extends State<DistributorSalonListWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SalonDetailsScreen(
                  salonId: widget.model.id!.toString(),
                )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
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
              alignment: Alignment.bottomRight,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.grey,
                      size: 13,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${widget.model.distance!} Away',
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                          fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
