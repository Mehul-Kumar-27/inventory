import 'package:flutter/material.dart';
import 'package:inventory/home_page.dart';

import 'package:inventory/login.dart';
import 'package:inventory/onboarding_screen.dart';


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
      if (prefs.getBool('isLoggedIn') == true) {
        isLoggedIn = true;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getSharedPreferences();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lighTheme,
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme,
      themeMode: themeManager.themeMode,
      home: isLoggedIn
          ? MyHomePage(
              title: "Inventory",
            )
          : const OnboardingScreen(),
    );
  }
}
