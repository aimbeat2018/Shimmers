import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/api/api_client.dart';
import '../constant/app_constants.dart';
import '../model/setTargetModel.dart';

class TargetRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  TargetRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getEmployeeList() async {
    return await apiClient.getData(AppConstants.getEmployeeList);
  }

  Future<Response> getProducts() async {
    return await apiClient.getData(AppConstants.getProducts);
  }

  Future<Response> submitProductTarget(SetTargetModel? setTargetModel) async {
    return await apiClient.postBodyData(AppConstants.assignEmployeeTarget,jsonEncode(setTargetModel!.toJson()));
  }
}
