import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmers/controllers/attendanceController.dart';
import 'package:shimmers/controllers/salonController.dart';
import 'package:shimmers/repository/attendanceRepo.dart';
import 'package:shimmers/repository/salonRepo.dart';

import '../controllers/authController.dart';
import '../repository/authRepo.dart';
import 'api/api_client.dart';
import 'app_constants.dart';

Future<void> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));

  // Repository

  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      AttendanceRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => SalonRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  // Controller
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => AttendanceController(attendanceRepo: Get.find()));
  Get.lazyPut(() => SalonController(salonRepo: Get.find()));
}
