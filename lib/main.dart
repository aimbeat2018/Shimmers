import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shimmers/constant/get_di.dart' as di;
import 'package:shimmers/constant/globalFunction.dart';

import 'constant/route_helper.dart';
import 'controllers/authController.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  if (GlobalFunctions.isMobilePhone()) {
    HttpOverrides.global = new MyHttpOverrides();
  }
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      // onGenerateRoute: (RouteSettings settings) {
      //   // A custom `fadeThrough` route transition animation.
      //   return Routes.fadeThrough(settings, (context) {
      //     // Wrap widgets with another widget based on the route.
      //     // Wrap the page with the ResponsiveScaledBox for desired pages.
      //     return ConditionalRouteWidget(
      //         routesExcluded: const [
      //           // TypographyPage.name
      //         ], // Excluding a page from AutoScale.
      //         builder: (context, child) => MaxWidthBox(
      //               // A widget that limits the maximum width.
      //               // This is used to create a gutter area on either side of the content.
      //               maxWidth: 1200,
      //               background: Container(color: const Color(0xFFF5F5F5)),
      //               child: ResponsiveScaledBox(
      //                   // ResponsiveScaledBox renders its child with a FittedBox set to the `width` value.
      //                   // Set the fixed width value based on the active breakpoint.
      //                   width: ResponsiveValue<double>(context,
      //                       conditionalValues: [
      //                         Condition.equals(name: MOBILE, value: 450),
      //                         Condition.between(
      //                             start: 800, end: 1100, value: 800),
      //                         Condition.between(
      //                             start: 1000, end: 1200, value: 1000),
      //                         // There are no conditions for width over 1200
      //                         // because the `maxWidth` is set to 1200 via the MaxWidthBox.
      //                       ]).value,
      //                   child: child!),
      //             ),
      //         child: BouncingScrollWrapper.builder(
      //             context, buildPage(settings.name ?? ''),
      //             dragWithMouse: true));
      //   });
      // },
      title: 'Shimmers',
      initialRoute: Get.find<AuthController>().isLoggedIn()
          ? RouteHelper.getMainScreenRoute()
          : RouteHelper.getLoginRoute(),
      getPages: RouteHelper.routes,
      defaultTransition: Transition.topLevel,
      transitionDuration: const Duration(milliseconds: 500),
      supportedLocales: const [Locale('en')],
    );
  }
//
// Widget buildPage(String name) {
//   switch (name) {
//     case '/':
//       return const LoginScreen();
//     case PasswordScreen.name:
//       return const PasswordScreen();
//     case PasswordResetScreen.name:
//       return const PasswordResetScreen();
//     case MainScreen.routeName:
//       return const MainScreen();
//     case ProfileScreen.name:
//       return const ProfileScreen();
//     case LeavesScreen.name:
//       return const LeavesScreen();
//     case ApplyLeaveScreen.name:
//       return const ApplyLeaveScreen();
//     case SalonListScreen.name:
//       return const SalonListScreen();
//     case AddSalonBasicDetailsScreen.name:
//       return const AddSalonBasicDetailsScreen();
//     case AddSalonPersonalDetailsScreen.name:
//       return const AddSalonPersonalDetailsScreen(
//         salonCategory: "",
//         salonName: "",
//       );
//     case AddFinalSalonScreen.name:
//       return const AddFinalSalonScreen();
//     case SalonDetailsScreen.name:
//       return const SalonDetailsScreen();
//     case DistributorWiseSalonScreen.name:
//       return DistributorWiseSalonScreen(
//         distributorName: '',
//       );
//     case CampaignsListScreen.name:
//       return const CampaignsListScreen();
//     case CampaignsResponseScreen.name:
//       return const CampaignsResponseScreen();
//     case TourVisitScreen.name:
//       return const TourVisitScreen();
//     case SetTargetScreen.name:
//       return const SetTargetScreen();
//     case AddFeedBackScreen.name:
//       return const AddFeedBackScreen();
//     case CollectPaymentScreen.name:
//       return const CollectPaymentScreen();
//     case SalonCampaignListScreen.name:
//       return const SalonCampaignListScreen();
//     case SubmitCampaignScreen.name:
//       return const SubmitCampaignScreen();
//     case FinalOrderScreen.name:
//       return const FinalOrderScreen();
//     default:
//       return const SizedBox.shrink();
//   }
// }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
