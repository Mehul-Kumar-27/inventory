import 'dart:convert';

import 'package:http/http.dart' as http;
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
      'username': username
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
}
