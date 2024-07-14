


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'baseUrlPage.dart';
import 'model/ProfileModel.dart';
import 'model/loginmodel.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
 var  profileData;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Url();
}
 String urls="";
 Url() async {
   final prefs = await SharedPreferences.getInstance();
   setState(() {
     urls = prefs.getString('url') ?? "";
   });
   Profile();
 }
  Profile() async {

    try {

      final List<Loginmodel> loginModels = Get.arguments;
      var url = "${urls}myprofile/${loginModels[0].data.usrid}";
           print(url);
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${loginModels[0].jwt}'
        },
      );


      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
      setState(() {
        var data = jsonDecode(response.body.toString());
        print(data);
        profileData = ProfileData.fromJson(data['data']);
      });



      } else {
        print('Failed to fetch data');
      }
    }
    catch (e) {
      print('An error occurred: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    final loginModels = Get.arguments;
    return Container(
      width: MediaQuery.of(context).size.width/1,
      height: MediaQuery.of(context).size.height/1.3,
      child: Scaffold(
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
        body: SafeArea(
          child: profileData != null
              ? SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/pngtree-man-avatar-isolated-png-image_9935807.png'),
                ),
                SizedBox(height: 14),
                Text(
                  profileData.employeeName,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontFamily: 'Pacifico',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 22),
                Text(
                  profileData.departmentName.toUpperCase(),
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'SourceSansPro',
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.5,
                  ),
                ),
                SizedBox(
                  height: 7.0,

                  child: Divider(
                    color: Colors.teal.shade100,
                  ),
                ),
                ListTile(
                  title: Text('Employee Name',style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      )),
                  subtitle: Text(profileData.employeeName,style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  )),
                ),
                SizedBox(
                  height: 7.0,

                  child: Divider(
                    color: Colors.teal.shade100,
                  ),
                ),
                ListTile(
                  title: Text('Mobile Number',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  )),
                  subtitle: Text(profileData.mobile,style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  )),
                ),
                SizedBox(
                  height: 7.0,

                  child: Divider(
                    color: Colors.teal.shade100,
                  ),
                ),
                ListTile(
                  title: Text('Email',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  )),
                  subtitle: Text(profileData.email,style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  )),
                ),
                SizedBox(
                  height: 7.0,

                  child: Divider(
                    color: Colors.teal.shade100,
                  ),
                ),
                ListTile(
                  title: Text('AAdhar No',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  )),
                  subtitle: Text(profileData.aadharNumber,style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  )),
                ),
                SizedBox(
                  height: 7.0,

                  child: Divider(
                    color: Colors.teal.shade100,
                  ),
                ),
                ListTile(
                  title: Text('Date of Birth',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  )),
                  subtitle: Text(profileData.dateOfBirth,style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  )),
                ),
                SizedBox(
                  height: 7.0,

                  child: Divider(
                    color: Colors.teal.shade100,
                  ),
                ),
                ListTile(
                  title: Text('Date of Join',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  )),
                  subtitle: Text(profileData.dateOfJoin,style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  )),
                ),
                SizedBox(
                  height: 7.0,

                  child: Divider(
                    color: Colors.teal.shade100,
                  ),
                ),
                ListTile(
                  title: Text('Department Name',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  )),
                  subtitle: Text(profileData.departmentName,style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  )),
                ),
                SizedBox(
                  height: 7.0,

                  child: Divider(
                    color: Colors.teal.shade100,
                  ),
                ),
                ListTile(
                  title: Text('Pf Uan number',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  )),
                  subtitle: Text(profileData.departmentName,style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  )),
                ),
                SizedBox(
                  height: 7.0,

                  child: Divider(
                    color: Colors.teal.shade100,
                  ),
                ),
                ListTile(
                  title: Text('Bank Account number',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  )),
                  subtitle: Text(profileData.bankAccountNumber,style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  )),
                ),
                SizedBox(
                  height: 7.0,

                  child: Divider(
                    color: Colors.teal.shade100,
                  ),
                ),
                ListTile(
                  title: Text('Bank Name',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  )),
                  subtitle: Text(profileData.bankName,style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  )),
                ),
                SizedBox(
                  height: 7.0,

                  child: Divider(
                    color: Colors.teal.shade100,
                  ),
                ),
                ListTile(
                  title: Text('IFSC Code',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  )),
                  subtitle: Text(profileData.ifscCode,style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  )),
                ),
                SizedBox(
                  height: 7.0,

                  child: Divider(
                    color: Colors.teal.shade100,
                  ),
                ),
                ListTile(
                  title: Text('pan Number',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  )),
                  subtitle: Text(profileData.panNumber,style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  )),
                ),
                SizedBox(
                  height: 7.0,

                  child: Divider(
                    color: Colors.teal.shade100,
                  ),
                ),
                ListTile(
                  title: Text('Local Address',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  )),
                  subtitle: Text(profileData.localAddress,style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  )),
                ),
                SizedBox(
                  height: 7.0,

                  child: Divider(
                    color: Colors.teal.shade100,
                  ),
                ),
                ListTile(
                  title: Text('Permanent Address',style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  )),
                  subtitle: Text(profileData.permanentAddress,style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  )),
                ),
                // Add more ListTiles for other fields as needed
              ],
            ),
          )
              : Center(
            child: CircularProgressIndicator(),
          ),

        ),
      ),
    );
  }
}
