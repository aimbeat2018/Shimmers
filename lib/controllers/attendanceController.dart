import 'package:get/get.dart';
import 'package:shimmers/model/attendanceHistoryModel.dart';
import 'package:shimmers/model/attendanceStatusModel.dart';
import 'package:shimmers/repository/attendanceRepo.dart';

import '../constant/route_helper.dart';

class AttendanceController extends GetxController implements GetxService {
  final AttendanceRepo attendanceRepo;

  AttendanceController({required this.attendanceRepo});

  AttendanceHistoryModel? attendanceHistoryModel;

  AttendanceStatusModel? attendanceStatusModel;

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
      punchInMsg = response.body.toString();
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
      punchInMsg = response.body.toString();
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
