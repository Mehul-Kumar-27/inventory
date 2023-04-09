// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:inventory/home.dart';
import 'package:inventory/side%20view/side_view.dart';
import 'package:sqflite/sqflite.dart';

import 'package:inventory/add_medicine.dart';
import 'package:inventory/database/db.dart';
import 'package:inventory/models/medicine_types.dart';
import 'package:inventory/theme/theme_constants.dart';
import 'package:inventory/theme/theme_manager.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int bottomNavigationIndex = 0;

  List<Widget> pages = const [Index1(), Index1(), Index1()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bottomNavigationIndex == 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 12.0, left: 16.0),
                        child: Text(
                          "Inventory !",
                          style: TextStyle(fontFamily: "Poppins", fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.0, bottom: 10),
                        child: Text(
                          "Manage your shop like Pro",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 15,
                              color: color2),
                        ),
                      ),
                    ],
                  )
                : const Text(""),
            Expanded(child: pages[bottomNavigationIndex]),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: bottomNavigationIndex,
        onTap: (index) {
          setState(() {
            bottomNavigationIndex = index;
          });
        },
        items: const [
          Icon(
            Icons.home,
            size: 30,
            color: color5,
          ),
          Icon(
            Icons.category,
            size: 30,
            color: color5,
          ),
          Icon(
            Icons.history,
            size: 30,
            color: color5,
          ),
        ],
        height: 50,
        color: color7,
        buttonBackgroundColor: color7,
        backgroundColor: color5,
      ),
    );
  }
}

// class ContainerBoxWidget extends StatelessWidget {
//   String text;
//   ContainerBoxWidget({
//     Key? key,
//     required this.text,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.2,
//       width: MediaQuery.of(context).size.width * 0.3,
//       decoration: BoxDecoration(
//           color: color1,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(1),
//               spreadRadius: 4,
//               blurRadius: 5,
//               offset: const Offset(3, 3),
//             ),
//           ]),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Text(
//             text,
//             style: Theme.of(context).textTheme.headline3,
//           )
//         ],
//       ),
//     );
//   }
// }
