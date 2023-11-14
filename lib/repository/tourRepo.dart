import 'dart:convert';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmers/model/TourRequestModel.dart';

import '../constant/api/api_client.dart';
import '../constant/app_constants.dart';

class TourRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  TourRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getTourRequestList() async {
    return await apiClient.getData(AppConstants.gettourrequestlist);
  }

  /* Future<Response> storeTourRequest({TourRequestModel? tourRequestModel}) async {
    return await apiClient.postData(
        AppConstants.storetourrequest, jsonEncode(tourRequestModel!.toJson()));
  }*/

  Future<Response> storeTourRequest(
      {String? area, String? date, String? time, String? amount, String? userid, String? roleid, String? remark, String? purpose, String? tourid}) async {
    return await apiClient.postData(
        AppConstants.storetourrequest, {"area":area,
      "date": date,
      "time": time,
      "amount": amount,
      "user_id": userid,
      "role_id": roleid,
      "remark": remark,
      "purpose": purpose,
      "tour_req_id":tourid
    });
  }

  Future<Response> deleteTourRequest({String? tour_reqid}) async {
    return await apiClient
        .postData(AppConstants.deletetourrequest, {"tour_req_id": tour_reqid});
  }

  Future<Response> getTourDetailsByID({String? tour_id}) async {
    return await apiClient.postData(
        AppConstants.gettourdetailsbyid, {"tour_req_id": tour_id});
  }
}
