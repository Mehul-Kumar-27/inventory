// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:inventory/models/medicine_types.dart';

class AddMedicineToType extends StatefulWidget {
  MedicineTypes medicineTypes;
  AddMedicineToType({
    Key? key,
    required this.medicineTypes,
  }) : super(key: key);

  @override
  State<AddMedicineToType> createState() => _AddMedicineToTypeState();
}

class _AddMedicineToTypeState extends State<AddMedicineToType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Add Medicine to ${widget.medicineTypes.name}',
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
