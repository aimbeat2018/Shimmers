import 'dart:convert';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
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

  Future<Response> getTrfExecutivesList() async {
    return await apiClient.getData(AppConstants.getAllTrfExecutiveList);
  }

  /* Future<Response> storeTourRequest({TourRequestModel? tourRequestModel}) async {
    return await apiClient.postData(
        AppConstants.storetourrequest, jsonEncode(tourRequestModel!.toJson()));
  }*/

  Future<Response> storeTourRequest(
      {String? area,
      String? date,
      String? time,
      String? amount,
      String? userid,
      String? roleid,
      String? remark,
      String? purpose,
      String? tourid}) async {
    return await apiClient.postData(AppConstants.storetourrequest, {
      "area": area,
      "date": date,
      "time": time,
      "amount": amount,
      "user_id": userid,
      "role_id": roleid,
      "remark": remark,
      "purpose": purpose,
      "tour_req_id": tourid
    });
  }

  Future<Response> storeTourVisitDetails(
      {String? tour_visitid,
      String? area,
      String? date,
      String? time,
      String? role,
      String? name,
      String? contact,
      String? description}) async {
    return await apiClient.postData(AppConstants.storetourdvisitdetails, {
      "tour_visit_id": tour_visitid,
      "area": area,
      "date": date,
      "time": time,
      "role": role,
      "name": name,
      "contact": contact,
      "description": description
    });
  }

  Future<Response> deleteTourRequest({String? tour_reqid}) async {
    return await apiClient
        .postData(AppConstants.deletetourrequest, {"tour_req_id": tour_reqid});
  }

  Future<Response> getTourDetailsByID({String? tour_id}) async {
    return await apiClient
        .postData(AppConstants.gettourdetailsbyid, {"tour_req_id": tour_id});
  }

  Future<Response> getExecutiveTourRequestList({String? executive_id}) async {
    return await apiClient.postData(
        AppConstants.getExecutiveTourRequestList, {"user_id": executive_id});
  }

  Future<Response> updateTourRequestStatus(
      {String? tour_req_id,
      String? status,
      String? remark,
      XFile? attachment}) async {
    return await apiClient.postData(AppConstants.updateTourRequest, {
      "tour_req_id": tour_req_id,
      "status": status,
      "remark": remark,
      "attachment": attachment
    });
  }
}
