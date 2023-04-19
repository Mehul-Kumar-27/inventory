import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:inventory/models/medicine.dart';
import 'package:inventory/models/medicine_types.dart';

class BackendService {
  static Future<String> authenticateUser(
      String userName, String userPassword) async {
    var url =
        "https://weightless-dimensio.000webhostapp.com/authenticateUser.php";

    var response = await http.post(Uri.parse(url), body: {
      'userName': userName,
      'userPassword': userPassword,
    });
    if (response.statusCode == 200) {
      if (response.body == 'Authenticated') {
        print(response.body);
        return "Authenticated";
      } else {
        print(response.body);

        return "Authentication Failed";
      }
    } else {
      return "error";
    }
  }

  static Future<String> addUser(String userName, String userPassword) async {
    var url = "https://weightless-dimensio.000webhostapp.com/addUser.php";
    var response = await http.post(Uri.parse(url),
        body: {'userName': userName, 'userPassword': userPassword});
    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      print(response.body);
      return "error";
    }
  }

  static Future<String> addMedicineTypeForUser(
      MedicineTypes medicineTypes, String username) async {
    var url =
        "https://weightless-dimensio.000webhostapp.com/addMedicineTypeForUser.php";
    var response = await http.post(Uri.parse(url), body: {
      'medicineTypeName': medicineTypes.medicineTypeName,
      'medicineTypeDescription': medicineTypes.medicineTypeDescription,
      'medicineTypeQuantity': medicineTypes.medicineTypeQuantity,
      'username': username,
    });

    if (response.statusCode == 200) {
      print(response.statusCode);

      if (response.body == 'Medicine type added successfully') {
        print('Medicine type added successfully');
        return "Sucess";
      } else {
        return 'Error adding medicine type: ${response.statusCode}';
      }
    } else {
      print(response.statusCode);
      print('Error adding medicine type: ${response.reasonPhrase}');
      return 'Error adding medicine type: ${response.reasonPhrase}';
    }
  }

  static Future<List<MedicineTypes>> getMedicineTypes(String username) async {
    print(username);
    final url = Uri.parse(
        'https://weightless-dimensio.000webhostapp.com/getAllMedicineTypesForTheUser.php');
    final response = await http.post(
      url,
      body: {
        'username': username,
      },
    );

    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body) as List<dynamic>;
      print(jsonList);
      return jsonList.map((json) => MedicineTypes.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load medicine types');
    }
  }

  static Future<String> addMedicineInAParticularMedicineType(
      Medicine medicine, String username) async {
    var url =
        "https://weightless-dimensio.000webhostapp.com/addMedicineInAParticularMedicineType.php";
    var response = await http.post(Uri.parse(url), body: {
      'medicineName': medicine.medicineName,
      'medicineDescription': medicine.medicineDescription,
      'medicineQuantity': medicine.medicineQuantity,
      'medicineType': medicine.medicineType,
      'username': username,
      'medicineExpireDate': medicine.medicineExpireDate,
    });

    if (response.statusCode == 200) {
      if (response.body == 'Medicine added successfully') {
        return "Medicine added successfully";
      } else if (response.body ==
          'Medicine type does not exist for this user') {
        return 'Error: Medicine type does not exist for this user';
      } else if (response.body ==
          "Medicine name already exists for this user") {
        return "Medicine name already exists for this user";
      } else {
        return 'Error adding medicine: ${response.body}';
      }
    } else {
      return 'Error adding medicine: ${response.reasonPhrase}';
    }
  }

  static Future<String> getMedicineTypeForAddingTheMedicine(
      String medicineTypeName, String username) async {
    const url =
        "https://weightless-dimensio.000webhostapp.com/getAParticularMedicineTypeForAParticularUser.php";
    var response = await http.post(Uri.parse(url),
        body: {"medicineTypeName": medicineTypeName, "username": username});

    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      throw Exception('Failed to get medicine type: ${response.statusCode}');
    }
  }

  static Future<String> updateAParticularMedicineTypeQuantity(
      String medicineTypeName, String username, String newQuantity) async {
    const url =
        "https://weightless-dimensio.000webhostapp.com/updateAParticularMedicineTypeQuantity.php";
    var response = await http.post(Uri.parse(url), body: {
      "medicineTypeName": medicineTypeName,
      "username": username,
      "newQuantity": newQuantity
    });

    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      print(response.body);
      print(response.statusCode);
      throw Exception(
          'Failed to update medicine type quantity: ${response.statusCode}');
    }
  }

  static Future<List<Medicine>>
      getAllMedicinesBelongingToAParticularMedicineType(
          String username, String medicineTypeName) async {
    print(username);
    print(medicineTypeName);
    const url =
        "https://weightless-dimensio.000webhostapp.com/getAllMedicinesBelongingToAParticularMedicineType.php";
    final response = await http.post(
      Uri.parse(url),
      body: {'username': username, 'medicineTypeName': medicineTypeName},
    );

    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body) as List<dynamic>;
      print(jsonList);
      return jsonList.map((json) => Medicine.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load medicine types');
    }
  }

  static Future<String> updateMedicine(Medicine m, String username) async {
    const url =
        'https://weightless-dimensio.000webhostapp.com/updateMedicineForAUser.php';
    final response = await http.post(Uri.parse(url), body: {
      'medicineName': m.medicineName,
      'medicineDescription': m.medicineDescription,
      'medicineQuantity': m.medicineQuantity,
      'medicineType': m.medicineType,
      'medicineExpireDate': m.medicineExpireDate,
      'username': username,
    });

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to update medicine');
    }
  }
}
