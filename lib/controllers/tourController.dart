import 'package:get/get.dart';
import 'package:shimmers/model/ExeTourDetailModel.dart';
import 'package:shimmers/model/TourRequestModel.dart';
import 'package:shimmers/model/tourdetailsByIdModel.dart';
import 'package:shimmers/repository/tourRepo.dart';

import '../constant/route_helper.dart';

class TourController extends GetxController implements GetxService {
  final TourRepo tourRepo;
  ExeTourDetailModel? exeTourDetailModel;
  TourDetailsByIdModel? tourDetailsByIdModel;
  bool? _isLoading = false;

  String? tourAddMessage;

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
      {String? area,
      String? date,
      String? time,
      String? amount,
      String? userid,
      String? roleid,
      String? remark,
      String? purpose,
      String? tourid}) async {
    _isLoading = true;
    update();
    Response response = await tourRepo.storeTourRequest(
        area: area,
        date: date,
        time: time,
        amount: amount,
        userid: userid,
        roleid: roleid,
        remark: remark,
        purpose: purpose,
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
      {String? tour_visitid,
      String? area,
      String? date,
      String? time,
      String? role,
      String? name,
      String? contact,
      String? description}) async {
    _isLoading = true;
    update();
    Response response = await tourRepo.storeTourVisitDetails(
        tour_visitid: tour_visitid,
        area: area,
        date: date,
        time: time,
        role: role,
        name: name,
        contact: contact,
        description: description);

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

  Future<TourDetailsByIdModel?> getTourDetailsByid({String? tour_reqid}) async {
    _isLoading = true; //made it false to avoid loading
    update();

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
}
