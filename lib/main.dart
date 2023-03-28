import 'package:flutter/material.dart';
import 'package:inventory/login.dart';
import 'package:inventory/theme/theme_constants.dart';
import 'package:inventory/theme/theme_manager.dart';

void main() {
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

  @override
  void dispose() {
    // TODO: implement dispose
    themeManager.removeListener(() {
      themeListner();
    });
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    themeManager.addListener(() {
      themeListner();
    });
    super.initState();
  }

  themeListner() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lighTheme,
      darkTheme: darkTheme,
      themeMode: themeManager.themeMode,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: LoginScreen(),
    );
  }
}


