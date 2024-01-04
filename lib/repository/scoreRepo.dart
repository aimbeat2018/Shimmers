import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmers/constant/api/api_client.dart';
import 'package:shimmers/constant/app_constants.dart';

class ScoreRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  ScoreRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getemployeesScorecard(
      {String? user_id, String? from_date, String? to_date}) async {
    return await apiClient.postData(AppConstants.employeeScorecard,
        {'user_id': user_id, 'from_date': from_date, 'to_date': to_date});
  }

  Future<Response> getEmployeeActivityDetails(
      {String? emp_id,
      String? activityType,
      String? from_date,
      String? to_date}) async {
    return await apiClient.postData(AppConstants.employeedetailActivity, {
      'user_id': emp_id,
      'activity_type': activityType,
      'from_date': from_date,
      'to_date': to_date
    });
  }

  Future<Response> getEmployeeTargetDetails(
      {String? emp_id,
      String? activityType,
      String? from_date,
      String? to_date}) async {
    return await apiClient.postData(AppConstants.employeeTargetDetail, {
      'user_id': emp_id,
      'activity_type': activityType,
      'from_date': from_date,
      'to_date': to_date
    });
  }

  Future<Response> getEmployeeCampaignDetails(
      {String? emp_id,
      String? activityType,
      String? from_date,
      String? to_date}) async {
    return await apiClient.postData(AppConstants.employeeCampaignDetail, {
      'user_id': emp_id,
      'activity_type': activityType,
      'from_date': from_date,
      'to_date': to_date
    });
  }

  Future<Response> getSalonwiseCampaignDetails(
      {String? user_id,
      String? campaign_id,
      String? salon_id,
      String? from_date,
      String? to_date}) async {
    return await apiClient.postData(AppConstants.salonwiseCampaignDetails, {
      'user_id': user_id,
      'campaign_id': campaign_id,
      'salon_id': salon_id,
      'from_date': from_date,
      'to_date': to_date
    });
  }
  Future<Response> getLiveTrackingList() async {
    return await apiClient.getData(AppConstants.liveExecutivesList);
  }
}
