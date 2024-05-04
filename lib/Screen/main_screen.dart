
import 'package:employee_self_service/Screen/model/loginmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'Approvel.dart';
import 'TicketDetails.dart';
import 'nav_bar.dart';
import 'nav_model.dart';
import 'noticeboard.dart';

class MainScreen extends StatefulWidget {
  final List<Loginmodel> loginModels;
  const MainScreen(this.loginModels);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final homeNavKey = GlobalKey<NavigatorState>();
  final searchNavKey = GlobalKey<NavigatorState>();
  final notificationNavKey = GlobalKey<NavigatorState>();
  final profileNavKey = GlobalKey<NavigatorState>();
  int selectedTab = 0;
  List<NavModel> items = [];

  @override
  void initState() {
    super.initState();
    items = [
      NavModel(
        page: const TabPage(tab: 1),
        navKey: homeNavKey,
      ),
      NavModel(
        page: const TabPage(tab: 2),
        navKey: searchNavKey,
      ),
      NavModel(
        page: const TabPage(tab: 3),
        navKey: notificationNavKey,
      ),
      NavModel(
        page: const TabPage(tab: 4),
        navKey: profileNavKey,
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('hh:mm a').format(now);
    String formattedDates = DateFormat('EEE d MMM').format(now);
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
        appBar: AppBar(
          leading: Text(''),
          actions: [],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if(selectedTab==0)
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
                          padding: const EdgeInsets.only(left: 15,bottom: 7),
                          child: Text('Hello',style: GoogleFonts.poppins(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w400),),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: 15),
                          child: Text(widget.loginModels[0].data.name,style: GoogleFonts.poppins(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w800),),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
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
                        Get.to(TicketDeatils(widget.loginModels));
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
                            Text("Employee Leave",style: GoogleFonts.poppins(fontSize: 16, color: Colors.green, fontWeight: FontWeight.w700),),

                          Spacer(),
                          Icon(Icons.arrow_forward_ios_outlined,size: 22,),
                            Container(width: 10,),
                          ],
                        ),

                      ),
                    ),
                    Container(height: 13,),
                    Container(

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
                            child:  Center(child: Image.asset("assets/unnamed.jpg",width: 60,)),
                          ),
                          Container(width: 10,),
                          Text("permission",style: GoogleFonts.poppins(fontSize: 16, color: Colors.green, fontWeight: FontWeight.w700),),

                        Spacer(),
                        Icon(Icons.arrow_forward_ios_outlined,size: 22,),
                          Container(width: 10,),
                        ],
                      ),

                    ),
                    Container(height: 13,),
                    Container(

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
                            child:  Center(child: Image.asset("assets/ontudy.jpg",width: 60,)),
                          ),
                          Container(width: 10,),
                          Text("On Duty",style: GoogleFonts.poppins(fontSize: 16, color: Colors.green, fontWeight: FontWeight.w700),),

                        Spacer(),
                        Icon(Icons.arrow_forward_ios_outlined,size: 22,),
                          Container(width: 10,),
                        ],
                      ),

                    ),
                    Container(height: 13,),
                    Container(

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
                          Text("Miss Punch",style: GoogleFonts.poppins(fontSize: 16, color: Colors.green, fontWeight: FontWeight.w700),),

                        Spacer(),
                        Icon(Icons.arrow_forward_ios_outlined,size: 22,),
                          Container(width: 10,),
                        ],
                      ),

                    ),
                  ],
                )
              ],
            ),
            if(selectedTab==1)
            Container(
                width: MediaQuery.of(context).size.width/1,
                height: MediaQuery.of(context).size.height/1.3,
                child: Aprovel(widget.loginModels)),
            if(selectedTab==2)
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
            if(selectedTab==3)
              Container(
                width: MediaQuery.of(context).size.width/1,
                height: MediaQuery.of(context).size.height/1.3,
                child: Scaffold(

                  body: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 50.0,
                          backgroundImage: AssetImage('assets/pngtree-man-avatar-isolated-png-image_9935807.png'),
                        ),
                        Container(height: 15,),
                        Text(
                          widget.loginModels[0].data.name,
                          style: TextStyle(
                            fontSize: 30.0,
                            fontFamily: 'Pacifico',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Container(height: 15,),
                        Text(
                          widget.loginModels[0].data.role.toUpperCase(),
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'SourceSansPro',
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.5,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                          width: 150,
                          child: Divider(
                            color: Colors.teal.shade100,
                          ),
                        ),
                        InkWell(
                            child: Card(
                              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                              child: ListTile(
                                leading: Icon(
                                  Icons.phone,
                                  color: Colors.teal,
                                ),
                                title: Text(
                                  "7305526994",
                                  style: TextStyle(
                                      fontFamily: 'SourceSansPro',
                                      fontSize: 20,
                                      color: Colors.teal.shade900),
                                ),
                              ),

                            ),
                            onTap: (){

                            }
                        ),
                        InkWell(
                          child: Card(
                            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                            child: ListTile(
                              leading: Icon(
                                Icons.email,
                                color: Colors.teal,
                              ),
                              title:Text(
                                widget.loginModels[0].data.email,
                                style: TextStyle(
                                    fontFamily: 'SourceSansPro',
                                    fontSize: 20,
                                    color: Colors.teal.shade900),
                              ),
                            ),
                          ),
                          onTap: (){
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          margin: const EdgeInsets.only(top: 10),
          height: 64,
          width: 64,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            elevation: 0,
            onPressed: () => debugPrint("Add Button pressed"),
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 3, color: Colors.green),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.green,
            ),
          ),
        ),
        bottomNavigationBar: NavBar(
          pageIndex: selectedTab,
          onTap: (index) {
            if (index == selectedTab) {
              items[index]
                  .navKey
                  .currentState
                  ?.popUntil((route) => route.isFirst);
            } else {
              setState(() {
                selectedTab = index;
              });
            }
          },
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
