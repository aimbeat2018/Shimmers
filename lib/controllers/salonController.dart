import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmers/model/campaignListModel.dart';
import 'package:shimmers/model/campaignQuestionListModel.dart';
import 'package:shimmers/model/demoListModel.dart';
import 'package:shimmers/model/employeeRouteListModel.dart';
import 'package:shimmers/model/feedBackPurposeModel.dart';
import 'package:shimmers/model/placeOrderModel.dart';
import 'package:shimmers/model/productModel.dart';
import 'package:shimmers/model/salonCategoryModel.dart';
import 'package:shimmers/model/salonDetailsModel.dart';
import 'package:shimmers/model/salonRouteModel.dart';
import 'package:shimmers/model/submitCampaignRequestmodel.dart';
import 'package:shimmers/model/unitTypeModel.dart';
import 'package:shimmers/repository/salonRepo.dart';

import '../constant/route_helper.dart';
import '../model/cartModel.dart';
import '../model/deliveredOrderModel.dart';
import '../model/orderApprovalModel.dart';
import '../model/viewProductsModel.dart';
import 'cartController.dart';

class SalonController extends GetxController implements GetxService {
  final SalonRepo salonRepo;

  SalonController({required this.salonRepo});

  SalonRouteModel? salonRouteModel;

  SalonCategoryModel? salonCategoryModel;

  FeedBackPurposeModel? feedBackPurposeModel;

  EmployeeRouteListModel? employeeRouteListModel;

  CampaignListModel? campaignListModel;

  DemoListModel? demoListModel;

  CampaignQuestionListModel? campaignQuestionListModel;

  UnitTypeModel? unitTypeModel;

  ProductModel? productModel;

  SalonDetailsModel? salonDetailsModel;

  DeliveredOrderModel? deliveredOrderModel;

  ViewProductsModel? viewProductsModel;

  OrderApprovalModel? orderApprovalModel;

  bool? _isLoading = false;
  String? salonAddMessage;

  bool get isLoading => _isLoading!;

  int? _quantity = 1;

  int? _cartIndex = -1;

  int? get quantity => _quantity;

  int? get cartIndex => _cartIndex;

  String? punchInMsg;

  Future<SalonRouteModel?> getSalonRouteList(
      {String? latitude, String? longitude, String? type}) async {
    _isLoading = true;
    update();
    Response response = await salonRepo.getRouteList(
        latitude: latitude, longitude: longitude, type: type);

    if (response.statusCode == 200) {
      salonRouteModel = SalonRouteModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      salonRouteModel = SalonRouteModel();
    }
    _isLoading = false;
    update();
    return salonRouteModel;
  }

  Future<DeliveredOrderModel?> getNotDeliveredOrderList() async {
    _isLoading = true;
    // update();
    Response response = await salonRepo.getNonDeliveredOrderList();
    if (response.statusCode == 200) {
      deliveredOrderModel = DeliveredOrderModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      deliveredOrderModel = DeliveredOrderModel();
    }
    _isLoading = false;
    update();
    return deliveredOrderModel;
  }

  Future<OrderApprovalModel?> getapprovalorderList() async {
    _isLoading = true;
    update();
    Response response = await salonRepo.getNotApprovedOrderList();
    if (response.statusCode == 200) {
      orderApprovalModel = OrderApprovalModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      orderApprovalModel = OrderApprovalModel();
    }
    _isLoading = false;
    update();
    return orderApprovalModel;
  }

  Future<String?> updateorderStatus({String? order_id, String? status}) async {
    _isLoading = true;
    update();
    Response response =
        await salonRepo.updateOrderStatus(orderid: order_id, status: status);

    if (response.statusCode == 200) {
      salonAddMessage = response.body['message'];
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      salonAddMessage = "";
    }
    _isLoading = false;
    update();
    return salonAddMessage;
  }

  Future<String?> updateOrderApproval(
      {String? order_id, String? status}) async {
    _isLoading = true;
    update();
    Response response =
        await salonRepo.updateOrderApproval(order_id: order_id, status: status);

    if (response.statusCode == 200) {
      salonAddMessage = response.body['message'];
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      salonAddMessage = "";
    }
    _isLoading = false;
    update();
    return salonAddMessage;
  }

  Future<ViewProductsModel?> viewProductsbyOrederId({String? order_id}) async {
    _isLoading = true;
    // update();
    Response response = await salonRepo.getProductByOrderID(orderid: order_id);
    if (response.statusCode == 200) {
      viewProductsModel = ViewProductsModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      viewProductsModel = ViewProductsModel();
    }
    _isLoading = false;
    update();
    return viewProductsModel;
  }

