import 'package:get/get.dart';
import 'package:shimmers/model/ExeTourDetailModel.dart';
import 'package:shimmers/model/TourRequestModel.dart';
import 'package:shimmers/repository/tourRepo.dart';

import '../constant/route_helper.dart';

class TourController extends GetxController implements GetxService{
  final TourRepo tourRepo;
  ExeTourDetailModel? exeTourDetailModel;
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

  Future<String?> submitTourRequest(TourRequestModel? model) async {
    _isLoading = true;
    update();
    Response response = await tourRepo.storeTourRequest(model);
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



}