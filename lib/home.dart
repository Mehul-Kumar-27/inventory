import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory/add_medicine.dart';
import 'package:inventory/database/db.dart';
import 'package:inventory/models/medicine_types.dart';
import 'package:inventory/theme/theme_constants.dart';

class Index1 extends StatefulWidget {
  const Index1({super.key});

  @override
  State<Index1> createState() => _Index1State();
}

class _Index1State extends State<Index1> {
  TextEditingController medicineTypeNameController = TextEditingController();
  TextEditingController medicineTypeDescriptionController =
      TextEditingController();
  String dateToday = DateFormat('dd-MM-yyyy').format(DateTime.now());
  getAllMedicineTypes() async {
    await MedicineTypeDataBase.instance.readAllMedicineTypes().then((value) {
      setState(() {
        medicineTypesList = value;
      });
    });
  }

  List<MedicineTypes> medicineTypesList = [];
  @override
  void initState() {
    // TODO: implement initState
    getAllMedicineTypes();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
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
                  Text(dateToday, style: Theme.of(context).textTheme.headline6),
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
                List<Map<String, String>> quantity = [
                  {
                    '''"$dateToday"''': "0",
                  },
                ];

                MedicineTypes medicineType = MedicineTypes(
                  name: medicineTypeNameController.text,
                  description: medicineTypeDescriptionController.text,
                  quantity: quantity.toString(),
                );

                final String jsonString = medicineType.quantity;
                final List<Map<String, dynamic>> resultList =
                    List<Map<String, dynamic>>.from(jsonDecode(jsonString));
                final int myValue = resultList[0].values.first;
                print(myValue);
                await MedicineTypeDataBase.instance
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                final String jsonString =
                    medicineTypesList[index].quantity.replaceAll("\\", "");
                final List<Map<String, dynamic>> resultList =
                    List<Map<String, dynamic>>.from(jsonDecode(jsonString));
                final int myValue = resultList[0].values.first;

                return GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddMedicineToType(
                          medicineTypes: medicineTypesList[index],
                        ),
                      ),
                    );
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
                          myValue.toString(),
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
    );
  }
}

