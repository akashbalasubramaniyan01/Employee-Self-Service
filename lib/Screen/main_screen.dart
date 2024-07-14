
import 'package:employee_self_service/Screen/model/loginmodel.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Approvel.dart';
import 'TicketDetails.dart';
import 'nav_bar.dart';
import 'nav_model.dart';
import 'noticeboard.dart';

class MainScreen extends StatefulWidget {
/*  final List<Loginmodel> loginModels;*/
  const MainScreen(/*this.loginModels*/);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final homeNavKey = GlobalKey<NavigatorState>();
  final searchNavKey = GlobalKey<NavigatorState>();
  final notificationNavKey = GlobalKey<NavigatorState>();
  final profileNavKey = GlobalKey<NavigatorState>();
  int selectedTab = 0;
  int _selectedIndex = 0;
  List<NavModel> items = [];

  @override
  void initState() {
    super.initState();

  }
  void _initializeIndex(int ID) {

    if (ID == 0) {
      _selectedIndex = 0;
    } else if (ID == 1) {
      _selectedIndex = 1;
    }

  }
  @override
  Widget build(BuildContext context) {


    DateTime now = DateTime.now();
    String formattedDate = DateFormat('hh:mm a').format(now);
    String formattedDates = DateFormat('EEE d MMM').format(now);

    final List<Loginmodel> loginModels = Get.arguments;
    return WillPopScope(
      onWillPop: () {
        if (items[selectedTab].navKey.currentState?.canPop() ?? false) {
          items[selectedTab].navKey.currentState?.pop();
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },

      child: Scaffold(

        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
               DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ), //BoxDecoration
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.green),
                  accountName: Text(
                    loginModels[0].data.name,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    )
                  ),
                  accountEmail: Text(loginModels[0].data.email),
                  currentAccountPictureSize: Size.square(50),
                  currentAccountPicture: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 165, 255, 137),
                      child: Text(
                        loginModels[0].data.name.substring(0,1),
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                      ), //Text
                    ),
                  ), //circleAvatar
                ), //UserAccountDrawerHeader
              ), //DrawerHeader
              ListTile(
                leading: const Icon(Icons.person),
                title: Text(' My Profile ',style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),),
                onTap: () {
                  Get.toNamed('/Profile', arguments: loginModels);
                },
              ),


              ListTile(
                leading: const Icon(Icons.logout),
                title:  Text('LogOut',style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(32.0))),
                          contentPadding: EdgeInsets.all(0),
                          elevation: 0,
                          scrollable: true,
                          backgroundColor: Colors.white,
                          content: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Column(

                                children: [
                                  Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(32),topLeft: Radius.circular(32)), color: Colors.cyan,),

                                    width: 500,height: 180,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all( color: Colors.white,width: 2),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(Icons.person,color: Colors.white,size: 65,),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15,bottom: 15),
                                    child: Center(
                                      child: Text('Are you sure you want to logout',style: GoogleFonts.poppins(

                                        color:
                                        Colors.black,
                                        fontSize:
                                        14,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    ),
                                  ),

                                ],
                              )
                          ),
                          actions: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:80,
                                  margin: EdgeInsets.all(15),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: Text('No',style: TextStyle(
                                      color:
                                      Colors.white,
                                      fontSize:
                                      14,
                                      fontFamily:
                                      'Proxima_Nova_Font',
                                      fontWeight: FontWeight.bold,
                                    ),),
                                    style:ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all<Color>(Color(0xFFF56B3F)),
                                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF56B3F)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(8)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(

                                    alignment: Alignment.center,
                                    width:80,
                                    margin: EdgeInsets.all(15),
                                    child:   ElevatedButton(
                                      child: Text(
                                        "Yes",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: 'Proxima_Nova_Font',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      style: ButtonStyle(
                                        foregroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(8)),
                                          ),
                                        ),
                                      ),
                                      onPressed: ()  async {

                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                        setState(() {
                                          prefs.remove('UserName');
                                          prefs.remove('PassWord');
                                        });

                                        Get.toNamed('/SignIn', arguments: loginModels);

                                        /* Navigator.pushReplacement(
                                          context,MaterialPageRoute(builder: (context) => SignIn()),);
*/

                                      },
                                    )
                                ),
                              ],)
                          ],
                        );
                      });
                },
              ),
            ],
          ),
        ), //Drawer

        bottomNavigationBar: FlashyTabBar(
          animationCurve: Curves.linear,
          selectedIndex: _selectedIndex,
          iconSize: 30,
          showElevation: false, // use this to remove appBar's elevation
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;

            print(_selectedIndex);
            print("_selectedIndex");
          }),
          items: [
            FlashyTabBarItem(
              icon: Icon(Icons.leave_bags_at_home_sharp),
              title: Text('Leave'),
            ),

            FlashyTabBarItem(
              icon: Icon(Icons.leaderboard_sharp),
              title: Text('Permission'),
            ),
            FlashyTabBarItem(
              icon: Icon(Icons.dialpad_outlined),
              title: Text('OD'),
            ),
            FlashyTabBarItem(
              icon: Icon(Icons.add_card),
              title: Text('Missed Punch'),
            ),
          ],
        ),

        appBar: AppBar(
          leading: Builder(
            builder: (context) => InkWell(
              child: Icon(Icons.sort,color: Colors.white,),
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),

          title: Text("Employee Self Service",style: GoogleFonts.poppins(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500),),
          backgroundColor: Colors.green,

        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if(_selectedIndex==0)
            Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15,bottom: 7,top: 20),
                          child: Text('Hello',style: GoogleFonts.poppins(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w400),),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: 15),
                          child: Text(/*widget.loginModels[0].data.name*/loginModels[0].data.name,style: GoogleFonts.poppins(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w800),),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Container(height: 20,),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(17),
                          child:  Center(child: Image.asset("assets/imag.png",width: 35,)),
                        ),
                      ],
                    ),

