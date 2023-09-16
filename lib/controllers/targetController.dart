import 'package:get/get.dart';
import 'package:shimmers/model/employeeListModel.dart';
import 'package:shimmers/repository/TagetRepo.dart';

import '../constant/route_helper.dart';
import '../model/productModel.dart';

class TargetController extends GetxController implements GetxService {
  final TargetRepo targetRepo;

  TargetController({required this.targetRepo});

  bool? _isLoading = false;
  bool? _isTargetLoading = false;

  bool get isLoading => _isLoading!;

  bool get isTargetLoading => _isTargetLoading!;

  EmployeeListModel? employeeListModel;

  ProductModel? productModel;

  Future<EmployeeListModel?> getEmployeeList() async {
    _isLoading = true;
    // update();
    Response response = await targetRepo.getEmployeeList();

    if (response.statusCode == 200) {
      employeeListModel = EmployeeListModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      employeeListModel = EmployeeListModel();
    }
    _isLoading = false;
    update();
    return employeeListModel;
  }

  Future<ProductModel?> getProducts() async {
    _isLoading = true;
    // update();
    Response response = await targetRepo.getProducts();

    if (response.statusCode == 200) {
      productModel = ProductModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      productModel = ProductModel();
    }
    _isLoading = false;
    update();
    return productModel;
  }
}
