import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmers/model/ExeTourDetailModel.dart';
import 'package:shimmers/model/TourRequestModel.dart';
import 'package:shimmers/model/commPhaseModel.dart';
import 'package:shimmers/model/tourRequestListmodel.dart';
import 'package:shimmers/model/tourdetailsByIdModel.dart';
import 'package:shimmers/repository/tourRepo.dart';

import '../constant/route_helper.dart';
import '../model/TRFExecutiveProfile.dart';
import '../model/addExpensesModel.dart';
import '../model/headOfficeRequestList.dart';
import '../model/salonDataModel.dart';
import '../model/submitTourModel.dart';
import '../model/totalExpensesModel.dart';
import '../model/tourVisitModel.dart';

class TourController extends GetxController implements GetxService {
  final TourRepo tourRepo;
  ExeTourDetailModel? exeTourDetailModel;
  HeadOfficeRequestList? headOfficeRequestList;
  TourDetailsByIdModel? tourDetailsByIdModel;
  TRFExecutiveProfile? trfExecutiveProfile;
  TourRequestListModel? tourRequestListModel;
  TourVisitModel? tourVisitModel;
  CommPhaseModel? commPhaseModel;
  SalonDataModel? salonDataModel;
  TotalExpensesModel? totalExpensesModel;
  bool? _isLoading = false;

  String? tourAddMessage, expensesAddMsg;

  bool get isLoading => _isLoading!;

  TourController({required this.tourRepo});

  Future<ExeTourDetailModel?> getTourRequestList() async {
    _isLoading = true;
    // update();
    Response response = await tourRepo.getTourRequestList();

    if (response.statusCode == 200) {
      exeTourDetailModel = ExeTourDetailModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      exeTourDetailModel = ExeTourDetailModel();
    }
    _isLoading = false;
    update();
    return exeTourDetailModel;
  }

  Future<HeadOfficeRequestList?> getHeadOfficeToursList() async {
    _isLoading = true;
    // update();
    Response response = await tourRepo.getApprovedHeadOfficeList();

    if (response.statusCode == 200) {
      headOfficeRequestList = HeadOfficeRequestList.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      headOfficeRequestList = HeadOfficeRequestList();
    }
    _isLoading = false;
    update();
    return headOfficeRequestList;
  }

  Future<TRFExecutiveProfile?> getExecutivesList() async {
    _isLoading = true;
    Response response = await tourRepo.getTrfExecutivesList();
    if (response.statusCode == 200) {
      trfExecutiveProfile = TRFExecutiveProfile.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      trfExecutiveProfile = TRFExecutiveProfile();
    }
    _isLoading = false;
    update();
    return trfExecutiveProfile;
  }

  Future<CommPhaseModel?> getCommPhaseList() async {
    _isLoading = true;
    // update();
    Response response = await tourRepo.getCommPhaseList();
    if (response.statusCode == 200) {
      commPhaseModel = CommPhaseModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      commPhaseModel = CommPhaseModel();
    }
    _isLoading = false;
    update();
    return commPhaseModel;
  }

/*  Future<String?> submitTourRequest({TourRequestModel? model}) async {
    _isLoading = true;
    update();
    Response response = await tourRepo.storeTourRequest(tourRequestModel: model);
    if (response.statusCode == 200) {
      tourAddMessage = response.body['message'];
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      tourAddMessage = "";
    }
    _isLoading = false;
    update();
    return tourAddMessage;
  }*/

  Future<String?> submitTourRequest(
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
    _isLoading = true;
    update();
    Response response = await tourRepo.storeTourRequest(
        name: name,
        travel_from: travel_from,
        travel_to: travel_to,
        dept_date: dept_date,
        return_date: return_date,
        checkin_date: checkin_date,
        checkout_date: checkout_date,
        no_of_days: no_of_days,
        no_of_demos: no_of_demos,
        user_id: user_id,
        role_id: role_id,
        remark: remark,
        tourid: tourid);

    if (response.statusCode == 200) {
      tourAddMessage = response.body['message'];
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      tourAddMessage = "";
    }
    _isLoading = false;
    update();
    return tourAddMessage;
  }

