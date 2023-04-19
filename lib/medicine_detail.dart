// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';
import 'dart:convert';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:inventory/database/backend_services.dart';

import 'package:inventory/models/medicine.dart';
import 'package:inventory/theme/theme_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicineDetail extends StatefulWidget {
  Medicine medicine;
  String username;
  MedicineDetail({
    Key? key,
    required this.medicine,
    required this.username,
  }) : super(key: key);

  @override
  State<MedicineDetail> createState() => _MedicineDetailState();
}

class _MedicineDetailState extends State<MedicineDetail> {
  List<charts.Series<MapEntry<String, int>, DateTime>> seriesList = [
    charts.Series<MapEntry<String, int>, DateTime>(
      id: 'Quantity',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (_, __) => DateTime(0, 0, 0),
      measureFn: (_, __) => 0,
      data: [],
    ),
  ];

  final dateFormat = DateFormat('dd-MM-yyyy');
  prepareChart() async {
    final data = Map<String, int>.from(
            jsonDecode(widget.medicine.medicineQuantity))
        .map((key, value) => MapEntry(dateFormat.parse(key).toString(), value))
        .entries
        .toList();

    setState(() {
      seriesList.add(
        charts.Series<MapEntry<String, int>, DateTime>(
          id: 'Quantity',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (entry, _) => DateTime.parse(entry.key),
          measureFn: (entry, _) => entry.value,
          data: data,
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();

    prepareChart();
  }

  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    String name = widget.medicine.medicineName;
    String desc = widget.medicine.medicineDescription;
    String type = widget.medicine.medicineType;
    String exp = widget.medicine.medicineExpireDate;
    var jsonString = jsonDecode(widget.medicine.medicineQuantity);
    Map<String, int> quantityMap = Map<String, int>.from(jsonString);
    LinkedHashMap<String, int> quantityLinkedMap =
        LinkedHashMap.from(quantityMap);
    int quantityInMedicine = quantityLinkedMap.entries.last.value;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
                const Text(
                  "Medicine Details",
                  style: TextStyle(
                      fontSize: 20, color: color7, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () async {
                          setState(() {
                            isEditing = true;
                          });
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return EditMedicine(
                                  m: widget.medicine,
                                );
                              });
                        },
                        icon: const Icon(
                          Icons.edit_document,
                          color: color6,
                        ))
                  ],
                ),
              ],
            ),
            if (seriesList.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Material(
                  elevation: 15,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: charts.TimeSeriesChart(
                        seriesList,
                        animate: true,
                        dateTimeFactory: const charts.LocalDateTimeFactory(),
                        primaryMeasureAxis: const charts.NumericAxisSpec(
                          tickProviderSpec: charts.BasicNumericTickProviderSpec(
                              zeroBound: false),
                        ),
                        domainAxis: const charts.DateTimeAxisSpec(
                          tickFormatterSpec:
                              charts.AutoDateTimeTickFormatterSpec(
                            day: charts.TimeFormatterSpec(
                                format: 'd', transitionFormat: 'dd/MM/yyyy'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(
              height: 40,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  TextWidget(field: "Medicine Name", name: name),
                  TextWidget(field: "Medicine Description", name: desc),
                  TextWidget(field: "Type", name: type),
                  TextWidget(field: "Expiry Date", name: exp),
                  TextWidget(
                      name: quantityInMedicine.toString(),
                      field: "Present Quantity"),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({super.key, required this.name, required this.field});

  final String name;
  final String field;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          RichText(
              text: TextSpan(
            text: "$field : ",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            children: <TextSpan>[
              TextSpan(
                text: name,
                style: const TextStyle(
                  color: color7,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}

class EditMedicine extends StatefulWidget {
  Medicine m;
  EditMedicine({
    Key? key,
    required this.m,
  }) : super(key: key);

  @override
  State<EditMedicine> createState() => _EditMedicineState();
}

class _EditMedicineState extends State<EditMedicine> {
  String username = "Us";
  TextEditingController medicineNameController = TextEditingController();
  TextEditingController medicineDescriptionController = TextEditingController();
  TextEditingController medicineQuantityController = TextEditingController();
  TextEditingController medicineExpiryDateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

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

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username")!;
    });
  }

  String dateToday = DateFormat('dd-MM-yyyy').format(DateTime.now());

  @override
  void initState() {
    // TODO: implement initState
    medicineNameController.text = widget.m.medicineName;
    medicineDescriptionController.text = widget.m.medicineDescription;
    medicineQuantityController.text = widget.m.medicineQuantity;
    medicineExpiryDateController.text = widget.m.medicineExpireDate;
    getData();
    super.initState();
  }

  bool quantityError = false;

  @override
  Widget build(BuildContext context) {
    var jsonString = jsonDecode(widget.m.medicineQuantity);
    Map<String, int> quantityMap = Map<String, int>.from(jsonString);
    LinkedHashMap<String, int> quantityLinkedMap =
        LinkedHashMap.from(quantityMap);
    int quantityInMedicine = quantityLinkedMap.entries.last.value;
    setState(() {
      if (quantityError == false) {
        medicineQuantityController.text = quantityInMedicine.toString();
        quantityError = true;
      }
    });

    return Material(
      color: Colors.transparent,
      child: Center(
        child:
            // Write code to create a round container with radius 30

            SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.8,
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Material(
                    elevation: 10,
                    shape: const CircleBorder(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                FormWidget(
                  controller: medicineNameController,
                  labelText: "Name",
                ),
                FormWidget(
                  controller: medicineDescriptionController,
                  labelText: "Description",
                ),
                FormWidget(
                  controller: medicineQuantityController,
                  labelText: "Quantity",
                ),
                GestureDetector(
                  onTap: () {
                    selectDate(context);
                  },
                  child: FormWidget(
                      controller: medicineExpiryDateController,
                      labelText: "Expiry Date"),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (medicineNameController.text.isEmpty ||
                          medicineDescriptionController.text.isEmpty ||
                          medicineQuantityController.text.isEmpty ||
                          medicineExpiryDateController.text.isEmpty) {
                        showScaffoldMessenge("Please fill all the fields");
                      } else {
                        var quantity = jsonDecode(widget.m.medicineQuantity);
                        Map<String, int> mapMed =
                            Map<String, int>.from(quantity);
                        LinkedHashMap<String, int> linkedHashMapQuantiy =
                            LinkedHashMap.from(mapMed);
                        if (linkedHashMapQuantiy.containsKey(dateToday)) {
                          linkedHashMapQuantiy.update(
                              dateToday,
                              (value) =>
                                  int.parse(medicineQuantityController.text));
                        } else {
                          int amount =
                              int.parse(medicineQuantityController.text);
                          final newDateEntry = <String, int>{dateToday: amount};
                          linkedHashMapQuantiy.addEntries(newDateEntry.entries);
                        }

                        var newQuantityJson = jsonEncode(linkedHashMapQuantiy);
                        print(newQuantityJson);

                        Medicine medicine = Medicine(
                          medicineName: medicineNameController.text,
                          medicineDescription:
                              medicineDescriptionController.text,
                          medicineQuantity: newQuantityJson.toString(),
                          medicineExpireDate: medicineExpiryDateController.text,
                          medicineType: widget.m.medicineType,
                        );

                        String response = await BackendService.updateMedicine(
                            medicine, username);
                        showScaffoldMessenge(response);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Update Medicine"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FormWidget extends StatelessWidget {
  const FormWidget(
      {super.key, required this.controller, required this.labelText});

  final TextEditingController controller;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: TextFormField(
        enabled: labelText == "Expiry Date" ? false : true,
        controller: controller,
        keyboardType:
            labelText == "Quantity" ? TextInputType.phone : TextInputType.text,
        decoration: InputDecoration(
          labelText: labelText,
        ),
      ),
    );
  }
}
