

import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:quickalert/quickalert.dart';
import 'dart:io';

import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/colors.dart';
import 'baseUrlPage.dart';
import 'model/LeaveApproveModel.dart';
import 'model/LeaveDetailsModel.dart';
import 'model/loginmodel.dart';

class LeaveApprovel extends StatefulWidget {
  //final List<Loginmodel> loginModels;
  /*var AllTickets;
  int i;
  String TicketName;
  final VoidCallback onBack;
  final List<LoginModel> loginModels;*/
  LeaveApprovel(/*this.loginModels*//*this.AllTickets,this.i,this.TicketName,this.loginModels,{required this.onBack}*/);

  @override
  State<LeaveApprovel> createState() => _LeaveApprovelState();
}

class _LeaveApprovelState extends State<LeaveApprovel> {
  late String _radioValue ="Open"; //Initial definition of radio button value
  late String choice;

  radioButtonChanges(String? value) {
    setState(() {
      _radioValue = value!;
      switch (value) {
        case 'Open':
          choice = value!;
          break;
        case 'Closed':
          choice = value!;
          break;
        case 'Resolved':
          choice = value!;
          break;
        default:
          choice = "";
      }
      debugPrint(choice); //Debug the choice in console
    });
  }

  TextEditingController  Name  = TextEditingController();
  String AllertName ="";
  bool ActiveButton = false;
  late Timer _timer;
  var AllTickets = [];
  List<dynamic> allTickets = [];
  //var NameAssignList=[];
  List<Map<int, String>> NameAssignList = []; // Sample data
  @override
  void initState() {
    super.initState();
    Url();
  }
  var leaveData;
  String urls="";
  Url() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      urls = prefs.getString('url') ?? "";
    });
    LeaveApprove();
  }

  LeaveApprove() async {
    final List<Loginmodel> loginModels = Get.arguments;
    print(loginModels[0].data.usrid);
    print("loginModels[0].data.usrid");
    try {

      var url = "${urls}leaveyet2approve/${loginModels[0].data.usrid}/";

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${loginModels[0].jwt}'
        },
      );

      print(url);
      print(response.body);

      if (response.statusCode == 200) {
       setState(() {
         var data = jsonDecode(response.body.toString());
         var datas = data['data'];
         print(datas);
         leaveData = LeaveResponse.fromJson(datas);

        // for(var lengthdata in leaveData)
         //print(lengthdata.legnth);

         print('Data fetched successfully: $allTickets');
       });
      } else {
        print('Failed to fetch data');
      }


    } catch (e) {
      print('An error occurred: $e');
    }
  }

  Future<void> approveLeave(String docno, String authtype, jwt) async {

    final String url = '${AppConfig().baseUrl}leaveapprove';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${jwt}'
    };

    final Map<String, String> body = {
      'docno': docno,
      'authtype': authtype
    };

    final http.Response response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: json.encode(body),
    );

    String message;
    if (response.statusCode == 200) {
      message = 'Leave approved successfully.';
      Navigator.of(context).pop();
      Get.showSnackbar(
        GetSnackBar(
          title: "Leave Request",
          message: message,
          icon: const Icon(Icons.refresh),
          duration: const Duration(seconds: 3),
        ),
      );
      LeaveApprove();
    } else {
      message = 'Failed to approve leave. Status code: ${response.statusCode}';
    }


  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final loginModels = Get.arguments; // Retrieve the login models passed as arguments
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Center(
            child: Text(
              'Employee Self Service                           ',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),

            ),
          ),
          elevation: 1,
          leading: InkWell(onTap: () {
            Navigator.of(context).pop();
          }, child: Icon(Icons.arrow_back_ios, color: Colors.white)),


        ),
      body: Scaffold(

        body: leaveData == null
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
          itemCount: leaveData.data.length,
          itemBuilder: (context, index) {
            return LeaveDataCard(leaveData: leaveData.data[index],jwt:loginModels[0].jwt,LeaveApprove,urls);
          },
        ),
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    // Cancel the timer when the page is disposed
    _timer.cancel();
  }

}
class LeaveDataCard extends StatefulWidget {
  final LeaveData leaveData;
  String jwt;
  Function LeaveApprove;
String urls;
  LeaveDataCard(this. LeaveApprove, this.urls, {required this.leaveData,required this.jwt});

  @override
  State<LeaveDataCard> createState() => _LeaveDataCardState();
}

class _LeaveDataCardState extends State<LeaveDataCard> {
  ApproveApicall(String docno, String jwt, String AuthType) async {
    final String url = '${widget.urls}leaveapprove';

    print(url);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${jwt}'
    };

    final Map<String, String> body = {
      "docno" : docno,
      "authtype": AuthType

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
     widget.LeaveApprove();
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

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.all(4.0),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 200,
                  child: Text(
                    'Employee ${widget.leaveData.empname} (${widget.leaveData.empnum})',
                    style: GoogleFonts.poppins(fontSize: 14.0, fontWeight: FontWeight.w800),
                  ),
                ),
                Container(width: 3,),
                ElevatedButton(
                    onPressed: () {

                      ApproveApicall(widget.leaveData.recordId.toString(),widget.jwt,"A");

                }, child: Icon(CupertinoIcons.hand_thumbsup_fill,color: Colors.green,)),

                Container(width: 9,),
                ElevatedButton(
                    onPressed: () {

                      ApproveApicall(widget.leaveData.recordId.toString(),widget.jwt,"R");

                    }, child: Icon(CupertinoIcons.hand_thumbsdown_fill,color: Colors.red,))
              ],
            ),
            SizedBox(height: 10.0),

            Text("Requested On: "+DateTimeSet(widget.leaveData.dateOfRequest), style: GoogleFonts.poppins(fontSize: 14.0, fontWeight: FontWeight.w300,)),
            SizedBox(height: 5.0),
            Text('Number of Days: ${widget.leaveData.noOfDays}',style: GoogleFonts.poppins(fontSize: 14.0, fontWeight: FontWeight.w300,)),
            SizedBox(height: 5.0),

            Text('From: ${DateTimeSet(widget.leaveData.leaveFrom)}  ',style: GoogleFonts.poppins(fontSize: 14.0, fontWeight: FontWeight.w300,)),
            SizedBox(height: 5.0),
            Text("To: "+DateTimeSet(widget.leaveData.leaveTo),style: GoogleFonts.poppins(fontSize: 14.0, fontWeight: FontWeight.w300,)),
            SizedBox(height: 5.0),
            Text('Reasons: ${widget.leaveData.reasons}',style: GoogleFonts.poppins(fontSize: 14.0, fontWeight: FontWeight.w300,)),
            SizedBox(height: 5.0),
            Text('Category: ${widget.leaveData.leaveType}',style: GoogleFonts.poppins(fontSize: 14.0, fontWeight: FontWeight.w300,)),

          ],
        ),
      ),
    );
  }

  String DateTimeSet(String date) {
    DateTime parseDate = DateFormat("yyyy-MM-dd").parse(date);
    var outputFormat = DateFormat('dd-MM-yyyy');
    var outputDate = outputFormat.format(parseDate);
    return outputDate;
  }
}