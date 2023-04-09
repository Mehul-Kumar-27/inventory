// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inventory/database/backend_services.dart';
import 'package:inventory/home_page.dart';
import 'package:rive/rive.dart';

import 'package:inventory/theme/theme_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late RiveAnimationController _btnController;
  @override
  void initState() {
    _btnController = OneShotAnimation("active", autoplay: false);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        const RiveAnimation.asset("assets/RiveAssets/shapes.riv"),
        Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            bottom: 200,
            left: 100,
            child: Image.asset("assets/Backgrounds/Spline.png")),
        Positioned.fill(
            child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: const SizedBox(),
        )),
        SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Inventory",
                  style: TextStyle(
                      fontFamily: 'Poppins', fontSize: 60, height: 1.2),
                ),
                const Text(
                  "Manage Your Shop like Pro !",
                  style: TextStyle(
                      fontFamily: "Intel",
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                ),
                GestureDetector(
                  onTap: () {
                    _btnController.isActive = true;
                    showGeneralDialog(
                        barrierDismissible: true,
                        barrierLabel: "Sign In",
                        context: context,
                        pageBuilder: (context, _, __) => SignUpWidget());
                  },
                  child: SizedBox(
                    height: 64,
                    width: 260,
                    child: Stack(
                      children: [
                        RiveAnimation.asset(
                          "assets/RiveAssets/button.riv",
                          controllers: [_btnController],
                        ),
                        Positioned.fill(
                            top: 8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.arrow_forward),
                                Text(
                                  "Lets' Login !",
                                  style: TextStyle(fontFamily: "Poppins"),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ))
      ]),
    );
  }
}

class SignUpWidget extends StatefulWidget {
  SignUpWidget({
    super.key,
  });

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  TextEditingController userName = TextEditingController();

  TextEditingController userPassword = TextEditingController();

  bool signIn = true;

  Future<void> login(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString("username", username);
  }

  @override
  Widget build(BuildContext context) {
    final currentContext = context;
    showScaffoldMessenge(String message) {
      ScaffoldMessenger.of(currentContext)
          .showSnackBar(SnackBar(content: Text(message)));
    }

    Future<void> navigateToInventory() async {
      await Navigator.push(
        currentContext,
        MaterialPageRoute(builder: (context) => MyHomePage(title: "Inventory")),
      );
    }

    return Center(
      child: Container(
        height: 620,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              signIn ? "Sign In" : "Login",
                              style: const TextStyle(
                                  fontFamily: "Poppins", fontSize: 30),
                            ),
                          ],
                        ),
                        Positioned(
                          right: 30,
                          left: 300,
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.black,
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Form(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            titleForm("UserName"),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                child: TextFormSignUp(
                                  controller: userName,
                                  icon: const Icon(
                                    Icons.person,
                                    color: color7,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            titleForm("Password"),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                child: TextFormSignUp(
                                  controller: userPassword,
                                  icon: const Icon(
                                    Icons.password,
                                    color: color7,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 10,
                                        shadowColor: color1,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(20),
                                                bottomLeft: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20)))),
                                    onPressed: () async {
                                      String response = "";
                                      if (userName.text.isEmpty ||
                                          userPassword.text.isEmpty) {
                                        showScaffoldMessenge(
                                            "Please Fill In all the details");
                                      } else {
                                        if (signIn) {
                                          response =
                                              await BackendService.addUser(
                                                  userName.text,
                                                  userPassword.text);

                                          if (response == "User exists") {
                                            showScaffoldMessenge(
                                                "The user with username already exists !");
                                          } else if (response ==
                                              "User added successfully") {
                                            await login(userName.text);
                                            navigateToInventory();
                                          } else {
                                            showScaffoldMessenge(
                                                "Error Occured !");
                                          }
                                        } else {
                                          response = await BackendService
                                              .authenticateUser(userName.text,
                                                  userPassword.text);

                                          if (response == "Authenticated") {
                                            await login(userName.text);
                                            navigateToInventory();
                                          } else if (response ==
                                              "Authentication Failed") {
                                            showScaffoldMessenge(
                                                "Please Enter Correct Credentials");
                                          } else {
                                            showScaffoldMessenge(
                                                "Error Occured !");
                                          }
                                        }
                                        userName.clear();
                                        userPassword.clear();
                                      }
                                    },
                                    icon: const Icon(Icons.lock),
                                    label: Text(
                                      signIn ? "Create Account" : "Login",
                                      style: const TextStyle(
                                          fontFamily: "Intel",
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("Or"),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      signIn = !signIn;
                                    });
                                  },
                                  child: Text(
                                    signIn ? "Login" : "Create an account",
                                    style: const TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding titleForm(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Text(
        title,
        style:
            const TextStyle(fontFamily: 'Intel', fontWeight: FontWeight.w700),
      ),
    );
  }
}

class TextFormSignUp extends StatelessWidget {
  TextEditingController controller;
  Icon icon;
  TextFormSignUp({
    Key? key,
    required this.controller,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.purple),
                borderRadius: BorderRadius.circular(40),
                gapPadding: 10,
              ),
              prefixIcon: icon),
        ));
  }
}
