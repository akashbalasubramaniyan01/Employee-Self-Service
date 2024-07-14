import 'package:employee_self_service/Screen/sign_in.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../main.dart';
import 'LeaveApproveScreen.dart';
import 'ListPermissionPage.dart';
import 'NewLeave.dart';
import 'ODhistoryCard.dart';
import 'ProfilePage.dart';
import 'TicketDetails.dart';
import 'baseUrlPage.dart';
import 'insertLeave.dart';
import 'introductionScreen.dart';
import 'main_screen.dart';



final Routes = [
  GetPage(name: '/OnBoard', page: () => OnBoardingPage()),
  GetPage(name: '/LeaveCard', page: () => TicketDeatils()),
  GetPage(name: '/', page: () => MyHomePage()),
  GetPage(name: '/SignIn', page: () => SignIn()),
  GetPage(name: '/MainScreen', page: () => MainScreen()),
  GetPage(name: '/NewLeave', page: () => NewLeave()),
  GetPage(name: '/LeaveArrovel', page: () => LeaveApprovel()),
  GetPage(name: '/Profile', page: () => Profilepage()),
  GetPage(name: '/BaseUrl', page: () => BaseUrl()),
  GetPage(name: '/ODHistory', page: () => OdHistoryCardPage()),
  GetPage(name: '/InsertLeave', page: () => FormPopup()),
  GetPage(name: '/ListPermmision', page: () => ListPermmision()),
];
