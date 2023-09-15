import 'package:get/get.dart';
import 'package:shimmers/model/campaignResponseModel.dart';
import 'package:shimmers/repository/campaignRepo.dart';

import '../constant/route_helper.dart';
import '../model/campaignListModel.dart';

class CampaignController extends GetxController implements GetxService {
  final CampaignRepo campaignRepo;

  CampaignController({required this.campaignRepo});

  bool? _isLoading = false;

  bool get isLoading => _isLoading!;

  CampaignListModel? campaignListModel;

  CampaignResponseModel? campaignResponseModel;

  Future<CampaignListModel?> getEmployeeCampaignList(String? employeeId) async {
    _isLoading = true;
    // update();
    Response response = await campaignRepo.getEmployeeCampaignList(employeeId);

    if (response.statusCode == 200) {
      campaignListModel = CampaignListModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      campaignListModel = CampaignListModel();
    }
    _isLoading = false;
    update();
    return campaignListModel;
  }

  Future<CampaignResponseModel?> getEmployeeCampaignResponse(
      String? campaignId) async {
    _isLoading = true;
    // update();
    Response response =
        await campaignRepo.getEmployeeCampaignResponse(campaignId);

    if (response.statusCode == 200) {
      campaignResponseModel = CampaignResponseModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      campaignResponseModel = CampaignResponseModel();
    }
    _isLoading = false;
    update();
    return campaignResponseModel;
  }
}
