import 'package:get/get.dart';
import 'package:shimmers/model/salonCategoryModel.dart';
import 'package:shimmers/model/salonRouteModel.dart';
import 'package:shimmers/repository/salonRepo.dart';

import '../constant/route_helper.dart';

class SalonController extends GetxController implements GetxService {
  final SalonRepo salonRepo;

  SalonController({required this.salonRepo});

  SalonRouteModel? salonRouteModel;

  SalonCategoryModel? salonCategoryModel;

  bool? _isLoading = false;

  bool get isLoading => _isLoading!;

  Future<SalonRouteModel?> getSalonRouteList(
      {String? latitude, String? longitude, String? type}) async {
    _isLoading = true;
    update();
    Response response = await salonRepo.getRouteList(
        latitude: latitude, longitude: longitude, type: type);

    if (response.statusCode == 200) {
      salonRouteModel = SalonRouteModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      salonRouteModel = SalonRouteModel();
    }
    _isLoading = false;
    update();
    return salonRouteModel;
  }

  Future<SalonCategoryModel?> getSalonCategory() async {
    _isLoading = true;
    // update();
    Response response = await salonRepo.getSalonCategory();

    if (response.statusCode == 200) {
      salonCategoryModel = SalonCategoryModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      salonCategoryModel = SalonCategoryModel();
    }
    _isLoading = false;
    update();
    return salonCategoryModel;
  }
}
