

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'dart:io';

import 'package:google_fonts/google_fonts.dart';

import '../Utils/colors.dart';
import 'model/loginmodel.dart';

class Aprovel extends StatefulWidget {
  final List<Loginmodel> loginModels;
  /*var AllTickets;
  int i;
  String TicketName;
  final VoidCallback onBack;
  final List<LoginModel> loginModels;*/
  Aprovel(this.loginModels/*this.AllTickets,this.i,this.TicketName,this.loginModels,{required this.onBack}*/);

  @override
  State<Aprovel> createState() => _AprovelState();
}

class _AprovelState extends State<Aprovel> {
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
  //var NameAssignList=[];
  List<Map<int, String>> NameAssignList = []; // Sample data
  @override
  void initState() {
    login();
    print(widget.loginModels[0].jwt);
  }


  login()  async {

    try{

      final response = await http.get(

          Uri.parse('http://122.165.61.194/essapi/leaveyet2approve/psovcco'),

          headers: {
            'Content-Type': ' application/json',
            'Authorization': 'Bearer ${widget.loginModels[0].jwt}'

          }
      );

      print(response.statusCode);
      print(response.body);

      if(response.statusCode == 200){

        var data = jsonDecode(response.body.toString());
        var datas = data['data']['data'];
        setState(() {
          AllTickets.addAll(datas);
        });
        //Get.to(MainScreen(LoginModels));
        print('failed$AllTickets');
      }else {
        print('failed');
      }
    }catch(e){
      print(e.toString());
    }
  }
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(
        leading: Text(''),
        actions: [],


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

                  decoration: const BoxDecoration(color: Colors.white,boxShadow: [BoxShadow(blurRadius: 3,color: Colors.black12)]),
                  child:  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Leave Approvel List',
                            style:  GoogleFonts.poppins(fontWeight: FontWeight.bold,color:Colors.green,fontSize:15),

                          ),
                          Container(width: 10,),

                        ],
                      ),
                    ),
                  ),
                ),
                Container(height: 5,),
                for (int i =0; i<AllTickets.length;i++)
                  Container(
                      margin: EdgeInsets.all(10),
                      decoration:BoxDecoration(        borderRadius: BorderRadius.circular(10.0),
                          color:  Colors.white,
                          boxShadow: [ BoxShadow(color: Colors.black12,blurRadius: 2)]) ,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            mainAxisAlignment:
                            MainAxisAlignment
                                .start,
                            children: [
                              Padding(
                                padding: const EdgeInsets
                                    .only(
                                    top:
                                    10.0,
                                    left:
                                    10,right: 10,bottom: 10),
                                child: Row(
                                    children: [
                                      Icon(CupertinoIcons.tickets_fill,color:  Colors.green,),
                                      Container(width: 10,),
                                      Container(
                                        width:
                                        100,
                                        child:
                                        Text(
                                          'Emp Name',
                                          style:  GoogleFonts.quicksand(fontWeight: FontWeight.bold),

                                        ),
                                      ),
                                      Container(

                                        child:
                                        Text.rich(
                                          TextSpan(
                                              children: [
                                                TextSpan(text: ": ", style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: Colors.black)),
                                                TextSpan(text: AllTickets[i]['empname'], style: GoogleFonts.poppins(color: Colors.black,fontWeight:FontWeight.bold))
                                              ]),
                                        ),
                                      )
                                    ]),
                              ),



                            ],
                          ),
                          Row(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            mainAxisAlignment:
                            MainAxisAlignment
                                .start,
                            children: [
                              Padding(
                                padding: const EdgeInsets
                                    .only(
                                    top:
                                    10.0,
                                    left:
                                    10,right: 10,bottom: 10),
                                child: Row(
                                    children: [
                                      Icon(CupertinoIcons.text_append,color:  Colors.green,),
                                      Container(width: 10,),
                                      Container(
                                        width:
                                        100,
                                        child:
                                        Text(
                                          'No of days',
                                          style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),

                                        ),
                                      ),
                                      Container(
                                        width: 200,
                                        child:
                                        Text.rich(
                                          TextSpan(
                                              children: [
                                                TextSpan(text: ": ", style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: Colors.black)),
                                                TextSpan(text: AllTickets[i]['no_of_days'], style: GoogleFonts.poppins(color: Colors.black,fontWeight:FontWeight.bold,))
                                              ]),
                                        ),
                                      )
                                    ]),
                              ),



                            ],
                          ),
                          Row(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            mainAxisAlignment:
                            MainAxisAlignment
                                .start,
                            children: [
                              Padding(
                                padding: const EdgeInsets
                                    .only(
                                    top:
                                    10.0,
                                    left:
                                    10,right: 10,bottom: 10),
                                child: Row(
                                    children: [
                                      Icon(CupertinoIcons.today,color:  Colors.green,),
                                      Container(width: 10,),
                                      Container(
                                        width:
                                        100,
                                        child:
                                        Text(
                                          'Emp Num',
                                          style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),

                                        ),
                                      ),
                                      Container(

                                        child:
                                        Text.rich(
                                          TextSpan(
                                              children: [
                                                TextSpan(text: ": ", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.black)),
                                                TextSpan(text: AllTickets[i]['empnum'], style:GoogleFonts.poppins(color: Colors.black,fontWeight:FontWeight.bold))
                                              ]),
                                        ),
                                      )
                                    ]),
                              ),



                            ],
                          ),
                          Row(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            mainAxisAlignment:
                            MainAxisAlignment
                                .start,
                            children: [
                              Padding(
                                padding: const EdgeInsets
                                    .only(
                                    top:
                                    10.0,
                                    left:
                                    10,right: 10,bottom: 10),
                                child: Row(
                                    children: [
                                      Icon(CupertinoIcons.create_solid,color:  Colors.green,),
                                      Container(width: 10,),
                                      Container(
                                        width:
                                        100,
                                        child:
                                        Text(
                                          'date of request',
                                          style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),

                                        ),
                                      ),
                                      Container(

                                        child:
                                        Text.rich(
                                          TextSpan(
                                              children: [
                                                TextSpan(text: ": ", style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: Colors.black)),
                                                TextSpan(text: AllTickets[i]['date_of_request'], style: GoogleFonts.poppins(color: Colors.black,fontWeight:FontWeight.bold))
                                              ]),
                                        ),
                                      )
                                    ]),
                              ),



                            ],
                          ),

                          Row(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            mainAxisAlignment:
                            MainAxisAlignment
                                .start,
                            children: [
                              Padding(
                                padding: const EdgeInsets
                                    .only(
                                    top:
                                    10.0,
                                    left:
                                    10,right: 10,bottom: 10),
                                child: Row(
                                    children: [
                                      Icon(CupertinoIcons.music_albums,color:  Colors.green,),
                                      Container(width: 10,),
                                      Container(
                                        width:
                                        100,
                                        child:
                                        Text(
                                          'no of days',
                                          style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),

                                        ),
                                      ),
                                      Container(

                                        child:
                                        Text.rich(
                                          TextSpan(
                                              children: [
                                                TextSpan(text: ": ", style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: Colors.black)),
                                                TextSpan(text: AllTickets[i]['no_of_days'], style: GoogleFonts.poppins(color: Colors.black,fontWeight:FontWeight.bold))
                                              ]),
                                        ),
                                      )
                                    ]),
                              ),



                            ],
                          ),
                          Row(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            mainAxisAlignment:
                            MainAxisAlignment
                                .start,
                            children: [
                              Padding(
                                padding: const EdgeInsets
                                    .only(
                                    top:
                                    10.0,
                                    left:
                                    10,right: 10,bottom: 10),
                                child: Row(
                                    children: [
                                      Icon(CupertinoIcons.checkmark_alt,color: Colors.green,),
                                      Container(width: 10,),
                                      Container(
                                        width:
                                        100,
                                        child:
                                        Text(
                                          'reasons',
                                          style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),

                                        ),
                                      ),
                                      Container(

                                        child:
                                        Text.rich(
                                          TextSpan(
                                              children: [
                                                TextSpan(text: ": ", style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: Colors.black)),
                                              ]),
                                        ),
                                      ),
                                      Container(
                                        width: 200,
                                        child: Text(
                                          AllTickets[i]['reasons'],
                                           style: GoogleFonts.poppins(color: Colors.black,fontWeight:FontWeight.bold),

                                        ),
                                      ),

                                    ]),
                              ),



                            ],
                          ),
                          Row(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            mainAxisAlignment:
                            MainAxisAlignment
                                .start,
                            children: [
                              Padding(
                                padding: const EdgeInsets
                                    .only(
                                    top:
                                    10.0,
                                    left:
                                    10,right: 10,bottom: 10),
                                child: Row(
                                    children: [
                                      Icon(CupertinoIcons.wand_rays,color:  Colors.green,),
                                      Container(width: 10,),
                                      Container(
                                        width:
                                        100,
                                        child:
                                        Text(
                                          'leave_type',
                                          style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),

                                        ),
                                      ),
                                      Container(
                                        child:
                                        Text.rich(
                                          TextSpan(
                                              children: [
                                                TextSpan(text: ": ", style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: Colors.black)),
                                                TextSpan(text: AllTickets[i]['leave_type'], style: GoogleFonts.poppins(color: Colors.black,fontWeight:FontWeight.bold))
                                              ]),
                                        ),
                                      )
                                    ]),
                              ),



                            ],
                          ),


                        ],
                      )),

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
