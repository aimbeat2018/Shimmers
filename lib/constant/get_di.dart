import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmers/controllers/attendanceController.dart';
import 'package:shimmers/controllers/campaignController.dart';
import 'package:shimmers/controllers/cartController.dart';
import 'package:shimmers/controllers/distributorController.dart';
import 'package:shimmers/controllers/salonController.dart';
import 'package:shimmers/controllers/targetController.dart';
import 'package:shimmers/repository/TagetRepo.dart';
import 'package:shimmers/repository/attendanceRepo.dart';
import 'package:shimmers/repository/campaignRepo.dart';
import 'package:shimmers/repository/cartRepo.dart';
import 'package:shimmers/repository/distributorRepo.dart';
import 'package:shimmers/repository/salonRepo.dart';

import '../controllers/authController.dart';
import '../controllers/tourController.dart';
import '../repository/authRepo.dart';
import '../repository/tourRepo.dart';
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
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      DistributorRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => CampaignRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => TargetRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => TourRepo(apiClient: Get.find(),sharedPreferences: Get.find()));


  // Controller
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => AttendanceController(attendanceRepo: Get.find()));
  Get.lazyPut(() => SalonController(salonRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => DistributorController(distributorRepo: Get.find()));
  Get.lazyPut(() => CampaignController(campaignRepo: Get.find()));
  Get.lazyPut(() => TargetController(targetRepo: Get.find()));
  Get.lazyPut(() => TourController(tourRepo: Get.find()));

}