  Future<SalonCategoryModel?> getSalonCategory() async {
    _isLoading = true;
    // update();
    Response response = await salonRepo.getSalonCategory();

    if (response.statusCode == 200) {
      salonCategoryModel = SalonCategoryModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      salonCategoryModel = SalonCategoryModel();
    }
    _isLoading = false;
    update();
    return salonCategoryModel;
  }

  Future<FeedBackPurposeModel?> getFeedbackPurpose() async {
    _isLoading = true;
    // update();
    Response response = await salonRepo.getFeedbackPurpose();

    if (response.statusCode == 200) {
      feedBackPurposeModel = FeedBackPurposeModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      feedBackPurposeModel = FeedBackPurposeModel();
    }
    _isLoading = false;
    update();
    return feedBackPurposeModel;
  }

  Future<EmployeeRouteListModel?> getEmpRouteList() async {
    _isLoading = true;
    // update();
    Response response = await salonRepo.getEmpRouteList();

    if (response.statusCode == 200) {
      employeeRouteListModel = EmployeeRouteListModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      employeeRouteListModel = EmployeeRouteListModel();
    }
    _isLoading = false;
    update();
    return employeeRouteListModel;
  }

  Future<UnitTypeModel?> getUnitType() async {
    _isLoading = true;
    // update();
    Response response = await salonRepo.getUnitType();

    if (response.statusCode == 200) {
      unitTypeModel = UnitTypeModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      unitTypeModel = UnitTypeModel();
    }
    _isLoading = false;
    update();
    return unitTypeModel;
  }

  Future<ProductModel?> getProducts() async {
    _isLoading = true;
    // update();
    Response response = await salonRepo.getProducts();

    if (response.statusCode == 200) {
      productModel = ProductModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      productModel = ProductModel();
    }
    _isLoading = false;
    update();
    return productModel;
  }

