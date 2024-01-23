import 'dart:convert';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmers/model/placeOrderModel.dart';
import 'package:shimmers/model/submitCampaignRequestmodel.dart';

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

  Future<Response> getNonDeliveredOrderList() async {
    return await apiClient.getData(AppConstants.getNondeliveredOrderList);
  }

  Future<Response> getNotApprovedOrderList() async {
    return await apiClient.getData(AppConstants.getnotApprovedOrderList);
  }

  Future<Response> updateOrderStatus({String? orderid, String? status}) async {
    return await apiClient.postData(AppConstants.changeOrderStatus,
        {'order_id': orderid, 'status': status});
  }

  Future<Response> updateOrderApproval(
      {String? order_id, String? status}) async {
    return await apiClient.postData(AppConstants.changeOrderApprovalStatus,
        {'order_id': order_id, 'approval_status': status});
  }

  Future<Response> getProductByOrderID({String? orderid}) async {
    return await apiClient
        .postData(AppConstants.viewProductDetails, {'order_id': orderid});
  }

  Future<Response> getFeedbackPurpose() async {
    return await apiClient.getData(AppConstants.getFeedbackPurpose);
  }

  Future<Response> getSalonCategory() async {
    return await apiClient.getData(AppConstants.salonCategory);
  }

  Future<Response> getEmpRouteList({String? key}) async {
    return await apiClient.postData(AppConstants.routeList, {"key": key});

  }

  Future<Response> getUnitType() async {
    return await apiClient.getData(AppConstants.getUnitType);
  }

  Future<Response> getProducts() async {
    return await apiClient.getData(AppConstants.getProducts);
  }

  Future<Response> getCampaignList() async {
    return await apiClient.getData(AppConstants.getCampaignsList);
  }

  Future<Response> getCampaignQuestionList({String? campaignId}) async {
    return await apiClient.postData(
        AppConstants.getCampaignsQuestionList, {"campaign_id": campaignId});
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
      String? is_on_tour,
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
      "longitude": longitude!,
      "is_on_tour": is_on_tour!,
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

  Future<Response> getDemoList({String? salonId}) async {
    return await apiClient
        .postData(AppConstants.getDemoList, {"salon_id": salonId});
  }

  Future<Response> takeSalonNote({String? note, String? salonId,String? is_on_tour}) async {
    return await apiClient
        .postData(AppConstants.takeNotes, {"salon_id": salonId, "note": note,"is_on_tour":is_on_tour});
  }

  Future<Response> collectPayment(
      {String? paymentMode,
      String? salonId,
      String? referenceNumber,
      String? amount,
      String? is_on_tour,
      XFile? image}) async {
    return await apiClient.postMultipartData(AppConstants.collectPayment, {
      "salon_id": salonId!,
      "payment_mode": paymentMode!,
      "reference_number": referenceNumber!,
      "amount": amount!,
      "is_on_tour":is_on_tour!,
    }, [
      MultipartBody('image', image!)
    ]);
  }

  Future<Response> addFeedback(
      {String? feedbackTypeId,
      String? salonId,
      String? rating,
      String? remark,
      String? latitude,
      String? longitude,
      String? is_on_tour,
      XFile? image}) async {
    return await apiClient.postMultipartData(AppConstants.addFeedback, {
      "salon_id": salonId!,
      "feedback_type_id": feedbackTypeId!,
      "rating": rating!,
      "remark": remark!,
      "latitude": latitude!,
      "longitude": longitude!,
      "is_on_tour":is_on_tour!,
    }, [
      MultipartBody('image', image!)
    ]);
  }

  Future<Response> placeOrder(PlaceOrderModel? model) async {
    return await apiClient.postBodyData(
        AppConstants.placeOrder, jsonEncode(model!.toJson()));
  }

  Future<Response> submitCampaignData(SubmitCampaignRequestModel? model) async {
    // print(jsonEncode(model!.toJson()));
    return await apiClient.postBodyData(
        AppConstants.storeCampaignResponse, jsonEncode(model!.toJson()));
  }

  Future<Response> addDemoRequest(
      {String? date,
      String? time,
      String? requirement,
      String? salonId,
      String? is_on_tour}) async {
    return await apiClient.postData(AppConstants.addDemoRequest, {
      "salon_id": salonId,
      "date": date,
      "time": time,
      "requirement": requirement,
      "is_on_tour":is_on_tour
    });
  }

  Future<Response> salonWisePunchIn(
      {String? salonid, String? lat, String? long, String? address}) async {
    return await apiClient.postData(AppConstants.salonwiseLogin,
        {"salon_id": salonid, "lat": lat, "long": long, "address": address});
  }

  Future<bool> setonTour(String onTour) async {
    return await sharedPreferences.setString(AppConstants.onTour, onTour);
  }

  String getonTour() {
    return sharedPreferences.getString(AppConstants.onTour) ?? "";
  }
}
