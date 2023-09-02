import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shimmers/screens/attendance/applyLeaveScreen.dart';
import 'package:shimmers/screens/attendance/leavesScreen.dart';
import 'package:shimmers/screens/campaigns/campaignsListScreen.dart';
import 'package:shimmers/screens/campaigns/campaignsResponseScreen.dart';
import 'package:shimmers/screens/distributors/distributorWiseSalonScreen.dart';
import 'package:shimmers/screens/home/mainScreen.dart';
import 'package:shimmers/screens/profile/profileScreen.dart';
import 'package:shimmers/screens/salons/addSalon/addFinalSalonScreen.dart';
import 'package:shimmers/screens/salons/addSalon/addSalonBasicDetailsScreen.dart';
import 'package:shimmers/screens/salons/addSalon/addSalonPersonalDetailsScreen.dart';
import 'package:shimmers/screens/salons/salonDetails/salonDetailsScreen.dart';
import 'package:shimmers/screens/salons/salonList/salonListScreen.dart';
import 'package:shimmers/screens/tourVisit/tourVisitScreen.dart';
import 'package:shimmers/screens/userAuth/LoginScreen.dart';
import 'package:shimmers/screens/userAuth/PasswordResetScreen.dart';
import 'package:shimmers/screens/userAuth/PasswordScreen.dart';

import 'constant/conditional_route_widget.dart';
import 'constant/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      onGenerateRoute: (RouteSettings settings) {
        // A custom `fadeThrough` route transition animation.
        return Routes.fadeThrough(settings, (context) {
          // Wrap widgets with another widget based on the route.
          // Wrap the page with the ResponsiveScaledBox for desired pages.
          return ConditionalRouteWidget(
              routesExcluded: const [
                // TypographyPage.name
              ], // Excluding a page from AutoScale.
              builder: (context, child) => MaxWidthBox(
                    // A widget that limits the maximum width.
                    // This is used to create a gutter area on either side of the content.
                    maxWidth: 1200,
                    background: Container(color: const Color(0xFFF5F5F5)),
                    child: ResponsiveScaledBox(
                        // ResponsiveScaledBox renders its child with a FittedBox set to the `width` value.
                        // Set the fixed width value based on the active breakpoint.
                        width: ResponsiveValue<double>(context,
                            conditionalValues: [
                              Condition.equals(name: MOBILE, value: 450),
                              Condition.between(
                                  start: 800, end: 1100, value: 800),
                              Condition.between(
                                  start: 1000, end: 1200, value: 1000),
                              // There are no conditions for width over 1200
                              // because the `maxWidth` is set to 1200 via the MaxWidthBox.
                            ]).value,
                        child: child!),
                  ),
              child: BouncingScrollWrapper.builder(
                  context, buildPage(settings.name ?? ''),
                  dragWithMouse: true));
        });
      },
      title: 'Shimmers',
      supportedLocales: [Locale('en')],
      home: MainScreen(),
    );
  }

  Widget buildPage(String name) {
    switch (name) {
      case '/':
        return const LoginScreen();
      case PasswordScreen.name:
        return const PasswordScreen();
      case PasswordResetScreen.name:
        return const PasswordResetScreen();
      case MainScreen.routeName:
        return const MainScreen();
      case ProfileScreen.name:
        return const ProfileScreen();
      case LeavesScreen.name:
        return const LeavesScreen();
      case ApplyLeaveScreen.name:
        return const ApplyLeaveScreen();
      case SalonListScreen.name:
        return const SalonListScreen();
      case AddSalonBasicDetailsScreen.name:
        return const AddSalonBasicDetailsScreen();
      case AddSalonPersonalDetailsScreen.name:
        return const AddSalonPersonalDetailsScreen(
          salonCategory: "",
          salonName: "",
        );
      case AddFinalSalonScreen.name:
        return const AddFinalSalonScreen();
      case SalonDetailsScreen.name:
        return const SalonDetailsScreen();
      case DistributorWiseSalonScreen.name:
        return DistributorWiseSalonScreen(
          distributorName: '',
        );
      case CampaignsListScreen.name:
        return const CampaignsListScreen();
      case CampaignsResponseScreen.name:
        return const CampaignsResponseScreen();
      case TourVisitScreen.name:
        return const TourVisitScreen();
      default:
        return const SizedBox.shrink();
    }
  }
}
