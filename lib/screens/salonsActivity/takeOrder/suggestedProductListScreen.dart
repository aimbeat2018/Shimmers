import 'package:flutter/material.dart';

import '../../../constant/colorsConstant.dart';
import '../../../constant/textConstant.dart';
import '../../../model/cartModel.dart';
import '../../../model/productModel.dart';

class SuggestedProductListScreen extends StatefulWidget {
  final List<SuggestedProducts> suggestedProductsList;
  final List<CartModel> cartList;

  const SuggestedProductListScreen(
      {Key? key, required this.suggestedProductsList, required this.cartList})
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
                        Navigator.pop(context, widget.cartList);
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
                  InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.pop(context, widget.cartList);
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: primaryColor),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 35),
                        child: Text(
                          TextConstant.submit.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
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
                          height: 50,
                          width: 50,
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
                                widget.suggestedProductsList[index].quantity ==
                                        0
                                    ? InkWell(
                                        onTap: () {
                                          setState(() {
                                            widget.suggestedProductsList[index]
                                                .quantity = 1;
                                          });
                                          int calculated_price = widget
                                                  .suggestedProductsList[index]
                                                  .quantity! *
                                              int.parse(widget
                                                  .suggestedProductsList[index]
                                                  .price!);

                                          CartModel _cartModel = CartModel(
                                              productId: widget
                                                  .suggestedProductsList[index]
                                                  .id,
                                              image: widget
                                                  .suggestedProductsList[index]
                                                  .imageUrl,
                                              itemName: widget
                                                  .suggestedProductsList[index]
                                                  .name,
                                              quantity: widget
                                                  .suggestedProductsList[index]
                                                  .quantity,
                                              amountWithQty: calculated_price!,
                                              discountValue: 0,
                                              discountType: "",
                                              amount: int.parse(widget
                                                  .suggestedProductsList[index]
                                                  .price!),
                                              afterDiscountAmount: 0,
                                              itemSummary: "",
                                              standalon_discount: (widget
                                                  .suggestedProductsList[index]
                                                  .standalon_discount!));

                                          widget.cartList.add(_cartModel);
                                        },
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                                color: primaryColor),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 35),
                                              child: Text(
                                                TextConstant.add.toUpperCase(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if (widget
                                                      .cartList.isNotEmpty) {
                                                    for (var cartModel
                                                        in widget.cartList) {
                                                      if (cartModel.productId ==
                                                          widget
                                                              .suggestedProductsList[
                                                                  index]
                                                              .id) {
                                                        if (widget
                                                                .suggestedProductsList[
                                                                    index]
                                                                .quantity! ==
                                                            1) {
                                                          widget.cartList
                                                              .remove(
                                                                  cartModel);
                                                          widget
                                                              .suggestedProductsList[
                                                                  index]
                                                              .quantity = 0;
                                                        } else {
                                                          widget
                                                                  .suggestedProductsList[
                                                                      index]
                                                                  .quantity !=
                                                              widget
                                                                      .suggestedProductsList[
                                                                          index]
                                                                      .quantity! -
                                                                  1;

                                                          cartModel.quantity =
                                                              widget
                                                                  .suggestedProductsList[
                                                                      index]
                                                                  .quantity!;

                                                          int calculated_price = cartModel
                                                                  .amountWithQty! -
                                                              int.parse(widget
                                                                  .suggestedProductsList[
                                                                      index]
                                                                  .price!);

                                                          cartModel
                                                                  .amountWithQty =
                                                              calculated_price;
                                                        }
                                                      }
                                                    }
                                                  }
                                                });
                                              },
                                              child: Container(
                                                height: 22,
                                                width: 22,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      width: 1,
                                                      color: primaryColor),
                                                  color: primaryColor,
                                                ),
                                                alignment: Alignment.center,
                                                child: Icon(
                                                  Icons.remove,
                                                  size: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Text(
                                                widget
                                                    .suggestedProductsList[
                                                        index]
                                                    .quantity!
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if (widget
                                                      .cartList.isNotEmpty) {
                                                    for (var cartModel
                                                        in widget.cartList) {
                                                      if (cartModel.productId ==
                                                          widget
                                                              .suggestedProductsList[
                                                                  index]
                                                              .id) {
                                                        widget
                                                            .suggestedProductsList[
                                                                index]
                                                            .quantity = widget
                                                                .suggestedProductsList[
                                                                    index]
                                                                .quantity! +
                                                            1;

                                                        cartModel.quantity = widget
                                                            .suggestedProductsList[
                                                                index]
                                                            .quantity!;

                                                        int calculated_price = widget
                                                                .suggestedProductsList[
                                                                    index]
                                                                .quantity! *
                                                            int.parse(widget
                                                                .suggestedProductsList[
                                                                    index]
                                                                .price!);

                                                        cartModel
                                                                .amountWithQty =
                                                            calculated_price;
                                                      }
                                                    }
                                                  }
                                                });
                                              },
                                              child: Container(
                                                height: 22,
                                                width: 22,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      width: 1,
                                                      color: primaryColor),
                                                  color: primaryColor,
                                                ),
                                                alignment: Alignment.center,
                                                child: Icon(
                                                  Icons.add,
                                                  size: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
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
