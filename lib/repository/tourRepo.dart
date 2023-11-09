import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/api/api_client.dart';
import '../constant/app_constants.dart';

class TourRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  TourRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getTourRequestList() async {
    return await apiClient.getData(AppConstants.gettourrequestlist);
  }
}
