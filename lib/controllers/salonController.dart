import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmers/model/employeeRouteListModel.dart';
import 'package:shimmers/model/salonCategoryModel.dart';
import 'package:shimmers/model/salonDetailsModel.dart';
import 'package:shimmers/model/salonRouteModel.dart';
import 'package:shimmers/repository/salonRepo.dart';

import '../constant/route_helper.dart';

class SalonController extends GetxController implements GetxService {
  final SalonRepo salonRepo;

  SalonController({required this.salonRepo});

  SalonRouteModel? salonRouteModel;

  SalonCategoryModel? salonCategoryModel;

  EmployeeRouteListModel? employeeRouteListModel;

  SalonDetailsModel? salonDetailsModel;

  bool? _isLoading = false;
  String? salonAddMessage;

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

  Future<EmployeeRouteListModel?> getEmpRouteList() async {
    _isLoading = true;
    // update();
    Response response = await salonRepo.getEmpRouteList();

    if (response.statusCode == 200) {
      employeeRouteListModel = EmployeeRouteListModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      employeeRouteListModel = EmployeeRouteListModel();
    }
    _isLoading = false;
    update();
    return employeeRouteListModel;
  }

  Future<SalonDetailsModel?> getSalonDetails(String? salonId) async {
    _isLoading = true;
    // update();
    Response response = await salonRepo.getSalonDetails(salonId: salonId);

    if (response.statusCode == 200) {
      salonDetailsModel = SalonDetailsModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      salonDetailsModel = SalonDetailsModel();
    }
    _isLoading = false;
    update();
    return salonDetailsModel;
  }

  Future<String?> addSalon(
      {String? name,
      String? email,
      String? password,
      String? mobile,
      String? location_id,
      String? address,
      String? shipping_address,
      String? postal_code,
      String? state,
      String? city,
      String? number,
      String? owner_name,
      String? sub_category_id,
      String? gst_number,
      String? country,
      String? salon_type,
      String? latitude,
      String? longitude,
      XFile? image}) async {
    _isLoading = true;
    update();
    Response response = await salonRepo.addSalon(
        name: name,
        email: email,
        password: password,
        mobile: mobile,
        longitude: longitude,
        location_id: location_id,
        address: address,
        shipping_address: shipping_address,
        postal_code: postal_code,
        state: state,
        city: city,
        number: number,
        owner_name: owner_name,
        sub_category_id: sub_category_id,
        gst_number: gst_number,
        country: country,
        salon_type: salon_type,
        latitude: latitude,
        image: image);

    if (response.statusCode == 200) {
      salonAddMessage = response.body['message'];
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      salonAddMessage = "";
    }
    _isLoading = false;
    update();
    return salonAddMessage;
  }

  Future<String?> updateSalonType({String? salonId, String? salonType}) async {
    _isLoading = true;
    update();
    Response response =
        await salonRepo.updateSalonType(salonId: salonId, salonType: salonType);

    if (response.statusCode == 200) {
      salonAddMessage = response.body['message'];
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      salonAddMessage = "";
    }
    _isLoading = false;
    update();
    return salonAddMessage;
  }
}
