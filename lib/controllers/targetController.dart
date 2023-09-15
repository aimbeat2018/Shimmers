import 'package:get/get.dart';
import 'package:shimmers/model/distributorListModel.dart';
import 'package:shimmers/model/distributorSalonListModel.dart';
import 'package:shimmers/repository/TagetRepo.dart';

class TargetController extends GetxController implements GetxService {
  final TargetRepo targetRepo;

  TargetController({required this.targetRepo});

  bool? _isLoading = false;

  bool get isLoading => _isLoading!;

  DistributorListModel? distributorListModel;

  DistributorSalonListModel? distributorSalonListModel;

// Future<DistributorListModel?> getDistributorList() async {
//   _isLoading = true;
//   // update();
//   Response response = await distributorRepo.getDistributorList();
//
//   if (response.statusCode == 200) {
//     distributorListModel = DistributorListModel.fromJson(response.body);
//   } else if (response.statusCode == 401) {
//     Get.offAllNamed(RouteHelper.getLoginRoute());
//   } else {
//     distributorListModel = DistributorListModel();
//   }
//   _isLoading = false;
//   update();
//   return distributorListModel;
// }
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
