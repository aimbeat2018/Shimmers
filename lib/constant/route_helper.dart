import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmers/screens/home/mainScreen.dart';
import 'package:shimmers/screens/salons/salonDetails/salonDetailsScreen.dart';
import 'package:shimmers/screens/salonsActivity/demo/addDemoScreen.dart';
import 'package:shimmers/screens/userAuth/LoginScreen.dart';
import 'package:shimmers/screens/userAuth/PasswordScreen.dart';

import '../screens/userAuth/PasswordResetScreen.dart';

class RouteHelper {
  // static const String initial = '/';
  static const String login = '/login';
  static const String passwordScreen = '/passwordScreen';
  static const String mainScreen = '/mainScreen';
  static const String passwordChangedScreen = '/passwordChangedScreen';
  static const String salonDetails = '/salonDetails';
  static const String addDemoRequest = '/addDemoRequest';

  static String getLoginRoute() => login;

  static String getMainScreenRoute() => mainScreen;

  static String getPasswordChangedScreenRoute(String email, String image) =>
      '$passwordChangedScreen?email=$email&image=$image';

  static String getPasswordScreenRoute(String image, String email) =>
      '$passwordScreen?image=$image&email=$email';

  static String getSalonDetailsRoute(String salonId) =>
      '$salonDetails?salonId=$salonId';

  static String getDemoRequestRoute(String salonId) =>
      '$addDemoRequest?salonId=$salonId';

