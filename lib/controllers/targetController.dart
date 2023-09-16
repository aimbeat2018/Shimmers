import 'package:get/get.dart';
import 'package:shimmers/model/distributorSalonListModel.dart';
import 'package:shimmers/model/employeeListModel.dart';
import 'package:shimmers/repository/TagetRepo.dart';

import '../constant/route_helper.dart';

class TargetController extends GetxController implements GetxService {
  final TargetRepo targetRepo;

  TargetController({required this.targetRepo});

  bool? _isLoading = false;

  bool get isLoading => _isLoading!;

  EmployeeListModel? employeeListModel;

  DistributorSalonListModel? distributorSalonListModel;

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

//
// Future<DistributorSalonListModel?> getDistributorSalonList({
//   String? latitude,
//   String? longitude,
// }) async {
//   _isLoading = true;
//   // update();
//   Response response = await distributorRepo.getDistributorSalonList(
//       latitude: latitude, longitude: longitude);
//
//   if (response.statusCode == 200) {
//     distributorSalonListModel =
//         DistributorSalonListModel.fromJson(response.body);
//   } else if (response.statusCode == 401) {
//     Get.offAllNamed(RouteHelper.getLoginRoute());
//   } else {
//     distributorSalonListModel = DistributorSalonListModel();
//   }
//   _isLoading = false;
//   update();
//   return distributorSalonListModel;
// }
}
