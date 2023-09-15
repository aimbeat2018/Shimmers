import 'dart:async';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/api/api_client.dart';
import '../constant/app_constants.dart';

class CampaignRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  CampaignRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getEmployeeCampaignList(String? employeeId) async {
    return await apiClient.postData(
        AppConstants.getEmployeeCampaignList, {"employee_id": employeeId});
  }

  Future<Response> getEmployeeCampaignResponse(String? campaignId) async {
    return await apiClient.postData(
        AppConstants.getEmployeeCampaignResponse, {"campaign_id": campaignId});
  }
}
