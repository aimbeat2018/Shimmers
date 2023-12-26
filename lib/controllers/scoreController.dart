import 'package:get/get.dart';
import 'package:shimmers/repository/scoreRepo.dart';

import '../constant/route_helper.dart';
import '../model/activityCountModel.dart';
import '../model/employeeActivityDetail.dart';
import '../model/employeeTargetDetail.dart';
import '../model/scoreCampaignModel.dart';
import '../model/userCampaignAnswerModel.dart';

class ScoreController extends GetxController implements GetxService {
  final ScoreRepo scoreRepo;
  ActivityCountModel? activityCountModel;
  EmployeeActivityDetail? employeeActivityDetail;
  EmployeeTargetDetail? employeeTargetDetail;
  ScoreCampaignModel? scoreCampaignModel;
  UserCampaignAnswerModel? userCampaignAnswerModel;
  bool? _isLoading = false;

  bool get isLoading => _isLoading!;

  ScoreController({required this.scoreRepo});

  Future<ActivityCountModel?> getEmployeeScorecard(
      {String? user_id,
      String? from_date,
      String? to_date,
      bool? isload}) async {
    if (isload!) {
      _isLoading = true;
      update();
    }
    Response response = await scoreRepo.getemployeesScorecard(
        user_id: user_id, from_date: from_date, to_date: to_date);

    if (response.statusCode == 200) {
      activityCountModel = ActivityCountModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      activityCountModel = ActivityCountModel();
    }
    _isLoading = false;
    update();
    return activityCountModel;
  }

  Future<EmployeeActivityDetail?> employeeactivityDetails(
      {String? user_id,
      String? activityType,
      String? fromDate,
      String? toDate}) async {
    _isLoading = true;
    Response response = await scoreRepo.getEmployeeActivityDetails(
        emp_id: user_id,
        activityType: activityType,
        from_date: fromDate,
        to_date: toDate);

    if (response.statusCode == 200) {
      employeeActivityDetail = EmployeeActivityDetail.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      employeeActivityDetail = EmployeeActivityDetail();
    }
    _isLoading = false;
    update();
    return employeeActivityDetail;
  }

  Future<EmployeeTargetDetail?> employeeTargetDetails(
      {String? user_id,
      String? activityType,
      String? fromDate,
      String? toDate}) async {
    _isLoading = true;
    Response response = await scoreRepo.getEmployeeTargetDetails(
        emp_id: user_id,
        activityType: activityType,
        from_date: fromDate,
        to_date: toDate);
    if (response.statusCode == 200) {
      employeeTargetDetail = EmployeeTargetDetail.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      employeeTargetDetail = EmployeeTargetDetail();
    }
    _isLoading = false;
    update();
    return employeeTargetDetail;
  }

  Future<ScoreCampaignModel?> scoreCampaignDetailsList(
      {String? user_id,
      String? activity_type,
      String? from_date,
      String? to_Date}) async {
    _isLoading = true;
    //  update();
    Response response = await scoreRepo.getEmployeeCampaignDetails(
        emp_id: user_id,
        activityType: activity_type,
        from_date: from_date,
        to_date: to_Date);
    if (response.statusCode == 200) {
      scoreCampaignModel = ScoreCampaignModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      scoreCampaignModel = ScoreCampaignModel();
    }
    _isLoading = false;
    update();
    return scoreCampaignModel;
  }

  Future<UserCampaignAnswerModel?> userCampaignAnswerList(
      {String? userid,
      String? campaignid,
      String? salonid,
      String? fromdate,
      String? todate}) async {
    _isLoading = true;
    Response response = await scoreRepo.getSalonwiseCampaignDetails(
        user_id: userid,
        campaign_id: campaignid,
        salon_id: salonid,
        from_date: fromdate,
        to_date: todate);
    if (response.statusCode == 200) {
      userCampaignAnswerModel = UserCampaignAnswerModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      userCampaignAnswerModel = UserCampaignAnswerModel();
    }
    _isLoading = false;
    update();
    return userCampaignAnswerModel;
  }
}
