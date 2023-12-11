import 'package:get/get.dart';
import 'package:shimmers/repository/scoreRepo.dart';

import '../constant/route_helper.dart';
import '../model/activityCountModel.dart';

class ScoreController extends GetxController implements GetxService{
  final ScoreRepo scoreRepo;
  ActivityCountModel? activityCountModel;
  bool? _isLoading = false;

  bool get isLoading => _isLoading!;

  ScoreController({required this.scoreRepo});

  Future<ActivityCountModel?> getEmployeeScorecard(user_id,from_date,to_date) async
  {
   _isLoading=true;
   Response response=await scoreRepo.getemployeesScorecard(user_id: user_id,from_date: from_date,to_date: to_date);
   
   if(response.statusCode==200) {
     activityCountModel = ActivityCountModel.fromJson(response.body);
   }
   else if (response.statusCode == 401) {
     Get.offAllNamed(RouteHelper.getLoginRoute());
   }
   else{
     activityCountModel=ActivityCountModel();
   }
   _isLoading=false;
   update();
   return activityCountModel;
  }



}