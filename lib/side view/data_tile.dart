import 'package:flutter/material.dart';

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
        style: const TextStyle(
            fontFamily: "Poppins", color: Colors.white, fontSize: 18),
      ),
      subtitle: const Text(
        "Admin",
        style: TextStyle(
            fontFamily: "Poppins", fontSize: 12, color: Colors.white54),
      ),
    );
  }
}
