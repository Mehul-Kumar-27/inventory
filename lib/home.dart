// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:inventory/add_medicine.dart';
import 'package:inventory/database/db.dart';
import 'package:inventory/models/medicine.dart';
import 'package:inventory/models/medicine_types.dart';
import 'package:inventory/theme/theme_constants.dart';

class Index1 extends StatefulWidget {
  const Index1({super.key});

  @override
  State<Index1> createState() => _Index1State();
}

class _Index1State extends State<Index1> {
  bool showingMedicines = false;
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

  getAllMedicinesOfParticularType(String medicineType) async {
    await MedicineTypeDataBase.instance
        .readAllMedicineOfMedicineType(medicineType)
        .then((value) {
      medicines.clear();
      medicines = value;
    });
  }

  List<MedicineTypes> medicineTypesList = [];
  List<Medicine> medicines = [];
  @override
  void initState() {
    // TODO: implement initState
    getAllMedicineTypes();
    super.initState();
  }

  int listIndex = 0;
  @override
  Widget build(BuildContext context) {
    return showingMedicines
        ? medicineList(medicineTypesList[listIndex])
        : Column(
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
                        Text(dateToday,
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
                              color: color1,
                              blurRadius: 5,
                              offset: Offset(0, 3)),
                          BoxShadow(
                              color: color1,
                              blurRadius: 5,
                              offset: Offset(3, 0))
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
                      Map<String, int> q = {dateToday: 0};
                      LinkedHashMap<String, int> quantity =
                          LinkedHashMap.from(q);
                      print("ugfdjhdsdgfgvdsv");
                      var jsonQuantity = jsonEncode(quantity);
                      print(jsonQuantity);
                      print(quantity);
                      MedicineTypes medicineType = MedicineTypes(
                        name: medicineTypeNameController.text,
                        description: medicineTypeDescriptionController.text,
                        quantity: jsonQuantity.toString(),
                      );

                      await MedicineTypeDataBase.instance
                          .create(medicineType)
                          .then((value) {
                        medicineTypeNameController.clear();
                        medicineTypeDescriptionController.clear();
                        getAllMedicineTypes();
                        print("Created!!!!!!!!!!1");
                      }).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "Created ${medicineTypeNameController.text}")));
                      });

                      // String medicineTypeQuantity = medicineType.quantity;
                      // print(medicineTypeQuantity);

                      // //String quantityString = quantity.toString();
                      // print("ugfdjhdsdgfgvdsv");
                      // //print(quantityString);
                      // //print(quantity.containsKey('''"$dateToday"'''));
                      // var jsonString = jsonDecode(medicineTypeQuantity);
                      // print(jsonString);

                      // // Map<String, dynamic> decoded = jsonDecode(jsonString);
                      // Map<String, int> n = Map<String, int>.from(jsonString);
                      // print("ugfdjhdsdgfgvdsv");
                      // LinkedHashMap<String, int> newQuantity =
                      //     LinkedHashMap.from(n);
                      // print(newQuantity);
                      // var dateTommorow = "06-04-2023";
                      // print(dateTommorow);

                      // if (newQuantity.containsKey(dateTommorow)) {
                      //   newQuantity.update(dateToday, (value) => value + 1);
                      // } else {
                      //   final newDateEntry = <String, int>{dateTommorow: 5};
                      //   newQuantity.addEntries(newDateEntry.entries);
                      // }
                      // print(newQuantity);

                      // var newJson = jsonEncode(newQuantity);

                      // print(newJson.toString());

                      // var newQuantityJsonDecoded =
                      //     jsonDecode(newJson.toString());
                      // Map<String, int> qu =
                      //     Map<String, int>.from(newQuantityJsonDecoded);
                      // LinkedHashMap<String, int> qup = LinkedHashMap.from(qu);

                      // print(qup.entries.last.value);
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
                      var jsonString =
                          jsonDecode(medicineTypesList[index].quantity);
                      Map<String, int> quantityMap =
                          Map<String, int>.from(jsonString);
                      LinkedHashMap<String, int> quantityLinkedMap =
                          LinkedHashMap.from(quantityMap);
                      int quantityInMedicineType =
                          quantityLinkedMap.entries.last.value;

                      return GestureDetector(
                        onTap: () async {
                          setState(() {
                            listIndex = index;
                            showingMedicines = true;
                            getAllMedicinesOfParticularType(
                                medicineTypesList[index].name);
                          });
                          // await MedicineTypeDataBase.instance
                          //     .deleteMedicineType(medicineTypesList[index].id!)
                          //     .then((value) {
                          //   setState(() {
                          //     getAllMedicineTypes();
                          //   });
                          // });
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
                              trailing: Text("$quantityInMedicineType"),
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

  Widget medicineList(MedicineTypes medicineTypes) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    showingMedicines = false;
                  });
                },
                icon: const Icon(Icons.arrow_back)),
            const SizedBox(width: 40),
            Flexible(
              flex: 3,
              child: Text(
                "Add Medicine to ${medicineTypes.name} category",
                style: Theme.of(context).textTheme.headline4,
                overflow: TextOverflow.clip,
              ),
            ),
            IconButton(
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return popupForm(medicineTypes);
                      });
                },
                icon: const Icon(
                  Icons.add_box,
                  color: Colors.green,
                  size: 30,
                ))
          ],
        ),
        Expanded(
            child: ListView.builder(
                itemCount: medicines.length,
                itemBuilder: (context, index) {
                  var jsonString = jsonDecode(medicines[index].quantity);
                  Map<String, int> quantityMap =
                      Map<String, int>.from(jsonString);
                  LinkedHashMap<String, int> quantityLinkedMap =
                      LinkedHashMap.from(quantityMap);
                  int quantityInMedicine = quantityLinkedMap.entries.last.value;
                  return ListTile(
                    leading: Text(medicines[index].name),
                    trailing: Text("$quantityInMedicine"),
                  );
                }))
      ],
    );
  }

  Widget popupForm(MedicineTypes medicineTypes) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController medicineNameController = TextEditingController();
    TextEditingController medicineDescriptionController =
        TextEditingController();
    TextEditingController medicineQuantityController = TextEditingController();
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: medicineNameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextFormField(
                controller: medicineDescriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: medicineQuantityController,
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  print(medicineNameController.text);
                  print(medicineDescriptionController.text);
                  print(medicineQuantityController.text);
                  int quantityNumber =
                      int.parse(medicineQuantityController.text);
                  Map<String, int> q = {dateToday: quantityNumber};
                  print(q);
                  LinkedHashMap<String, int> quantity = LinkedHashMap.from(q);
                  print("ugfdjhdsdgfgvdsv");
                  var jsonQuantity = jsonEncode(quantity);
                  print(jsonQuantity);
                  print(quantity);

                  if (medicineNameController.text.isEmpty ||
                      medicineDescriptionController.text.isEmpty ||
                      medicineQuantityController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please fill all the fields'),
                    ));
                  } else {
                    Medicine m = Medicine(
                        name: medicineNameController.text,
                        description: medicineDescriptionController.text,
                        quantity: jsonQuantity.toString(),
                        medicineType: medicineTypes.name);

                    await MedicineTypeDataBase.instance
                        .createMedicine(m)
                        .then((value) {
                      print(value.id);
                      print(value.name);
                      print(value.medicineType);
                      print(value.quantity);
                      setState(() {
                        getAllMedicinesOfParticularType(medicineTypes.name);
                      });
                    }).then((value) {
                      Navigator.pop(context);
                    });
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
