


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/colors.dart';
import 'insertLeave.dart';
import 'insertLeaveController.dart';
import 'model/loginmodel.dart';

class OdHistoryCardPage extends StatefulWidget {
  const OdHistoryCardPage({super.key});

  @override
  State<OdHistoryCardPage> createState() => _OdHistoryCardPageState();
}

class _OdHistoryCardPageState extends State<OdHistoryCardPage> {
  @override
  void initState() {
    super.initState();

    Url();
  }
  final FormController formController = Get.put(FormController());
  String urls = "" ;
  Url() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      urls = prefs.getString('url') ?? "";
    });
    //formController.fetchHistory(urls);
  }
  Widget build(BuildContext context) {
    final loginModels = Get.arguments;
    return  Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => InkWell(
            child: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,),
            onTap: () {
             Navigator.pop(context);
            },
          ),
        ),

        title: Text("Employee Self Service",style: GoogleFonts.poppins(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500),),
        backgroundColor: Colors.green,

      ),
      body:     Obx(() {
        if (formController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: formController.historyList.length,
            itemBuilder: (context, index) {
              var item = formController.historyList[index];
              return Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 11,top: 11),
                decoration: new BoxDecoration(
                    color: backgroundColor1,
                    boxShadow: [ BoxShadow(
                      color: Colors.grey,
                      blurRadius: 8,
                    ),]
                ),
                child: ListTile(
                  leading: Icon(Icons.calendar_month_sharp, color: Colors.blue),
                  title: Text(item['EmpName'], style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 5,),
                      Text('From: ${item['FromHRS']} To: ${item['ToHRS']}',style: GoogleFonts.poppins(
                         color: Colors.black.withOpacity(0.6), fontSize: 14),),
                     // Container(height: 13,),
                      Container(height: 5,),
                      Text('No of HRS: ${item['NoofHRS']}',style: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(0.6), fontSize: 14),),
                      Container(height: 5,),
                      Text('From HRS: ${item['FromHRS']}',style: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(0.6), fontSize: 14),),
                      Container(height: 5,),
                      if(item['ToHRS']!=null)
                      Text('To HRS: ${item['ToHRS']}',style: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(0.6), fontSize: 14),),
                      if(item['Purpose']!=null)
                      Container(height: 5,),
                      if(item['Purpose']!="")
                      Text('Purpose: ${item['Purpose']}',style: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(0.6), fontSize: 14),),
                      Container(height: 5,),
                      if(item['InTime']!=null)
                      Text('In Time: ${item['InTime']}',style: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(0.6), fontSize: 14),),
                      Container(height: 5,),
                      if(item['OuTime']!=null)
                      Text('Ou Time: ${item['OuTime']}',style: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(0.6), fontSize: 14),),
                      if(item['Purpose']!="")
                        Container(height: 5,),
                      if(item['Remarks']!="")
                Text('Remarks: ${item['Remarks']}',style: GoogleFonts.poppins(
                    color: Colors.black.withOpacity(0.6), fontSize: 14),),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }

  ODHistrory() async {
    final List<Loginmodel> loginModels = Get.arguments;
    print(loginModels[0].data.usrid);
    try {
      var url = "${urls}essapi/viewpodcard/";
      print(loginModels[0].data.usrid);
      print(url);
      print(loginModels[0].jwt);
      final response = await http.put(
        Uri.parse(url),
        body: jsonEncode({
          "empcode": loginModels[0].data.usrid,
          "DocType": "P",
          "limit": 20,
          "start": 0}
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${loginModels[0].jwt}'
        },
      );


      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        var datas = data['data'];
        print('Data fetched successfully: $datas');
      } else {
        print('Failed to fetch data');
      }


    } catch (e) {
      print('An error occurred: $e');
    }
  }
}