  Future<String?> submitTourVisitDetails(
      SubmitTourModel? submitTourModel) async {
    _isLoading = true;
    update();
    Response response = await tourRepo.storeTourVisitDetails(submitTourModel);

    if (response.statusCode == 200) {
      tourAddMessage = response.body['message'];
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      tourAddMessage = "";
    }
    _isLoading = false;
    update();
    return tourAddMessage;
  }

  Future<String?> deleteTourRequest({String? tour_reqid}) async {
    //  _isLoading = false;//made it false to avoid loading
    update();

    Response response =
        await tourRepo.deleteTourRequest(tour_reqid: tour_reqid);

    if (response.statusCode == 200) {
      tourAddMessage = response.body['message'];
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      tourAddMessage = "";
    }

    // _isLoading = false;
    update();
    return tourAddMessage;
  }

  Future<TourRequestListModel?> getExecutivesTourRequestList(
      {String? exe_id}) async {
    _isLoading = true;
    //update();

    Response response =
        await tourRepo.getExecutiveTourRequestList(executive_id: exe_id);

    if (response.statusCode == 200) {
      tourRequestListModel = TourRequestListModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      tourRequestListModel = TourRequestListModel();
    }
    _isLoading = false;
    update();
    return tourRequestListModel;
  }

  Future<SalonDataModel?> getSalonNameList({String? key}) async {
    _isLoading = true;
    //update();

    Response response = await tourRepo.getSalonListByKey(key: key);

    if (response.statusCode == 200) {
      salonDataModel = SalonDataModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      salonDataModel = SalonDataModel();
    }
    _isLoading = false;
    update();
    return salonDataModel;
  }

  Future<TourDetailsByIdModel?> getTourDetailsByid({String? tour_reqid}) async {
    _isLoading = true; //made it false to avoid loading
    //  update();

    Response response = await tourRepo.getTourDetailsByID(tour_id: tour_reqid);

    if (response.statusCode == 200) {
      tourDetailsByIdModel = TourDetailsByIdModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      tourDetailsByIdModel = TourDetailsByIdModel();
    }

    _isLoading = false;
    update();
    return tourDetailsByIdModel;
  }

  Future<TourVisitModel?> getTourVisitDetails({String? tour_reqid}) async {
    _isLoading = true;
    update();
    Response response =
        await tourRepo.getVisitedTourList(tour_requestid: tour_reqid);
    if (response.statusCode == 200) {
      tourVisitModel = TourVisitModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      tourVisitModel = TourVisitModel();
    }
    _isLoading = false;
    update();
    return tourVisitModel;
  }

  Future<String?> updateTourDetails({
    String? tour_req_id,
    String? status,
    String? remark,
  }) async {
    _isLoading = true;
    update();

    Response response = await tourRepo.updateTourRequestStatus(
      tour_req_id: tour_req_id,
      status: status,
      remark: remark,
    );
    if (response.statusCode == 200) {
      tourAddMessage = response.body['message']; //Data submitted successfully.
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      tourAddMessage = '';
    }
    _isLoading = false;
    update();
    return tourAddMessage;
  }

  Future<String?> updateTourDetailsbyHeadOffice(
      {String? tour_req_id, String? remark, XFile? attachment}) async {
    _isLoading = true;
    update();

    Response response = await tourRepo.updateTourRequestByHeadOfficer(
        tour_req_id: tour_req_id, remark: remark, attachment: attachment);
    if (response.statusCode == 200) {
      tourAddMessage = response.body['message']; //Data submitted successfully.
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      tourAddMessage = '';
    }
    _isLoading = false;
    update();
    return tourAddMessage;
  }

  Future<String?> addExpenses({AddExpensesModel? addExpensesModel}) async {
    _isLoading = true;
    update();
    Response response =
        await tourRepo.storeExpenses(addExpensesModel: addExpensesModel);
    if (response.statusCode == 200) {
      expensesAddMsg = response.body['message'];
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      expensesAddMsg = '';
    }
    _isLoading = false;
    update();
    return expensesAddMsg;
  }

  Future<TotalExpensesModel?> getExpensesList() async {
    _isLoading=true;

    Response response=await tourRepo.getExpensesList();
    if(response.statusCode==200)
      {
        totalExpensesModel=TotalExpensesModel.fromJson(response.body);
      }
    else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      totalExpensesModel = TotalExpensesModel();
    }
    _isLoading=false;
    update();
    return totalExpensesModel;
  }
}
