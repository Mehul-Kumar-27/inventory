import 'package:http/http.dart' as http;

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
}
