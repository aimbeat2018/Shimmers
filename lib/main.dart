import 'package:flutter/material.dart';
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/max_width_box.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_scaled_box.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:shimmers/screens/LoginScreen.dart';
import 'package:shimmers/screens/PasswordScreen.dart';

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
      // theme: ThemeData(
      //   // This is the theme of your application.
      //   //
      //   // Try running your application with "flutter run". You'll see the
      //   // application has a blue toolbar. Then, without quitting the app, try
      //   // changing the primarySwatch below to Colors.green and then invoke
      //   // "hot reload" (press "r" in the console where you ran "flutter run",
      //   // or simply save your changes to "hot reload" in a Flutter IDE).
      //   // Notice that the counter didn't reset back to zero; the application
      //   // is not restarted.
      //   primarySwatch: Colors.blue,
      // ),
      home: LoginScreen(),
    );
  }

  Widget buildPage(String name) {
    switch (name) {
      case '/':
        return const LoginScreen();
      case PasswordScreen.name:
        return const PasswordScreen();
      // case HomeScreen.name:
      //   return     HomeScreen();
      // case OtpScreen.name:
      //   return const OtpScreen();
      // case ProfileScreen.name:
      //   return const ProfileScreen();
        default:
        return const SizedBox.shrink();
    }
  }
}
