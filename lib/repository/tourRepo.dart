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

  Future<Response> getApprovedHeadOfficeList() async {
    return await apiClient.getData(AppConstants.getApprovedTourRequestList);
  }

  Future<Response> getTrfExecutivesList() async {
    return await apiClient.getData(AppConstants.getAllTrfExecutiveList);
  }

  /* Future<Response> storeTourRequest({TourRequestModel? tourRequestModel}) async {
    return await apiClient.postData(
        AppConstants.storetourrequest, jsonEncode(tourRequestModel!.toJson()));
  }*/

  Future<Response> storeTourRequest(
      {String? name,
      String? travel_from,
      String? travel_to,
      String? dept_date,
      String? return_date,
      String? checkin_date,
      String? checkout_date,
      String? rsm_name,
      String? no_of_days,
      String? no_of_demos,
      String? user_id,
      String? role_id,
      String? remark,
      String? tourid}) async {
    return await apiClient.postData(AppConstants.storetourrequest, {
      "name": name,
      "travel_from": travel_from,
      "travel_to": travel_to,
      "dept_date": dept_date,
      "return_date": return_date,
      "checkin_date": checkin_date,
      "checkout_date": checkout_date,
      "rsm_name": rsm_name,
      "no_of_days": no_of_days,
      "no_of_demos": no_of_demos,
      "user_id": user_id,
      "role_id": role_id,
      "remark": remark,
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
  Future<Response> getVisitedTourList({String? tour_requestid}) async{
    return await apiClient.postData(AppConstants.getTourVisitDetailsById,{
      'tour_req_id':tour_requestid
    });
  }

  Future<Response> getExecutiveTourRequestList({String? executive_id}) async {
    return await apiClient.postData(
        AppConstants.getExecutiveTourRequestList, {"user_id": executive_id});
  }

  Future<Response> updateTourRequestStatus(
      {String? tour_req_id,
      String? status,
      String? remark}) async {
    return await apiClient.postData(AppConstants.updateTourRequest, {
      "tour_req_id": tour_req_id,
      "status": status,
      "remark": remark,
    });

  }

  Future<Response> updateTourRequestByHeadOfficer(
      {String? tour_req_id,
        String? remark,
        XFile? attachment}) async {
    return await apiClient.postMultipartData(AppConstants.updateTourReqByOfficer, {
      "tour_req_id": tour_req_id!,
      "office_remark": remark!,
    }, [
      MultipartBody('attachment', attachment!)
    ]);
  }
}
