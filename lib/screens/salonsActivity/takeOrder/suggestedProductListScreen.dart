import 'package:flutter/material.dart';

import '../../../constant/colorsConstant.dart';
import '../../../constant/textConstant.dart';
import '../../../model/productModel.dart';

class SuggestedProductListScreen extends StatefulWidget {
  final List<SuggestedProducts> suggestedProductsList;

  const SuggestedProductListScreen(
      {Key? key, required this.suggestedProductsList})
      : super(key: key);

  @override
  State<SuggestedProductListScreen> createState() =>
      _SuggestedProductListScreenState();
}

class _SuggestedProductListScreenState
    extends State<SuggestedProductListScreen> {
  bool isAddClick = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close)),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      TextConstant.suggestedProducts,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.suggestedProductsList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: kBackgroundColor,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 15),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      if (widget.suggestedProductsList[index].imageUrl != "")
                        Image.network(
                          widget.suggestedProductsList[index].imageUrl!,
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.suggestedProductsList[index].name!,
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '₹ ${widget.suggestedProductsList[index].price!}',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (!isAddClick)
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isAddClick = true;
                                      });
                                    },
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            color: primaryColor),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 35),
                                          child: Text(
                                            TextConstant.add.toUpperCase(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                if (isAddClick)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(Icons.add_circle_outline),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Text(
                                            '1',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Icon(Icons.remove_circle_outline),
                                      ],
                                    ),
                                  )
                              ],
                            ),
                          )
                        ],
                      ))
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
