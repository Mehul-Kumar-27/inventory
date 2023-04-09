import 'package:flutter/material.dart';
import 'package:inventory/home_page.dart';

import 'package:inventory/login.dart';
import 'package:inventory/onboarding_screen.dart';
import 'package:inventory/routes/app_routes.dart';
import 'package:inventory/theme/theme_constants.dart';
import 'package:inventory/theme/theme_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // Obtain shared preferences.

  runApp(const MyApp());
}

ThemeManager themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  bool isLoggedIn = false;

  getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getSharedPreferences();

    super.initState();
  }

  String getInitialRoute() {
    if (isLoggedIn) {
      return AppRoutes.homepage;
    } else {
      return AppRoutes.onboarding;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lighTheme,
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme,
      themeMode: themeManager.themeMode,
      initialRoute: getInitialRoute(),
      onGenerateRoute: (route) => getGeneratedRoute(route),
    );
  }

  Route getGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.onboarding:
        return buildRoute(const OnboardingScreen(), settings: settings);

      case AppRoutes.homepage:
        return buildRoute(MyHomePage(title: ""), settings: settings);

      default:
        return buildRoute(const OnboardingScreen(), settings: settings);
    }
  }

  MaterialPageRoute buildRoute(Widget child,
      {required RouteSettings settings}) {
    return MaterialPageRoute(
        settings: settings, builder: (BuildContext context) => child);
  }
}