  Future<CampaignListModel?> getCampaignList() async {
    _isLoading = true;
    // update();
    Response response = await salonRepo.getCampaignList();

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

  Future<DemoListModel?> getDemoList(String? salonId) async {
    _isLoading = true;
    // update();
    Response response = await salonRepo.getDemoList(salonId: salonId);

    if (response.statusCode == 200) {
      demoListModel = DemoListModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      demoListModel = DemoListModel();
    }
    _isLoading = false;
    update();
    return demoListModel;
  }

  Future<CampaignQuestionListModel?> getCampaignQuestionList(
      {String? campaignId}) async {
    _isLoading = true;
    // update();
    Response response =
        await salonRepo.getCampaignQuestionList(campaignId: campaignId);

    if (response.statusCode == 200) {
      campaignQuestionListModel =
          CampaignQuestionListModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      campaignQuestionListModel = CampaignQuestionListModel();
    }
    _isLoading = false;
    update();
    return campaignQuestionListModel;
  }

  Future<SalonDetailsModel?> getSalonDetails(String? salonId) async {
    _isLoading = true;
    // update();
    Response response = await salonRepo.getSalonDetails(salonId: salonId);

    if (response.statusCode == 200) {
      salonDetailsModel = SalonDetailsModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      salonDetailsModel = SalonDetailsModel();
    }
    _isLoading = false;
    update();
    return salonDetailsModel;
  }

  Future<String?> addSalon(
      {String? name,
      String? email,
      String? password,
      String? mobile,
      String? location_id,
      String? address,
      String? shipping_address,
      String? postal_code,
      String? state,
      String? city,
      String? number,
      String? owner_name,
      String? sub_category_id,
      String? gst_number,
      String? country,
      String? salon_type,
      String? latitude,
      String? longitude,
      XFile? image}) async {
    _isLoading = true;
    update();
    Response response = await salonRepo.addSalon(
        name: name,
        email: email,
        password: password,
        mobile: mobile,
        longitude: longitude,
        location_id: location_id,
        address: address,
        shipping_address: shipping_address,
        postal_code: postal_code,
        state: state,
        city: city,
        number: number,
        owner_name: owner_name,
        sub_category_id: sub_category_id,
        gst_number: gst_number,
        country: country,
        salon_type: salon_type,
        latitude: latitude,
        image: image);

    if (response.statusCode == 200) {
      salonAddMessage = response.body['message'];
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      salonAddMessage = "";
    }
    _isLoading = false;
    update();
    return salonAddMessage;
  }

  Future<String?> updateSalonType({String? salonId, String? salonType}) async {
    _isLoading = true;
    update();
    Response response =
        await salonRepo.updateSalonType(salonId: salonId, salonType: salonType);

    if (response.statusCode == 200) {
      salonAddMessage = response.body['message'];
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      salonAddMessage = "";
    }
    _isLoading = false;
    update();
    return salonAddMessage;
  }

  Future<String?> takeSalonNote({String? salonId, String? note}) async {
    _isLoading = true;
    update();
    Response response =
        await salonRepo.takeSalonNote(salonId: salonId, note: note);

    if (response.statusCode == 200) {
      salonAddMessage = response.body['message'];
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      salonAddMessage = "";
    }
    _isLoading = false;
    update();
    return salonAddMessage;
  }

  Future<String?> collectPayment(
      {String? paymentMode,
      String? salonId,
      String? referenceNumber,
      String? amount,
      XFile? image}) async {
    _isLoading = true;
    update();
    Response response = await salonRepo.collectPayment(
        paymentMode: paymentMode,
        salonId: salonId,
        referenceNumber: referenceNumber,
        amount: amount,
        image: image);

    if (response.statusCode == 200) {
      salonAddMessage = response.body['message'];
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      salonAddMessage = "";
    }
    _isLoading = false;
    update();
    return salonAddMessage;
  }

  Future<String?> addFeedback(
      {String? feedbackTypeId,
      String? salonId,
      String? rating,
      String? remark,
      String? latitude,
      String? longitude,
      XFile? image}) async {
    _isLoading = true;
    update();
    Response response = await salonRepo.addFeedback(
        feedbackTypeId: feedbackTypeId,
        salonId: salonId,
        rating: rating,
        remark: remark,
        latitude: latitude,
        longitude: longitude,
        image: image);

    if (response.statusCode == 200) {
      salonAddMessage = response.body['message'];
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      salonAddMessage = "";
    }
    _isLoading = false;
    update();
    return salonAddMessage;
  }

  Future<String?> placeOrder(PlaceOrderModel? model) async {
    _isLoading = true;
    update();
    Response response = await salonRepo.placeOrder(model);

    if (response.statusCode == 200) {
      salonAddMessage = response.body['message'];
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      salonAddMessage = "";
    }
    _isLoading = false;
    update();
    return salonAddMessage;
  }

  Future<String?> submitCampaignData(SubmitCampaignRequestModel? model) async {
    _isLoading = true;
    update();
    Response response = await salonRepo.submitCampaignData(model);

    if (response.statusCode == 200) {
      salonAddMessage = response.body['message'];
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      salonAddMessage = "";
    }
    _isLoading = false;
    update();
    return salonAddMessage;
  }

  Future<String?> addDemoRequest(
      {String? salonId,
      String? date,
      String? time,
      String? requirement}) async {
    _isLoading = true;
    update();
    Response response = await salonRepo.addDemoRequest(
        salonId: salonId, date: date, time: time, requirement: requirement);

    if (response.statusCode == 200) {
      salonAddMessage = response.body['message'];
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      salonAddMessage = "";
    }
    _isLoading = false;
    update();
    return salonAddMessage;
  }

  void initData(ProductData? product, CartModel? cart) {
    if (cart != null) {
      _quantity = cart.quantity;
    } else {
      _quantity = 1;
      setExistInCart(product, notify: false);
    }
  }

  int? setExistInCart(ProductData? product, {bool notify = true}) {
    _cartIndex =
        Get.find<CartController>().isExistInCart(product!.id, false, -1);
    if (_cartIndex != -1) {
      _quantity = Get.find<CartController>().cartList![_cartIndex!].quantity;
    }
    return _cartIndex;
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = _quantity! + 1;
    } else {
      _quantity = _quantity! - 1;
    }
    update();
  }

  Future<String?> salonwiseLogin(
      {String? salonid, String? lat, String? long, String? address}) async {
    _isLoading = false; //made it false to avoid loading
    update();

    Response response = await salonRepo.salonWisePunchIn(
        salonid: salonid, lat: lat, long: long, address: address);

    if (response.statusCode == 200) {
      punchInMsg = response.body['message'];
    } else if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      punchInMsg = "";
    }

    _isLoading = false;
    update();
    return punchInMsg;
  }
}
