import 'package:http/http.dart' as http;

class BackendService{
  static  Future authenticateUser(String userName, String userPassword) async {
    var url = "https://weightless-dimensio.000webhostapp.com/authenticateUser.php";

    var response = await http.post(Uri.parse(url), body: {
      'userName': userName,
      'userPassword': userPassword,
    });
    if (response.statusCode == 200) {
      if (response.body == 'Authenticated') {
        print('User authenticated');
      } else {
        print(response.body);
        print('Authentication failed');
      }
    } else {
      print('Failed to authenticate user');
    }
  }
}