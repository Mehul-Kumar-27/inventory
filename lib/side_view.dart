// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SideView extends StatefulWidget {
  const SideView({super.key});

  @override
  State<SideView> createState() => _SideViewState();
}

class _SideViewState extends State<SideView> {
  Future<void> logOut() async {
    
  }
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
                DataTile(
                  leadingIcon: const Icon(
                    CupertinoIcons.person,
                    color: Colors.white,
                  ),
                  title: "UserName",
                ),
                GestureDetector(
                  onTap: () {
                    logOut();
                  },
                  child: DataTile(
                    leadingIcon: const Icon(
                      CupertinoIcons.person,
                      color: Colors.white,
                    ),
                    title: "UserName",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DataTile extends StatelessWidget {
  String title;
  Icon leadingIcon;
  DataTile({
    Key? key,
    required this.title,
    required this.leadingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          CircleAvatar(backgroundColor: Colors.white24, child: leadingIcon),
      title: Text(
        title,
        style:
            TextStyle(fontFamily: "Poppins", color: Colors.white, fontSize: 15),
      ),
    );
  }
}
