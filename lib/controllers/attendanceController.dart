import 'package:get/get.dart';
import 'package:shimmers/model/attendanceHistoryModel.dart';
import 'package:shimmers/model/attendanceStatusModel.dart';
import 'package:shimmers/model/leaveListModel.dart';
import 'package:shimmers/repository/attendanceRepo.dart';

import '../constant/route_helper.dart';
import '../model/leaveTypeModel.dart';

class AttendanceController extends GetxController implements GetxService {
  final AttendanceRepo attendanceRepo;

  AttendanceController({required this.attendanceRepo});

  AttendanceHistoryModel? attendanceHistoryModel;

  AttendanceStatusModel? attendanceStatusModel;

  LeaveListModel? leaveListModel;

  LeaveTypeModel? leaveTypeModel;

  String? punchInMsg;

  bool? _isLoading = false;

  bool get isLoading => _isLoading!;

  Future<AttendanceHistoryModel?> getAttendanceHistory(
      int month, int year) async {
    _isLoading = true;
    update();
    Response response =
        await attendanceRepo.getAttendanceHistory(month: month, year: year);

    if (response.statusCode == 200) {
      attendanceHistoryModel = AttendanceHistoryModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      attendanceHistoryModel = AttendanceHistoryModel();
    }
    _isLoading = false;
    update();
    return attendanceHistoryModel;
  }

  Future<LeaveTypeModel?> getLeaveTypeList() async {
    _isLoading = true;
    // update();
    Response response = await attendanceRepo.getLeaveTypeList();

    if (response.statusCode == 200) {
      leaveTypeModel = LeaveTypeModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      leaveTypeModel = LeaveTypeModel();
    }
    _isLoading = false;
    update();
    return leaveTypeModel;
  }

  Future<LeaveListModel?> getLeaveList() async {
    _isLoading = true;
    // update();
    Response response = await attendanceRepo.getLeaveList();

    if (response.statusCode == 200) {
      leaveListModel = LeaveListModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      leaveListModel = LeaveListModel();
    }
    _isLoading = false;
    update();
    return leaveListModel;
  }

  Future<AttendanceStatusModel?> getAttendanceStatus() async {
    _isLoading = true;
    update();
    Response response = await attendanceRepo.getAttendanceStatus();

    if (response.statusCode == 200) {
      attendanceStatusModel = AttendanceStatusModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      attendanceStatusModel = AttendanceStatusModel();
    }
    _isLoading = false;
    update();
    return attendanceStatusModel;
  }

  Future<String?> employeePunchIn(
      {String? lat,
      String? long,
      String? workingFrom,
      String? workFromType,
      String? address}) async {
    _isLoading = true;
    update();

    Response response = await attendanceRepo.employeePunchIn(
        lat: lat,
        long: long,
        workFromType: workFromType,
        workingFrom: workingFrom,
        address: address);

    if (response.statusCode == 200) {
      punchInMsg = response.body['message'];
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      punchInMsg = "";
    }

    _isLoading = false;
    update();
    return punchInMsg;
  }

  Future<String?> employeePunchOut(
      {String? lat, String? long, String? id, String? address}) async {
    _isLoading = true;
    update();

    Response response = await attendanceRepo.employeePunchOut(
        lat: lat, long: long, id: id, address: address);

    if (response.statusCode == 200) {
      punchInMsg = response.body['message'];
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      punchInMsg = "";
    }

    _isLoading = false;
    update();
    return punchInMsg;
  }

  Future<String?> applyForLeave(
      {String? fromDate,
      String? toDate,
      String? reason,
      String? leaveType,
      String? duration}) async {
    _isLoading = true;
    update();
    Response response = await attendanceRepo.applyForLeave(
        fromDate: fromDate,
        toDate: toDate,
        reason: reason,
        leaveType: leaveType,
        duration: duration);

    if (response.statusCode == 200) {
      punchInMsg = response.body['message'];
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      punchInMsg = "";
    }
    _isLoading = false;
    update();
    return punchInMsg;
  }
}
