import 'package:get/get.dart';
import 'package:shimmers/model/productModel.dart';
import 'package:shimmers/repository/cartRepo.dart';

import '../model/cartModel.dart';

class CartController extends GetxController implements GetxService {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  List<CartModel>? _cartList;

  List<CartModel>? get cartList => _cartList!;

  List<CartModel> toResponseList(List<dynamic> data) {
    List<CartModel> value = <CartModel>[];
    for (var element in data) {
      value.add(CartModel.fromJson(element));
    }
    return value ?? List<CartModel>.empty();
  }

  void getCartData() {
    _cartList = [];
    _cartList!.addAll(cartRepo.getCartList() as Iterable<CartModel>);
  }

  void addToCart(CartModel? cartModel, int? index) {
    if (index != null && index != -1) {
      _cartList!.replaceRange(index, index + 1, [cartModel!]);
    } else {
      _cartList!.add(cartModel!);
    }
    cartRepo.addToCartList(_cartList!);
    update();
  }

  void setQuantity(bool isIncrement, CartModel? cart) {
    int index = _cartList!.indexOf(cart!);
    if (isIncrement) {
      _cartList![index].quantity = _cartList![index].quantity! + 1;
    } else {
      _cartList![index].quantity = _cartList![index].quantity! - 1;
    }
    cartRepo.addToCartList(_cartList!);

    update();
  }

  void removeFromCart(int index) {
    _cartList!.removeAt(index);
    cartRepo.addToCartList(_cartList!);
    update();
  }

  void clearCartList() {
    _cartList = [];
    cartRepo.addToCartList(_cartList!);
    update();
  }

  int isExistInCart(int? productID, bool? isUpdate, int? cartIndex) {
    for (int index = 0; index < _cartList!.length; index++) {
      if (_cartList![index].productId == productID) {
        if ((isUpdate! && index == cartIndex)) {
          return -1;
        } else {
          return index;
        }
      }
    }
    return -1;
  }

  int getCartIndex(ProductData? product) {
    for (int index = 0; index < _cartList!.length; index++) {
      if (_cartList![index].productId == product!.id) {
        return index;
      }
    }
    return 0;
  }
}
