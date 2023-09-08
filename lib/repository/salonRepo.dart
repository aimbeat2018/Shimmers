import 'package:get/get_connect/http/src/response/response.dart';
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
}
