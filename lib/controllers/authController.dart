import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmers/constant/route_helper.dart';
import 'package:shimmers/model/loginModel.dart';
import 'package:shimmers/model/profileModel.dart';

import '../model/checkEmailModel.dart';
import '../repository/authRepo.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  CheckEmailModel? responseModel;

  LoginModel? loginModel;

  ProfileModel? profileModel;

  String? msgReset;

  bool? _isLoading = false;

  bool get isLoading => _isLoading!;

  Future<CheckEmailModel?> checkEmail(String? phone) async {
    _isLoading = true;
    update();
    Response response = await authRepo.checkEmail(phone: phone);

    if (response.statusCode == 200) {
      responseModel = CheckEmailModel.fromJson(response.body);
    } else {
      responseModel = CheckEmailModel();
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<LoginModel?> loginUser(
      {String? phone, String? password, String? deviceToken}) async {
    _isLoading = true;
    update();
    Response response = await authRepo.login(
        phone: phone, password: password, deviceToken: deviceToken);

    if (response.statusCode == 200) {
      loginModel = LoginModel.fromJson(response.body);
      authRepo.saveUserToken(loginModel!.token!);
      authRepo.saveUserRole(loginModel!.roleId!.toString());
      authRepo.saveUserId(loginModel!.userId!.toString());
    } else {
      loginModel = LoginModel();
    }
    _isLoading = false;
    update();
    return loginModel;
  }

  Future<String?> resetPassword({String? phone, String? password}) async {
    _isLoading = true;
    update();
    Response response =
        await authRepo.resetPassword(phone: phone, password: password);

    if (response.statusCode == 200) {
      msgReset = response.bodyString!;
    } else {
      msgReset = "";
    }
    _isLoading = false;
    update();
    return msgReset;
  }

  Future<ProfileModel?> getUserProfile() async {
    _isLoading = true;
    update();
    Response response = await authRepo.getUserProfile();

    if (response.statusCode == 200) {
      profileModel = ProfileModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      profileModel = ProfileModel();
    }
    _isLoading = false;
    update();
    return profileModel;
  }

  Future<String?> updateUserImage(XFile data) async {
    _isLoading = true;
    update();
    Response response = await authRepo.updateUserImage(data);

    if (response.statusCode == 200) {
      msgReset = response.bodyString!;
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      msgReset = "";
    }
    _isLoading = false;
    update();
    return msgReset;
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  String getUserId() {
    return authRepo.getUserId();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }
}