Container(width: 14,),
                  ],
                ),

                Container(height: 30,),
                Padding(
                  padding: const EdgeInsets.only(left: 15,bottom:0),
                  child: Text(formattedDate,style: GoogleFonts.poppins(fontSize: 33, color: Colors.black, fontWeight: FontWeight.w600),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15,bottom: 7),
                  child: Text(formattedDates,style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600),),
                ),
                Container(height: 30,),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                     //   Get.to(TicketDeatils(/*widget.loginModels*/));
                        Get.toNamed('/LeaveCard', arguments: loginModels);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width/1.1,
                        height: MediaQuery.of(context).size.height/11,
                        decoration: const BoxDecoration(
                        borderRadius: BorderRadiusDirectional.all(Radius.circular(11))
                        ,color: Colors.white,boxShadow: [BoxShadow(blurRadius: 33,color: Colors.black12)]),
                        child: Row(
                          children: [
                            Container(width: 15,),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(17),
                              child:  Center(child: Image.asset("assets/SimplifiedLeave-2.png",width: 60,)),
                            ),
                            Container(width: 10,),
                            Text("My Leave",style: GoogleFonts.poppins(fontSize: 14, color: Colors.green, fontWeight: FontWeight.w700),),

                          Spacer(),
                          Icon(Icons.arrow_forward_ios_outlined,size: 22,),
                            Container(width: 10,),
                          ],
                        ),

                      ),
                    ),
                    Container(height: 10,),

                    if(loginModels[0].data.role=="HOD")
                    InkWell(
                      onTap: () {
                     //   Get.to(TicketDeatils(/*widget.loginModels*/));
                        Get.toNamed('/LeaveArrovel', arguments: loginModels);
                      },
                      child: Container(

                        width: MediaQuery.of(context).size.width/1.1,
                        height: MediaQuery.of(context).size.height/11,
                        decoration: const BoxDecoration(
                        borderRadius: BorderRadiusDirectional.all(Radius.circular(11))
                        ,color: Colors.white,boxShadow: [BoxShadow(blurRadius: 33,color: Colors.black12)]),
                        child: Row(
                          children: [
                            Container(width: 15,),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(17),
                              child:  Center(child: Image.asset("assets/SimplifiedLeave-2.png",width: 60,)),
                            ),
                            Container(width: 10,),
                            Text("Approvals",style: GoogleFonts.poppins(fontSize: 14, color: Colors.green, fontWeight: FontWeight.w700),),

                          Spacer(),
                          Icon(Icons.arrow_forward_ios_outlined,size: 22,),
                            Container(width: 10,),
                          ],
                        ),

                      ),
                    ),
                    Container(height: 10,),
                    InkWell(
                      onTap: () {
                        //   Get.to(TicketDeatils(/*widget.loginModels*/));
                        //Navigator.of(context).pop();
                        Get.toNamed('/NewLeave', arguments: loginModels);
                      },
                      child: Container(

                        width: MediaQuery.of(context).size.width/1.1,
                        height: MediaQuery.of(context).size.height/11,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadiusDirectional.all(Radius.circular(11))
                            ,color: Colors.white,boxShadow: [BoxShadow(blurRadius: 33,color: Colors.black12)]),
                        child: Row(
                          children: [
                            Container(width: 15,),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(17),
                              child:  Center(child: Image.asset("assets/pngtree-man-avatar-isolated-png-image_9935807.png",width: 60,)),
                            ),
                            Container(width: 10,),
                            Text("Request New Leave",style: GoogleFonts.poppins(fontSize: 14, color: Colors.green, fontWeight: FontWeight.w700),),

                            Spacer(),
                            Icon(Icons.arrow_forward_ios_outlined,size: 22,),
                            Container(width: 10,),
                          ],
                        ),

                      ),
                    ),
                    Container(height: 10,),
                    // InkWell(
                    //   onTap: () {
                    //     //   Get.to(TicketDeatils(/*widget.loginModels*/));
                    //     Get.toNamed('/NewLeave', arguments: loginModels);
                    //   },
                    //   child: Container(
                    //
                    //     width: MediaQuery.of(context).size.width/1.1,
                    //     height: MediaQuery.of(context).size.height/11,
                    //     decoration: const BoxDecoration(
                    //         borderRadius: BorderRadiusDirectional.all(Radius.circular(11))
                    //         ,color: Colors.white,boxShadow: [BoxShadow(blurRadius: 33,color: Colors.black12)]),
                    //     child: Row(
                    //       children: [
                    //         Container(width: 15,),
                    //         ClipRRect(
                    //           borderRadius: BorderRadius.circular(17),
                    //           child:  Center(child: Image.asset("assets/leave-management-4.jpg",width: 60,)),
                    //         ),
                    //         Container(width: 10,),
                    //         Text("Approve Leave",style: GoogleFonts.poppins(fontSize: 16, color: Colors.green, fontWeight: FontWeight.w700),),
                    //
                    //         Spacer(),
                    //         Icon(Icons.arrow_forward_ios_outlined,size: 22,),
                    //         Container(width: 10,),
                    //       ],
                    //     ),
                    //
                    //   ),
                    // ),


                  ],
                )
              ],
            ),
            if(_selectedIndex==1)
            Container(
                width: MediaQuery.of(context).size.width/1,
                height: MediaQuery.of(context).size.height/1.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {

                        Get.toNamed('/InsertLeave', arguments: loginModels,);
                      },
                      child: Container(

                        width: MediaQuery.of(context).size.width/1.1,
                        height: MediaQuery.of(context).size.height/11,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadiusDirectional.all(Radius.circular(11))
                            ,color: Colors.white,boxShadow: [BoxShadow(blurRadius: 33,color: Colors.black12)]),
                        child: Row(
                          children: [
                            Container(width: 30,),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(17),
                              child:  Center(child: Image.asset("assets/imag.png",width: 30,)),
                            ),
                            Container(width: 23,),
                            Text("Apply Permission",style: GoogleFonts.poppins(fontSize: 14, color: Colors.green, fontWeight: FontWeight.w700),),

                            Spacer(),
                            Icon(Icons.arrow_forward_ios_outlined,size: 22,),
                            Container(width: 10,),
                          ],
                        ),

                      ),
                    ),
                    Container(height: 15,),
                    InkWell(
                      onTap: () {

                        Get.toNamed('/ODHistory', arguments: loginModels);
                      },
                      child: Container(

                        width: MediaQuery.of(context).size.width/1.1,
                        height: MediaQuery.of(context).size.height/11,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadiusDirectional.all(Radius.circular(11))
                            ,color: Colors.white,boxShadow: [BoxShadow(blurRadius: 33,color: Colors.black12)]),
                        child: Row(
                          children: [
                            Container(width: 15,),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(17),
                              child:  Center(child: Image.asset("assets/pngtree-man-avatar-isolated-png-image_9935807.png",width: 60,)),
                            ),
                            Container(width: 10,),
                            Text("Permission history",style: GoogleFonts.poppins(fontSize: 14, color: Colors.green, fontWeight: FontWeight.w700),),

                            Spacer(),
                            Icon(Icons.arrow_forward_ios_outlined,size: 22,),
                            Container(width: 10,),
                          ],
                        ),

                      ),
                    ),
                    Container(height: 15,),
                    if(loginModels[0].data.role=="HOD")
                    InkWell(
                      onTap: () {

                        Get.toNamed('/ListPermmision', arguments: loginModels);
                      },
                      child: Container(

                        width: MediaQuery.of(context).size.width/1.1,
                        height: MediaQuery.of(context).size.height/11,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadiusDirectional.all(Radius.circular(11))
                            ,color: Colors.white,boxShadow: [BoxShadow(blurRadius: 33,color: Colors.black12)]),
                        child: Row(
                          children: [
                            Container(width: 15,),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(17),
                              child:  Center(child: Image.asset("assets/SimplifiedLeave-2.png",width: 60,)),
                            ),
                            Container(width: 10,),
                            Text("Permission Details",style: GoogleFonts.poppins(fontSize: 14, color: Colors.green, fontWeight: FontWeight.w700),),

                            Spacer(),
                            Icon(Icons.arrow_forward_ios_outlined,size: 22,),
                            Container(width: 10,),
                          ],
                        ),

                      ),
                    ),
                  ],
                )),
            if(_selectedIndex==2)
              Column(

                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height:80,

                    decoration: const BoxDecoration(color: Colors.white,boxShadow: [BoxShadow(blurRadius: 3,color: Colors.black12)]),
                    child:  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'E - Notice Board',
                              style:  GoogleFonts.poppins(fontWeight: FontWeight.bold,color:Colors.green,fontSize:22),

                            ),
                            Container(width: 10,),

                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(height: 22,),
                InkWell(
                  onTap: () {
                    Get.to(noticebaord());
                  },
                  child: Container(

                    width: MediaQuery.of(context).size.width/1.1,
                    height: MediaQuery.of(context).size.height/11,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadiusDirectional.all(Radius.circular(11))
                        ,color: Colors.white,boxShadow: [BoxShadow(blurRadius: 33,color: Colors.black12)]),
                    child: Row(
                      children: [
                        Container(width: 15,),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(17),
                          child:  Center(child: Image.asset("assets/SimplifiedLeave-2.png",width: 60,)),
                        ),
                        Container(width: 10,),
                        Text("Events",style: GoogleFonts.poppins(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),),

                        Spacer(),
                        Icon(Icons.arrow_forward_ios_outlined,size: 22,),
                        Container(width: 10,),
                      ],
                    ),

                  ),
                ),
                  Container(height: 16,),
                InkWell(
                  onTap: () {
                    Get.to(noticebaord());
                  },
                  child: Container(

                    width: MediaQuery.of(context).size.width/1.1,
                    height: MediaQuery.of(context).size.height/11,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadiusDirectional.all(Radius.circular(11))
                        ,color: Colors.white,boxShadow: [BoxShadow(blurRadius: 33,color: Colors.black12)]),
                    child: Row(
                      children: [
                        Container(width: 15,),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(17),
                          child:  Center(child: Image.asset("assets/SimplifiedLeave-2.png",width: 60,)),
                        ),
                        Container(width: 10,),
                        Text("Pancard",style: GoogleFonts.poppins(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),),

                        Spacer(),
                        Icon(Icons.arrow_forward_ios_outlined,size: 22,),
                        Container(width: 10,),
                      ],
                    ),

                  ),
                ),
                  Container(height: 16,),
                InkWell(
                  onTap: () {
                    Get.to(noticebaord());
                  },
                  child: Container(

                    width: MediaQuery.of(context).size.width/1.1,
                    height: MediaQuery.of(context).size.height/11,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadiusDirectional.all(Radius.circular(11))
                        ,color: Colors.white,boxShadow: [BoxShadow(blurRadius: 33,color: Colors.black12)]),
                    child: Row(
                      children: [
                        Container(width: 15,),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(17),
                          child:  Center(child: Image.asset("assets/SimplifiedLeave-2.png",width: 60,)),
                        ),
                        Container(width: 10,),
                        Text("HealthCare",style: GoogleFonts.poppins(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),),

                        Spacer(),
                        Icon(Icons.arrow_forward_ios_outlined,size: 22,),

                        Container(width: 10,),
                      ],
                    ),

                  ),
                ),
              ],),
            if(_selectedIndex==3)
              Column(

                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height:80,

                    decoration: const BoxDecoration(color: Colors.white,boxShadow: [BoxShadow(blurRadius: 3,color: Colors.black12)]),
                    child:  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'E - Notice Board',
                              style:  GoogleFonts.poppins(fontWeight: FontWeight.bold,color:Colors.green,fontSize:22),

                            ),
                            Container(width: 10,),

                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(height: 22,),
                  InkWell(
                    onTap: () {
                      Get.to(noticebaord());
                    },
                    child: Container(

                      width: MediaQuery.of(context).size.width/1.1,
                      height: MediaQuery.of(context).size.height/11,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadiusDirectional.all(Radius.circular(11))
                          ,color: Colors.white,boxShadow: [BoxShadow(blurRadius: 33,color: Colors.black12)]),
                      child: Row(
                        children: [
                          Container(width: 15,),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(17),
                            child:  Center(child: Image.asset("assets/SimplifiedLeave-2.png",width: 60,)),
                          ),
                          Container(width: 10,),
                          Text("Events",style: GoogleFonts.poppins(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),),

                          Spacer(),
                          Icon(Icons.arrow_forward_ios_outlined,size: 22,),
                          Container(width: 10,),
                        ],
                      ),

                    ),
                  ),
                  Container(height: 16,),
                  InkWell(
                    onTap: () {
                      Get.to(noticebaord());
                    },
                    child: Container(

                      width: MediaQuery.of(context).size.width/1.1,
                      height: MediaQuery.of(context).size.height/11,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadiusDirectional.all(Radius.circular(11))
                          ,color: Colors.white,boxShadow: [BoxShadow(blurRadius: 33,color: Colors.black12)]),
                      child: Row(
                        children: [
                          Container(width: 15,),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(17),
                            child:  Center(child: Image.asset("assets/SimplifiedLeave-2.png",width: 60,)),
                          ),
                          Container(width: 10,),
                          Text("Pancard",style: GoogleFonts.poppins(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),),

                          Spacer(),
                          Icon(Icons.arrow_forward_ios_outlined,size: 22,),
                          Container(width: 10,),
                        ],
                      ),

                    ),
                  ),
                  Container(height: 16,),
                  InkWell(
                    onTap: () {
                      Get.to(noticebaord());
                    },
                    child: Container(

                      width: MediaQuery.of(context).size.width/1.1,
                      height: MediaQuery.of(context).size.height/11,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadiusDirectional.all(Radius.circular(11))
                          ,color: Colors.white,boxShadow: [BoxShadow(blurRadius: 33,color: Colors.black12)]),
                      child: Row(
                        children: [
                          Container(width: 15,),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(17),
                            child:  Center(child: Image.asset("assets/SimplifiedLeave-2.png",width: 60,)),
                          ),
                          Container(width: 10,),
                          Text("HealthCare",style: GoogleFonts.poppins(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),),

                          Spacer(),
                          Icon(Icons.arrow_forward_ios_outlined,size: 22,),

                          Container(width: 10,),
                        ],
                      ),

                    ),
                  ),
                ],),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          margin: const EdgeInsets.only(top: 10),
          height: 64,
          width: 64,

        ),

      ),
    );
  }
}

class TabPage extends StatelessWidget {
  final int tab;

  const TabPage({Key? key, required this.tab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tab $tab')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tab $tab'),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Page(tab: tab),
                  ),
                );
              },
              child: const Text('Go to page'),
            )
          ],
        ),
      ),
    );
  }
}

class Page extends StatelessWidget {
  final int tab;

  const Page({super.key, required this.tab});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page Tab $tab')),
      body: Center(child: Text('Tab $tab')),
    );
  }
}
