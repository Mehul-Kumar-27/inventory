// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventory/database/db.dart';
import 'package:inventory/models/medicine_types.dart';
import 'package:intl/intl.dart';
import 'package:inventory/theme/theme_constants.dart';
import 'package:inventory/theme/theme_manager.dart';
import 'package:sqflite/sqflite.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ThemeManager themeManager = ThemeManager();
  TextEditingController medicineTypeNameController = TextEditingController();
  TextEditingController medicineTypeDescriptionController =
      TextEditingController();

  void initState() {
    // TODO: implement initState
    themeManager.addListener(() {
      themeListner();
    });

    getAllMedicineTypes();
    super.initState();
  }

  themeListner() {
    if (mounted) {
      setState(() {});
    }
  }

  getAllMedicineTypes() async {
    await MedicineDataBase.instance.readAllMedicineTypes().then((value) {
      setState(() {
        medicineTypesList = value;
      });
    });
  }

  List<MedicineTypes> medicineTypesList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.headline3,
        ),
        actions: [
          Switch(
              value: themeManager.themeMode == ThemeMode.dark,
              onChanged: (newValue) {
                themeManager.toggleTheme(newValue);
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Text(
                        "Welcome",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Text(DateFormat('yyyy-MM-dd').format(DateTime.now()),
                          style: Theme.of(context).textTheme.headline6),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.156,
                    width: MediaQuery.of(context).size.width * 0.457,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                            color: color1, blurRadius: 5, offset: Offset(0, 3)),
                        BoxShadow(
                            color: color1, blurRadius: 5, offset: Offset(3, 0))
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Medicine Types",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Text(
                            medicineTypesList.length.toString(),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: medicineTypeNameController,
                obscureText: false,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: medicineTypeDescriptionController,
                obscureText: false,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    MedicineTypes medicineType = MedicineTypes(
                      name: medicineTypeNameController.text,
                      description: medicineTypeDescriptionController.text,
                      quantity: 0,
                    );
                    await MedicineDataBase.instance
                        .create(medicineType)
                        .then((value) {
                      medicineTypeNameController.clear();
                      medicineTypeDescriptionController.clear();
                      getAllMedicineTypes();
                      print("Created!!!!!!!!!!1");
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Add Medicine Type",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: medicineTypesList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        await MedicineDataBase.instance
                            .deleteMedicineType(medicineTypesList[index].id!)
                            .then((value) {
                          getAllMedicineTypes();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          elevation: 10,
                          child: ListTile(
                            title: Text(
                              medicineTypesList[index].name,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            trailing: Text(
                              medicineTypesList[index].quantity.toString(),
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            subtitle: Text(
                              medicineTypesList[index].description,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
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

class ContainerBoxWidget extends StatelessWidget {
  String text;
  ContainerBoxWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.3,
      decoration: BoxDecoration(
          color: color1,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(1),
              spreadRadius: 4,
              blurRadius: 5,
              offset: const Offset(3, 3),
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.headline3,
          )
        ],
      ),
    );
  }
}
