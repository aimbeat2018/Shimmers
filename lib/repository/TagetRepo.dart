import 'dart:async';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/api/api_client.dart';
import '../constant/app_constants.dart';

class TargetRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  TargetRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getEmployeeList() async {
    return await apiClient.getData(AppConstants.getEmployeeList);
  }

  Future<Response> getDistributorSalonList({
    String? latitude,
    String? longitude,
  }) async {
    return await apiClient.postData(
      AppConstants.getDistributorSalonList,
      {"latitude": latitude, "longitude": longitude},
    );
  }
}
