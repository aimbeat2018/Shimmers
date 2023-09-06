import 'package:get/get.dart';
import 'package:shimmers/constant/route_helper.dart';

import '../custom_snackbar.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      showCustomSnackBar(response.statusText!);
    }
  }
}
