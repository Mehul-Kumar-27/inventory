// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:inventory/add_medicine.dart';
import 'package:inventory/database/backend_services.dart';
import 'package:inventory/medicine_detail.dart';

import 'package:inventory/models/medicine.dart';
import 'package:inventory/models/medicine_types.dart';
import 'package:inventory/theme/theme_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Index1 extends StatefulWidget {
  const Index1({super.key});

  @override
  State<Index1> createState() => _Index1State();
}

class _Index1State extends State<Index1> {
  bool showingMedicines = false;
  String username = "Us";
  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username")!;
    });
    await getAllMedicineTypes();
  }

  TextEditingController medicineTypeNameController = TextEditingController();
  TextEditingController medicineTypeDescriptionController =
      TextEditingController();
  String dateToday = DateFormat('dd-MM-yyyy').format(DateTime.now());
  getAllMedicineTypes() async {
    print("jhgfhksgfksgfksdgkh");
    medicineTypesList.clear();
    await BackendService.getMedicineTypes(username).then((value) {
      setState(() {
        medicineTypesList = value;
      });
    });
  }

  getAllMedicinesOfParticularType(
      String medicineTypeName, String username) async {
    medicines.clear();
    await BackendService.getAllMedicinesBelongingToAParticularMedicineType(
            username, medicineTypeName)
        .then((value) {
      setState(() {
        medicines = value;
      });
    });
  }

  List<MedicineTypes> medicineTypesList = [];
  List<Medicine> medicines = [];
  @override
  void initState() {
    // TODO: implement initState

    getData();
    super.initState();
  }

  int listIndex = 0;
  @override
  Widget build(BuildContext context) {
    final currentContext = context;
    showScaffoldMessenge(String message) {
      ScaffoldMessenger.of(currentContext)
          .showSnackBar(SnackBar(content: Text(message)));
    }

    return Scaffold(
      body: Stack(
        children: [
          showingMedicines
              ? medicineList(medicineTypesList[listIndex])
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          color: color7,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Welcome",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                                Text(
                                  dateToday,
                                  style: const TextStyle(
                                      fontFamily: "Poppins",
                                      color: Colors.white70,
                                      fontSize: 13),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
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
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                  Text(
                                    medicineTypesList.length.toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
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
                              medicineTypeName: medicineTypeNameController.text,
                              medicineTypeDescription:
                                  medicineTypeDescriptionController.text,
                              medicineTypeQuantity: jsonQuantity.toString(),
                            );

                            String response =
                                await BackendService.addMedicineTypeForUser(
                                    medicineType, username);
                            showScaffoldMessenge(response);
                            setState(() {
                              getAllMedicineTypes();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color7,
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
                            var jsonString = jsonDecode(
                                medicineTypesList[index].medicineTypeQuantity);
                            Map<String, int> quantityMap =
                                Map<String, int>.from(jsonString);
                            LinkedHashMap<String, int> quantityLinkedMap =
                                LinkedHashMap.from(quantityMap);
                            int quantityInMedicineType =
                                quantityLinkedMap.entries.last.value;

                            return GestureDetector(
                              onTap: () async {
                                getAllMedicinesOfParticularType(
                                    medicineTypesList[index].medicineTypeName,
                                    username);
                                setState(() {
                                  listIndex = index;
                                  showingMedicines = true;
                                  // getAllMedicinesOfParticularType(
                                  //     medicineTypesList[index]
                                  //         .medicineTypeName);
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Material(
                                  elevation: 10,
                                  child: ListTile(
                                    title: Text(
                                      medicineTypesList[index].medicineTypeName,
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    trailing: Text("$quantityInMedicineType"),
                                    subtitle: Text(
                                      medicineTypesList[index]
                                          .medicineTypeDescription,
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
        ],
      ),
    );
  }

  Widget medicineList(MedicineTypes medicineTypes) {
    bool isSearching = false;
    List<Medicine> filterMedicines = medicines;
    searchByName(String medicineName) {
      setState(() {
        if (medicineName == "All") {
          setState(() {
            medicines = filterMedicines;
          });
        } else {
          medicines = filterMedicines
              .where((med) =>
                  med.medicineName.toLowerCase().contains(medicineName))
              .toList();
        }
      });
    }

    final TextEditingController searchController = TextEditingController();
    String _selectedSortOption = 'Sort by Name';
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    getAllMedicineTypes();
                    showingMedicines = false;
                  });
                },
                icon: const Icon(Icons.arrow_back)),
            const SizedBox(width: 40),
            Flexible(
              flex: 3,
              child: Text(
                "Add Medicine to ${medicineTypes.medicineTypeName} category",
                style: Theme.of(context).textTheme.headline4,
                overflow: TextOverflow.clip,
              ),
            ),
            IconButton(
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return popupForm(medicineTypes, context);
                      });
                },
                icon: const Icon(
                  Icons.add_box,
                  color: Colors.green,
                  size: 30,
                ))
          ],
        ),
        Container(
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            color: Colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: 'Enter Name to Search...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: DropdownButton<String>(
                  items: const [
                    DropdownMenuItem<String>(
                      value: 'quantity',
                      child: Text('Sort by quantity'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'name',
                      child: Text('Sort by name'),
                    ),
                  ],
                  onChanged: (value) {},
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  underline: const SizedBox.shrink(),
                  dropdownColor: Colors.white,
                  elevation: 0,
                  iconEnabledColor: Colors.white,
                ),
              ),
              const SizedBox(width: 8.0),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    searchByName(searchController.text.toLowerCase());
                    isSearching = !isSearching;
                    print(isSearching);
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: medicines.length,
                itemBuilder: (context, index) {
                  var jsonString =
                      jsonDecode(filterMedicines[index].medicineQuantity);
                  Map<String, int> quantityMap =
                      Map<String, int>.from(jsonString);
                  LinkedHashMap<String, int> quantityLinkedMap =
                      LinkedHashMap.from(quantityMap);
                  int quantityInMedicine = quantityLinkedMap.entries.last.value;

                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MedicineDetail(
                                  medicine: medicines[index],
                                  username: username)));
                    },
                    leading: const Icon(
                      Icons.medication,
                      color: color9,
                    ),
                    title: Text(
                      medicines[index].medicineName,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      medicines[index].medicineExpireDate,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w400),
                    ),
                    subtitle: Text("Quantity : $quantityInMedicine"),
                  );
                })),
      ],
    );
  }

  Widget popupForm(MedicineTypes medicineTypes, BuildContext context) {
    DateTime _selectedDate;
    TextEditingController medicineExpiryDateController =
        TextEditingController();
    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),
      );

      if (picked != null) {
        setState(() {
          _selectedDate = picked;

          medicineExpiryDateController.text =
              _selectedDate.toString().split(" ")[0];
        });
      }
    }

    showScaffoldMessenge(String message) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }

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
              GestureDetector(
                onTap: () {
                  selectDate(context);
                },
                child: TextFormField(
                  enabled: false,
                  controller: medicineExpiryDateController,
                  decoration: const InputDecoration(
                    labelText: 'Expiry Date',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (medicineNameController.text.isEmpty ||
                      medicineDescriptionController.text.isEmpty ||
                      medicineQuantityController.text.isEmpty ||
                      medicineExpiryDateController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please fill all the fields'),
                    ));
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const SizedBox(
                            height: 50,
                            width: 50,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        });
                    print(medicineNameController.text);
                    print(medicineDescriptionController.text);
                    print(medicineQuantityController.text);
                    int quantityNumber =
                        int.parse(medicineQuantityController.text);
                    Map<String, int> q = {dateToday: quantityNumber};
                    print(q);
                    LinkedHashMap<String, int> quantityLinkedMap =
                        LinkedHashMap.from(q);
                    print("ugfdjhdsdgfgvdsv");
                    var jsonQuantity = jsonEncode(quantityLinkedMap);
                    print(jsonQuantity);
                    print(quantityLinkedMap);
                    print(medicineExpiryDateController.text);
                    Medicine m = Medicine(
                        medicineName: medicineNameController.text,
                        medicineDescription: medicineDescriptionController.text,
                        medicineQuantity: jsonQuantity.toString(),
                        medicineType: medicineTypes.medicineTypeName,
                        medicineExpireDate: medicineExpiryDateController.text);

                    String addMedicineResponse = await BackendService
                        .addMedicineInAParticularMedicineType(m, username);

                    if (addMedicineResponse == "Medicine added successfully") {
                      var response = await BackendService
                          .getMedicineTypeForAddingTheMedicine(
                              medicineTypes.medicineTypeName, username);
                      print(response);
                      var jsonQuantityfromMed = jsonDecode(response);
                      print(jsonQuantityfromMed);
                      MedicineTypes medType =
                          MedicineTypes.fromJson(jsonQuantityfromMed);
                      var quantity = jsonDecode(medType.medicineTypeQuantity);
                      Map<String, int> mapMed = Map<String, int>.from(quantity);
                      LinkedHashMap<String, int> linkedHashMapQuantiy =
                          LinkedHashMap.from(mapMed);
                      if (linkedHashMapQuantiy.containsKey(dateToday)) {
                        linkedHashMapQuantiy.update(
                            dateToday, (value) => value + 1);
                      } else {
                        int amount =
                            linkedHashMapQuantiy.entries.last.value + 1;
                        final newDateEntry = <String, int>{dateToday: amount};
                        linkedHashMapQuantiy.addEntries(newDateEntry.entries);
                      }

                      var newQuantityJson = jsonEncode(linkedHashMapQuantiy);
                      print(newQuantityJson);
                      await BackendService
                          .updateAParticularMedicineTypeQuantity(
                              medicineTypes.medicineTypeName,
                              username,
                              newQuantityJson.toString());
                    }
                    ////////////////////////////////////////////

                    getAllMedicinesOfParticularType(
                        medicineTypes.medicineTypeName, username);

                    Navigator.pop(context);

                    medicineNameController.clear();
                    medicineDescriptionController.clear();
                    medicineQuantityController.clear();
                    Navigator.pop(context);

                    print(
                        "${addMedicineResponse}qwertyuiplk!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1");
                    showScaffoldMessenge(addMedicineResponse);
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
