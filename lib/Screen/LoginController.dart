import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:global_configuration/global_configuration.dart';

import 'baseUrlPage.dart';
import 'model/loginmodel.dart';


class LoginController extends GetxController {
  var isLoading = false.obs;
  List<Loginmodel> loginModels = [];

 logins(String email, String password,String Url) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      isLoading(true);

      var url = "${Url}getin";
      print(url);

      final response = await http.put(
        Uri.parse(url),
        body: jsonEncode({"userid": email,
          "password": password,
          "count": 0
        }),
        headers: {
          'Content-Type': 'application/json',
                },
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());

        loginModels = [data]
            .map((taskJson) => Loginmodel.fromJson(taskJson))
            .toList();
        print('Login successful: ${[data]}');

        Get.toNamed('/MainScreen', arguments: loginModels);
        /*Get.toNamed('/MainScreen', arguments: {
          'id': 0,
          'loginModels': loginModels,
        });*/
        await prefs.setString('UserName', email);
        await prefs.setString('PassWord', password);
      } else {
        print('Login failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }
}
