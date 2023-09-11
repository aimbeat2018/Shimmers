import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/api/api_client.dart';
import '../constant/app_constants.dart';

class SalonRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  SalonRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getRouteList(
      {String? latitude, String? longitude, String? type}) async {
    return await apiClient.postData(AppConstants.salonRouteList, {
      "type": type,
      "latitude": latitude,
      "longitude": longitude,
    });
  }

  Future<Response> getSalonCategory() async {
    return await apiClient.getData(AppConstants.salonCategory);
  }

  Future<Response> getEmpRouteList() async {
    return await apiClient.getData(AppConstants.routeList);
  }

  Future<Response> addSalon(
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
    return await apiClient.postMultipartData(AppConstants.addSalon, {
      "name": name!,
      "email": email!,
      "password": password!,
      "mobile": mobile!,
      "location_id": location_id!,
      "address": address!,
      "shipping_address": shipping_address!,
      "postal_code": postal_code!,
      "state": state!,
      "city": city!,
      "number": number!,
      "owner_name": owner_name!,
      "sub_category_id": sub_category_id!,
      "gst_number": gst_number!,
      "country": country!,
      "salon_type": salon_type!,
      "latitude": latitude!,
      "longitude": longitude!
    }, [
      MultipartBody('image', image!)
    ]);
  }

  Future<Response> getSalonDetails({String? salonId}) async {
    return await apiClient
        .postData(AppConstants.viewSalonDetails, {"salon_id": salonId!});
  }

  Future<Response> updateSalonType({String? salonType, String? salonId}) async {
    return await apiClient.postData(
        AppConstants.updateSalonType, {"salon_id": salonId, "type": salonType});
  }
}
