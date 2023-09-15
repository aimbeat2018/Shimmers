import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/api/api_client.dart';
import '../constant/app_constants.dart';

class AttendanceRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AttendanceRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getAttendanceStatus() async {
    return await apiClient.getData(AppConstants.attendanceStatus);
  }

  Future<Response> getLeaveList() async {
    return await apiClient.getData(AppConstants.getLeaveList);
  }

  Future<Response> getLeaveTypeList() async {
    return await apiClient.getData(AppConstants.getLeaveTypeList);
  }

  Future<Response> employeePunchIn(
      {String? lat,
      String? long,
      String? workingFrom,
      String? workFromType,
      String? address}) async {
    return await apiClient.postData(AppConstants.employeePunchIn, {
      "lat": lat,
      "long": long,
      "working_from": workingFrom,
      "work_from_type": workFromType,
      "address": address
    });
  }

  Future<Response> employeePunchOut(
      {String? lat, String? long, String? id, String? address}) async {
    return await apiClient.postData(AppConstants.employeePunchOut,
        {"lat": lat, "long": long, "id": id, "address": address});
  }

  Future<Response> getAttendanceHistory({int? month, int? year}) async {
    return await apiClient.postData(AppConstants.attendanceHistory, {
      "month": month.toString(),
      "year": year.toString(),
    });
  }

  Future<Response> applyForLeave(
      {String? fromDate,
      String? toDate,
      String? reason,
      String? leaveType,
      String? duration}) async {
    return await apiClient.postData(AppConstants.applyForLeave, {
      "from_date": fromDate,
      "to_date": toDate,
      "reason": reason,
      "leave_type": leaveType,
      "duration": duration,
    });
  }
}
