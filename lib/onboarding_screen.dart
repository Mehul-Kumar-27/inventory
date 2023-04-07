import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Inventory",
                style:
                    TextStyle(fontFamily: 'Poppins', fontSize: 60, height: 1.2),
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
                      pageBuilder: (context, _, __) => Center(
                            child: Container(
                              height: 620,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Scaffold(
                                backgroundColor: Colors.transparent,
                                body: Column(
                                  children: [
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          "Sign In",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 30),
                                        ),
                                      ],
                                    ),
                                    const SignInForm(),
                                  ],
                                ),
                              ),
                            ),
                          ));
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
        ))
      ]),
    );
  }
}

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text("Username"),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 16, left: 8, right: 8),
                    child: TextFormField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.purple),
                          borderRadius: BorderRadius.circular(10),
                          gapPadding: 10,
                        ),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.purple,
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
