import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SideViewTiles extends StatelessWidget {
  const SideViewTiles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16),
          child: Divider(
            color: Colors.white30,
            thickness: 2,
            height: 2,
          ),
        ),
        ListTile(
          onTap: () {},
          leading: SizedBox(
            height: 34,
            width: 34,
            child: RiveAnimation.asset(
              "assets/RiveAssets/icons.riv",
              artboard: "HOME",
              onInit: (artboard) {},
            ),
          ),
          title: const Text(
            "Home",
            style: TextStyle(
                fontFamily: "Poppins", color: Colors.white, fontSize: 15),
          ),
        ),
      ],
    );
  }
}
