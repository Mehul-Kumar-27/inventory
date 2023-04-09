// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:inventory/onboarding_screen.dart';
import 'package:inventory/side%20view/data_tile.dart';
import 'package:inventory/side%20view/side_view_tiles.dart';
import 'package:rive/rive.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SideView extends StatefulWidget {
  const SideView({super.key});

  @override
  State<SideView> createState() => _SideViewState();
}

class _SideViewState extends State<SideView> {
  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('isLoggedIn', false);
      prefs.setString('username', "");
    });

    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        ),
        (route) => false);
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username")!;
    });
  }

  @override
  void initState() {
    getData();

    // TODO: implement initState
    super.initState();
  }

  String username = "Us";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: double.infinity,
          color: const Color.fromRGBO(22, 27, 47, 1),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 32.0, bottom: 8, left: 8, right: 8),
                  child: DataTile(
                    leadingIcon: const Icon(
                      CupertinoIcons.person,
                      color: Colors.white,
                    ),
                    title: username,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Browse",
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ),
                const SideViewTiles()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
