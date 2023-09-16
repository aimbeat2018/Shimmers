import 'package:flutter/material.dart';
import 'package:shimmers/model/productModel.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/globalFunction.dart';
import '../../constant/textConstant.dart';

class SetProductListWidget extends StatefulWidget {
  final ProductData productData;

  const SetProductListWidget({Key? key, required this.productData})
      : super(key: key);

  @override
  State<SetProductListWidget> createState() => _EmployeeListWidgetState();
}

class _EmployeeListWidgetState extends State<SetProductListWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
      child: Row(
        children: [
          widget.productData.imageUrl == ""
              ? Image.asset(
                  'assets/images/avatar.png',
                  height: 50,
                  width: 50,
                )
              : Image.network(
                  widget.productData.imageUrl!,
                  height: 50,
                  width: 50,
                ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.productData.name!,
                style: const TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                ' ₹ ${widget.productData.price!}',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: 40,
                child: TextFormField(
                  style: const TextStyle(fontSize: 14),
                  maxLines: 1,
                  decoration:
                      GlobalFunctions.getInputDecoration(TextConstant.target),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      widget.productData.target = int.parse(value);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
    ;
  }
}
