import 'dart:convert';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmers/model/TourRequestModel.dart';

import '../constant/api/api_client.dart';
import '../constant/app_constants.dart';
import '../model/addExpensesModel.dart';
import '../model/submitTourModel.dart';
import '../model/totalExpensesModel.dart';

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

  Future<Response> getCommPhaseList() async {
    return await apiClient.getData(AppConstants.getCommunicationPhaseList);
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
      "no_of_days": no_of_days,
      "no_of_demos": no_of_demos,
      "user_id": user_id,
      "role_id": role_id,
      "remark": remark,
      "tour_req_id": tourid
    });
  }

  Future<Response> storeTourVisitDetails(
      SubmitTourModel? submitTourModel) async {
    return await apiClient.postBodyData(AppConstants.storetourdvisitdetails,
        jsonEncode(submitTourModel!.toJson()));
  }

  Future<Response> deleteTourRequest({String? tour_reqid}) async {
    return await apiClient
        .postData(AppConstants.deletetourrequest, {"tour_req_id": tour_reqid});
  }

  Future<Response> getTourDetailsByID({String? tour_id}) async {
    return await apiClient
        .postData(AppConstants.gettourdetailsbyid, {"tour_req_id": tour_id});
  }

  Future<Response> getVisitedTourList({String? tour_requestid}) async {
    return await apiClient.postData(
        AppConstants.getTourVisitDetailsById, {'tour_req_id': tour_requestid});
  }

  Future<Response> getExecutiveTourRequestList({String? executive_id}) async {
    return await apiClient.postData(
        AppConstants.getExecutiveTourRequestList, {"user_id": executive_id});
  }

  Future<Response> getSalonListByKey({String? key}) async {
    return await apiClient.postData(AppConstants.salonListByKey, {"key": key});
  }

  Future<Response> updateTourRequestStatus(
      {String? tour_req_id, String? status, String? remark}) async {
    return await apiClient.postData(AppConstants.updateTourRequest, {
      "tour_req_id": tour_req_id,
      "status": status,
      "remark": remark,
    });
  }

  Future<Response> updateTourRequestByHeadOfficer(
      {String? tour_req_id, String? remark, XFile? attachment}) async {
    return await apiClient
        .postMultipartData(AppConstants.updateTourReqByOfficer, {
      "tour_req_id": tour_req_id!,
      "office_remark": remark!,
    }, [
      MultipartBody('attachment', attachment!)
    ]);
  }

  Future<Response> storeExpenses({
    String? expenses_id,
    String? user_id,
    String? date,
    String? area,
    String? kilometer,
    String? da,
    String? ta,
    String? hotel,
    String? misc_other,
    String? total,
    String? remark,
    XFile? attachment
  }) async {
    return await apiClient.postMultipartData(
        AppConstants.addExpenses, {
          'expenses_id':expenses_id!,
      'user_id':user_id!,
      'date':date!,
      'area':area!,
      'kilometer':kilometer!,
      'da':da!,
      'ta':ta!,
      'hotel':hotel!,
      'misc_other':misc_other!,
      'total':total!,
      'remark':remark!,
    }, [
      MultipartBody('attachment', attachment!)
    ]);
  }

  Future<Response> getExpensesList() async {
    return await apiClient.getData(
      AppConstants.getExpenseList,
    );
  }

  Future<Response> deleteExpenses({String? expenses_id}) async {
    return await apiClient
        .postData(AppConstants.deleteExpenses, {'expenses_id': expenses_id});
  }
  Future<Response> expensesDetailsByid({String? expenses_id}) async {
    return await apiClient.postData(AppConstants.expenseDetailsById, {'expenses_id': expenses_id});
  }
}
