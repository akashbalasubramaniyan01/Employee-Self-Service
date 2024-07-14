import 'dart:convert';

import 'package:employee_self_service/Screen/ListPermissionPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'model/loginmodel.dart';


class FormController extends GetxController {
  var empCode = ''.obs;
  var empName = ''.obs;
  var requestDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  var noOfHrs = ''.obs;
  var timeFrom = '09:30:00'.obs;
  var timeTo = '11:00:00'.obs;
  var purpose = ''.obs;
  var remarks = ''.obs;
  var docType = 'P'.obs;
  //final List<loginModel[0]> loginModel[0] = Get.arguments[0];
  final List<Loginmodel> loginModel = Get.arguments;
  var historyList = [].obs;
  var PermissionList = [].obs;
  var isLoading = true.obs;
  var urls = ''.obs;
  var totalHours = 0.0.obs;
  final TotalHours = TextEditingController();
  @override
  void onInit() {

    super.onInit();
    Url().then((_) {
      fetchHistory();
      ListPermmisions();
    });

  }

  void calculateHours() {
    if (timeFrom.isNotEmpty && timeTo.isNotEmpty) {
      DateTime fromTime = DateFormat('HH:mm:ss').parse(timeFrom.value);
      DateTime toTime = DateFormat('HH:mm:ss').parse(timeTo.value);

      Duration difference = toTime.difference(fromTime);
      totalHours.value = difference.inMinutes / 60.0;
      TotalHours.text =  totalHours.value.toString();
    } else {
      totalHours.value = 0.0;
    }
  }
  Url() async {
    final prefs = await SharedPreferences.getInstance();
      urls.value = prefs.getString('url') ?? "";
  }

  ApprovePermissioncall(int docno) async {
    final String url = '${urls}podapprove/';

    print(url);
    final  headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginModel[0].jwt}'
    };
  //var intValueConvert = int.tryParse(docno);

    final  body = {
      "docno" : docno,
      "authtype": "A"

    };
    print(body);
    final http.Response response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: json.encode(body),
    );

    String message;
    if (response.statusCode == 200) {
      message = 'Leave Approved successfully.';
      var jsonResponse = json.decode(response.body);

      Get.showSnackbar(
        GetSnackBar(
          message: jsonResponse['message'],
          icon: const Icon(Icons.refresh),
          duration: const Duration(seconds: 3),
        ),
      );
      ListPermmisions();
    } else {

      var jsonResponse = json.decode(response.body);
      Get.showSnackbar(
        GetSnackBar(
          message: jsonResponse['error'],
          icon: const Icon(Icons.refresh),
          duration: const Duration(seconds: 3),
        ),
      );
    }


  }
  CancelPermissioncall(int docno) async {
    final String url = '${urls}podcancel';

    print(url);
    final  headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginModel[0].jwt}'
    };
  //var intValueConvert = int.tryParse(docno);

    final  body = {
      "docno" : docno,
    };
    print(body);
    final http.Response response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: json.encode(body),
    );

    String message;
    if (response.statusCode == 200) {
      message = 'Leave Approved successfully.';
      var jsonResponse = json.decode(response.body);

      Get.showSnackbar(
        GetSnackBar(
          message: jsonResponse['message'],
          icon: const Icon(Icons.refresh),
          duration: const Duration(seconds: 3),
        ),
      );
      ListPermmisions();
    } else {

      var jsonResponse = json.decode(response.body);
      Get.showSnackbar(
        GetSnackBar(
          message: jsonResponse['error'],
          icon: const Icon(Icons.refresh),
          duration: const Duration(seconds: 3),
        ),
      );
    }


  }
  void fetchHistory() async {
    try {

      var url = "${urls}viewpodcard/";

      final response = await http.put(
        Uri.parse(url),
        body: jsonEncode({
          "empcode": loginModel[0].data.usrid,
          "DocType": "P",
          "limit": 20,
          "start": 0
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${loginModel[0].jwt}'
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        historyList.value = data['data'];
        isLoading.value = false;
        print('Failed to fetch data${data}');
      } else {
        print('Failed to fetch data');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }
  void ListPermmisions() async {
    try {
      print(loginModel[0].data.usrid);
      print(urls);
      var urlss = "${urls}podyet2approve/";
      print(urlss);
      final response = await http.put(
        Uri.parse(urlss),
        body: jsonEncode({
          "userid": loginModel[0].data.usrid,
          "doctype": "P",
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${loginModel[0].jwt}'
        },
      );


      print(response.statusCode);
      print(jsonEncode({
        "userid": loginModel[0].data.usrid,
        "doctype": "P",
      }));
      print(response.body.toString());
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print('ListPermmisions------------------: $data');
        PermissionList.value = data['data']['data'];
        isLoading.value = false;
        print('ListPermmisions------------------sssssssssssss: ${PermissionList.value}');
      } else {
        print('Failed to fetch data');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }
  void updateRequestDate(DateTime date) {
    requestDate.value = DateFormat('yyyy-MM-dd').format(date);
  }

  CreatePermision() async {


    try {
      var url = "${urls}podrequest/";

      final jsonData = jsonEncode({
        "EmpCode": loginModel[0].data.usrid,
        "EmpName": loginModel[0].data.name,
        "requestdate":requestDate.value,
        "noofhrs": TotalHours.text,
        "timefrom": timeFrom.value,
        "timeto": timeTo.value,
        "Purpose":purpose.value,
        "Remarks": remarks.value,
        "DocType": "P",
      });
      print(jsonData);
      final response = await http.put(
        Uri.parse(url),
        body: jsonData,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${loginModel[0].jwt}'
        },
      );

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        var datas = data['data'];

        Get.showSnackbar(
          const GetSnackBar(
            title: "Insert Leave",
            message: 'Insert Leave Successfully Created',
            icon: Icon(Icons.refresh),
            duration: Duration(seconds: 3),
          ),
        );
        Get.toNamed('/MainScreen', arguments: loginModel,);
       /* Get.toNamed('/MainScreen', arguments: {
          'id': 1,
          'loginModels': loginModel,
        });*/
      } else {
        print('Failed to fetch data');
      }


    } catch (e) {
      print('An error occurred: $e');
    }
  }


}