  static List<GetPage> routes = [
    GetPage(name: login, page: () => getRoute(const LoginScreen())),
    GetPage(name: mainScreen, page: () => getRoute(const MainScreen())),
    GetPage(
        name: passwordChangedScreen,
        page: () => PasswordResetScreen(
            email: Get.parameters['email'], image: Get.parameters['image'])),
    GetPage(
        name: passwordScreen,
        page: () => PasswordScreen(
              image: Get.parameters['image'],
              email: Get.parameters['email'],
            )),
    GetPage(
        name: salonDetails,
        page: () => SalonDetailsScreen(salonId: Get.parameters['salonId']!)),
    GetPage(
        name: addDemoRequest,
        page: () => AddDemoScreen(salonId: Get.parameters['salonId']!)),
    // GetPage(
    //     name: language,
    //     page: () =>
    //         ChooseLanguageScreen(fromMenu: Get.parameters['page'] == 'menu')),
    // GetPage(name: onBoarding, page: () => OnBoardingScreen()),
    // GetPage(
    //     name: signIn,
    //     page: () => SignInScreen(
    //           exitFromApp: Get.parameters['page'] == signUp ||
    //               Get.parameters['page'] == splash ||
    //               Get.parameters['page'] == onBoarding,
    //         )),
    // GetPage(
    //     name: buyNowPage,
    //     page: () => PayViaQRScreen(
    //           amount: Get.parameters['amount'],
    //         )),
    // GetPage(
    //     name: packageDetails,
    //     page: () =>
    //         PackageDetailsScreen(walletPackageModel: Get.parameters['id'])),
    // GetPage(name: signUp, page: () => SignUpScreen()),
    // GetPage(
    //     name: verification,
    //     page: () {
    //       List<int> _decode =
    //           base64Decode(Get.parameters['pass'].replaceAll(' ', '+'));
    //       String _data = utf8.decode(_decode);
    //       return VerificationScreen(
    //         number: Get.parameters['number'],
    //         fromSignUp: Get.parameters['page'] == signUp,
    //         token: Get.parameters['token'],
    //         password: _data,
    //       );
    //     }),
    // GetPage(
    //     name: accessLocation,
    //     page: () => AccessLocationScreen(
    //           fromSignUp: Get.parameters['page'] == signUp,
    //           fromHome: Get.parameters['page'] == 'home',
    //           route: null,
    //         )),
    // GetPage(
    //     name: pickMap,
    //     page: () {
    //       PickMapScreen _pickMapScreen = Get.arguments;
    //       bool _fromAddress = Get.parameters['page'] == 'add-address';
    //       return (_fromAddress && _pickMapScreen == null)
    //           ? NotFound()
    //           : _pickMapScreen != null
    //               ? _pickMapScreen
    //               : PickMapScreen(
    //                   fromSignUp: Get.parameters['page'] == signUp,
    //                   fromAddAddress: _fromAddress,
    //                   route: Get.parameters['page'],
    //                   canRoute: Get.parameters['route'] == 'true',
    //                 );
    //     }),
    // GetPage(name: interest, page: () => InterestScreen()),
    // GetPage(
    //     name: main,
    //     page: () => getRoute(DashboardScreen(
    //           pageIndex: Get.parameters['page'] == 'home'
    //               ? 0
    //               : Get.parameters['page'] == 'favourite'
    //                   ? 1
    //                   : Get.parameters['page'] == 'cart'
    //                       ? 2
    //                       : Get.parameters['page'] == 'order'
    //                           ? 3
    //                           : Get.parameters['page'] == 'menu'
    //                               ? 4
    //                               : 0,
    //         ))),
    // GetPage(
    //     name: forgotPassword,
    //     page: () {
    //       SocialLogInBody _data;
    //       if (Get.parameters['page'] == 'social-login') {
    //         List<int> _decode =
    //             base64Decode(Get.parameters['data'].replaceAll(' ', '+'));
    //         _data = SocialLogInBody.fromJson(jsonDecode(utf8.decode(_decode)));
    //       }
    //       return ForgetPassScreen(
    //           fromSocialLogin: Get.parameters['page'] == 'social-login',
    //           socialLogInBody: _data);
    //     }),
    // GetPage(
    //     name: resetPassword,
    //     page: () => NewPassScreen(
    //           resetToken: Get.parameters['token'],
    //           number: Get.parameters['phone'],
    //           fromPasswordChange: Get.parameters['page'] == 'password-change',
    //         )),
    // GetPage(
    //     name: productImageSlider,
    //     page: () => FullProductImageSlider(
    //           image: Get.parameters['image'],
    //           image1: Get.parameters['image1'],
    //           image2: Get.parameters['image2'],
    //           image3: Get.parameters['image3'],
    //         )),
    // GetPage(name: search, page: () => getRoute(SearchScreen())),
    // GetPage(
    //     name: restaurant,
    //     page: () {
    //       return getRoute(Get.arguments != null
    //           ? Get.arguments
    //           : RestaurantScreen(
    //               restaurant: Restaurant(id: int.parse(Get.parameters['id']))));
    //     }),
    // GetPage(
    //     name: orderDetails,
    //     page: () {
    //       return getRoute(Get.arguments != null
    //           ? Get.arguments
    //           : OrderDetailsScreen(
    //               orderId: int.parse(Get.parameters['id'] ?? '0'),
    //               orderModel: null));
    //     }),
    // GetPage(name: profile, page: () => getRoute(ProfileScreen())),
    // GetPage(name: updateProfile, page: () => getRoute(UpdateProfileScreen())),
    // GetPage(name: coupon, page: () => getRoute(CouponScreen())),
    // GetPage(name: notification, page: () => getRoute(NotificationScreen())),
    // GetPage(
    //     name: map,
    //     page: () {
    //       List<int> _decode =
    //           base64Decode(Get.parameters['address'].replaceAll(' ', '+'));
    //       AddressModel _data =
    //           AddressModel.fromJson(jsonDecode(utf8.decode(_decode)));
    //       return getRoute(MapScreen(
    //           fromRestaurant: Get.parameters['page'] == 'restaurant',
    //           address: _data));
    //     }),
    // GetPage(
    //     name: address,
    //     page: () =>
    //         getRoute(AddressScreen(from: Get.parameters['page'] == 'address'))),
    // GetPage(
    //     name: medicineRequest, page: () => getRoute(MedicineRequestScreen())),
    // GetPage(
    //     name: restaurantBooking,
    //     page: () => getRoute(RestaurantBookingScreen())),
    // GetPage(
    //     name: orderSuccess,
    //     page: () => getRoute(OrderSuccessfulScreen(
    //           orderID: Get.parameters['id'],
    //           status: Get.parameters['status'].contains('success') ? 1 : 0,
    //           totalAmount: null,
    //         ))),
    // GetPage(
    //     name: payment,
    //     page: () => getRoute(PaymentScreen(
    //             orderModel: OrderModel(
    //           id: int.parse(Get.parameters['id']),
    //           userId: int.parse(Get.parameters['user']),
    //           orderAmount: double.parse(Get.parameters['amount']),
    //         )))),
    // GetPage(
    //     name: walletPayment,
    //     // page: () => getRoute(WalletPaymentScreen(
    //     //     id: Get.parameters['id'],
    //     //     userId: int.parse(Get.parameters['user']),
    //     //     orderAmount: double.parse(Get.parameters['amount'])
    //     //     ))),
    //     page: () => getRoute(WalletPaymentScreen(
    //         orderId: Get.parameters['id'],
    //         userId: Get.parameters['user'],
    //         amount: double.parse(Get.parameters['amount'])))),
    // GetPage(
    //     name: checkout,
    //     page: () {
    //       CheckoutScreen _checkoutScreen = Get.arguments;
    //       bool _fromCart = Get.parameters['page'] == 'cart';
    //       return getRoute(_checkoutScreen != null
    //           ? _checkoutScreen
    //           : !_fromCart
    //               ? NotFound()
    //               : CheckoutScreen(
    //                   cartList: null,
    //                   fromCart: Get.parameters['page'] == 'cart',
    //                 ));
    //     }),
    // GetPage(
    //     name: orderTracking,
    //     page: () =>
    //         getRoute(OrderTrackingScreen(orderID: Get.parameters['id']))),
    // GetPage(
    //     name: basicCampaign,
    //     page: () {
    //       BasicCampaignModel _data = BasicCampaignModel.fromJson(jsonDecode(
    //           utf8.decode(
    //               base64Decode(Get.parameters['data'].replaceAll(' ', '+')))));
    //       return getRoute(CampaignScreen(campaign: _data));
    //     }),
    // GetPage(
    //     name: html,
    //     page: () => HtmlViewerScreen(
    //           htmlType: Get.parameters['page'] == 'terms-and-condition'
    //               ? HtmlType.TERMS_AND_CONDITION
    //               : Get.parameters['page'] == 'privacy-policy'
    //                   ? HtmlType.PRIVACY_POLICY
    //                   : HtmlType.ABOUT_US,
    //         )),
    // GetPage(name: categories, page: () => getRoute(CategoryScreen())),
    // GetPage(
    //     name: categoryProduct,
    //     page: () {
    //       List<int> _decode =
    //           base64Decode(Get.parameters['name'].replaceAll(' ', '+'));
    //       String _data = utf8.decode(_decode);
    //       return getRoute(CategoryVendorScreen(
    //           categoryID: Get.parameters['id'], categoryName: _data));
    //     }),
    // GetPage(
    //     name: categoryProductLadiesWare,
    //     page: () {
    //       List<int> _decode =
    //           base64Decode(Get.parameters['name'].replaceAll(' ', '+'));
    //       String _data = utf8.decode(_decode);
    //       return getRoute(CategoryProductScreen(
    //           categoryID: Get.parameters['id'], categoryName: _data));
    //     }),
    // GetPage(
    //     name: popularFoods,
    //     page: () => getRoute(
    //         PopularFoodScreen(isPopular: Get.parameters['page'] == 'popular'))),
    // GetPage(name: itemCampaign, page: () => getRoute(ItemCampaignScreen())),
    // GetPage(name: support, page: () => getRoute(SupportScreen())),
    // GetPage(
    //     name: update,
    //     page: () => UpdateScreen(isUpdate: Get.parameters['update'] == 'true')),
    // GetPage(name: cart, page: () => getRoute(CartScreen(fromNav: false))),
    // GetPage(
    //     name: addAddress,
    //     page: () => getRoute(AddAddressScreen(
    //         fromCheckout: Get.parameters['page'] == 'checkout'))),
    // GetPage(
    //     name: uploadPrescription,
    //     page: () => getRoute(UploadPrescriptionScreen(
    //         restaurantID: Get.parameters['vendorId']))),
    // GetPage(
    //     name: restaurantDining,
    //     page: () => getRoute(AddRestaurantDiningScreen(
    //         restaurantID: Get.parameters['vendorId']))),
    // GetPage(
    //     name: editAddress,
    //     page: () => getRoute(AddAddressScreen(
    //           fromCheckout: false,
    //           address: AddressModel.fromJson(jsonDecode(utf8.decode(base64Url
    //               .decode(Get.parameters['data'].replaceAll(' ', '+'))))),
    //         ))),
    // GetPage(
    //     name: rateReview,
    //     page: () =>
    //         getRoute(Get.arguments != null ? Get.arguments : NotFound())),
    // GetPage(
    //     name: restaurantReview,
    //     page: () => getRoute(ReviewScreen(restaurantID: Get.parameters['id']))),
    // GetPage(
    //     name: allRestaurants,
    //     page: () => getRoute(AllRestaurantScreen(
    //         isPopular: Get.parameters['page'] == 'popular'))),
    // GetPage(
    //     name: wallet,
    //     page: () => getRoute(
    //         WalletScreen(fromWallet: Get.parameters['page'] == 'wallet'))),
    // GetPage(
    //     name: walletRecharge,
    //     page: () => getRoute(WalletRechargeScreen(
    //         fromWallet: Get.parameters['page'] == 'wallet'))),
    // GetPage(
    //     name: walletHistory,
    //     page: () => getRoute(WalletHistoryScreen(
    //         fromWallet: Get.parameters['page'] == 'wallet'))),
    // GetPage(name: accessZone, page: () => getRoute(SelectZoneScreen())),
    // GetPage(name: favourite, page: () => getRoute(FavouriteScreen())),
  ];

  static getRoute(Widget navigateTo) {
    return navigateTo;
  }
}
