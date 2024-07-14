

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
import 'model/LeaveDetailsModel.dart';
import 'model/loginmodel.dart';

class TicketDeatils extends StatefulWidget {
  //final List<Loginmodel> loginModels;
  /*var AllTickets;
  int i;
  String TicketName;
  final VoidCallback onBack;
  final List<LoginModel> loginModels;*/
   TicketDeatils(/*this.loginModels*//*this.AllTickets,this.i,this.TicketName,this.loginModels,{required this.onBack}*/);

  @override
  State<TicketDeatils> createState() => _TicketDeatilsState();
}

class _TicketDeatilsState extends State<TicketDeatils> {
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
  String urls="";
  Url() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      urls = prefs.getString('url') ?? "";
    });
    Details();
}
  
  
  Details() async {
    final List<Loginmodel> loginModels = Get.arguments;
    print(loginModels[0].data.usrid);
    try {
   //   if(loginModels[0].data.role=="USER")

        var url = "${urls}viewleavecard";

        print(loginModels[0].data.usrid);
        print(url);
        print(loginModels[0].jwt);
        final response = await http.put(
          Uri.parse(url),
          body: jsonEncode({
            "empcode": loginModels[0].data.usrid,
            "limit": 20,
            "start": 0
          }),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${loginModels[0].jwt}'
          },
        );
        print(jsonEncode({
          "empcode": loginModels[0].data.usrid,
          "limit": 20,
          "start": 0
        }),);
print(response.statusCode);
print(response.body);
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body.toString());
          var datas = data['data'];
          setState(() {
            allTickets =
            List<Ticket>.from(datas.map((item) => Ticket.fromJson(item)));
          });
          print('Data fetched successfully: $allTickets');
        } else {
          print('Failed to fetch data');
        }


    } catch (e) {
      print('An error occurred: $e');
    }
  }
  Future<void> approveLeave(String docno, String authtype, jwt) async {

    final String url = '${urls}essapi/leaveapprove';
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
      Details();
    } else {
      message = 'Failed to approve leave. Status code: ${response.statusCode}';
    }


  }
  Future<void> CancelLeave(String docno, String jwt) async {

    final String url = '${urls}leavecancel/';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${jwt}'
    };

    final Map<String, String> body = {
      'docno': docno,

    };

    final http.Response response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: json.encode(body),
    );

    String message;
    if (response.statusCode == 200) {
      message = 'Leave Cancel successfully.';
      Navigator.of(context).pop();
      Get.showSnackbar(
        GetSnackBar(
          title: "Leave Cancel",
          message: message,
          icon: const Icon(Icons.refresh),
          duration: const Duration(seconds: 3),
        ),
      );
      Details();
    } else {
      message = 'Failed to approve leave. Status code: ${response.statusCode}';
    }


  }
  String DateTimeSet(String date) {
    DateTime parseDate = DateFormat("yyyy-MM-dd").parse(date);
    var outputFormat = DateFormat('dd-MM-yyyy');
    var outputDate = outputFormat.format(parseDate);
    return outputDate;
  }
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final loginModels = Get.arguments; // Retrieve the login models passed as arguments
    return  Scaffold(
      appBar: AppBar(
       title: Center(
         child: Text(
           'Employee Self Service                           ',
           style:  GoogleFonts.poppins(fontWeight: FontWeight.bold,color:Colors.cyan,fontSize:13),

         ),
       ),
        elevation: 1,
        leading: InkWell(onTap: () {


          Navigator.of(context).pop();
        },child: Icon(Icons.arrow_back_ios,color: Colors.black)),

     
      ),
      body: Scaffold(

        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  backgroundColor2,
                  backgroundColor2,
                  backgroundColor4,
                ],
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: size.width,
                  height: 60.0,

                  decoration: new BoxDecoration(
                      color: const Color(0xFF66BB6A),
                      boxShadow: [new BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        blurRadius: 27.0,
                      ),
                      ]
                  ),
                  child: Center(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/leave-management-3.jpg', width: 49,),
                      Container(width: 13,),
                      Text("All Leave Details", style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20)),


                    ],
                  )),
                ),

                 Container(height: 5,),
                allTickets.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : Container(
                  width: MediaQuery.of(context).size.width/1,
                  height: MediaQuery.of(context).size.height/1.5,
                      child: ListView.builder(
                                        itemCount: allTickets.length,
                                        itemBuilder: (context, index) {
                      final ticket = allTickets[index];
                      return  Card(
                        margin: EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Icon(Icons.assignment, color: Colors.blue),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             // Text('Employee Name: ${ticket.empname.toString()}',),
                              Text('Number of Days: ${ticket.noOfDays.toString()}'),
                              Text('Leave From: ${DateTimeSet(ticket.leaveFrom)} to ${DateTimeSet(ticket.leaveTo)}'),
                              Text('Reasons: ${ticket.reasons}'),
                              Text('${ticket.headRecom=="A"?"Approved":ticket.headRecom=="R"?"Rejected":"waiting for approval"}'),
                              Text('Leave Type: ${ticket.leaveType}'),
                              Container(height: 10,),
                              Row(
                                children: [
                               /*   if(loginModels[0].data.role=="HOD")
                                  Container(
                                    width: 130,
                                    height: 30,
                                    child: ElevatedButton(
                                      child: Center(child: Text('Approve Leave',style: TextStyle(color: Colors.white,fontSize: 12),),),
                                      onPressed: () {
                                        final _formKey = GlobalKey<FormState>();
                                        final _docnoController = TextEditingController();
                                        final _authtypeController = TextEditingController();

                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Approve Leave',style: TextStyle(color: Colors.black),),
                                              actions: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.all(16.0),
                                                  child: Form(
                                                    key: _formKey,
                                                    child: Column(
                                                      children: <Widget>[

                                                        TextFormField(
                                                          controller: _authtypeController,
                                                          decoration: InputDecoration(labelText: 'Leave Type (A/R)'),
                                                          validator: (value) {
                                                            if (value == null || value.isEmpty) {
                                                              return 'Please enter an Leave Type';
                                                            }
                                                            if (value != 'A' && value != 'R') {
                                                              return 'Leave Type type must be A or R';
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                        SizedBox(height: 20),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            if (_formKey.currentState?.validate() ?? false) {
                                                              approveLeave(ticket.recordId.toString(), _authtypeController.text,loginModels[0].jwt);
                                                            }
                                                          },
                                                          child: Text('Approve Leave',style: TextStyle(color: Colors.black),),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(Colors.green),

                                          textStyle: MaterialStateProperty.all(TextStyle(fontSize: 13,color: Colors.white))),
                                    ),
                                  ),*/
                                  Container(width: 5,),

                                  if(ticket.headRecom=="N")
                                  Container(
                                    width: 120,
                                    height: 30,
                                    child: ElevatedButton(
                                      child: Center(child: Text('Cancel Leave',style: TextStyle(color: Colors.white,fontSize: 12),),),
                                      onPressed: () {
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.confirm,
                                          text: 'Cancel Leave?',
                                          confirmBtnText: 'Yes',
                                         onConfirmBtnTap: () {
                                           CancelLeave(ticket.recordId.toString(),loginModels[0].jwt);
                                         },
                                          cancelBtnText: 'No',
                                          confirmBtnColor: Colors.green,
                                        );// That's it to display an alert, use other properties to customize.
                                        //approveLeave(ticket.recordId.toString(), _authtypeController.text,loginModels[0].jwt);
                                      },
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(Colors.red),

                                          textStyle: MaterialStateProperty.all(TextStyle(fontSize: 13,color: Colors.white))),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                         // trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                        ),
                      );
                                        },
                                      ),
                    ),

              ],
            ),
          ),
        ),
      ),
    );
  }
 
  @override
  void dispose() {
    super.dispose();
    // Cancel the timer when the page is disposed
    _timer.cancel();
  }

}
