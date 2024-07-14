import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screen/LoginController.dart';
import 'Screen/Routes.dart';
import 'Screen/model/loginmodel.dart';
import 'Screen/sign_in.dart';
import 'Screen/spash_screen.dart';
import 'config/axpertAppSettings.dart';
import 'package:http/http.dart' as http;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  GlobalConfiguration().loadFromMap(AppSettings);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: Routes,
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  final LoginController loginController = Get.put(LoginController());

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);

    initDeviceId();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Loginmodel> loginModels = [];
  String userName = "";
  String password = "";
  String url = "";

  Future<void> initDeviceId() async {
    print("call api");

    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('UserName') ?? "";
      password = prefs.getString('PassWord') ?? "";
      url = prefs.getString('url') ?? "";
    });

    if (userName.isNotEmpty && password.isNotEmpty&&url!="") {
      Timer(Duration(seconds: 3), () {
        loginController.logins(userName, password,url);
      });
    } else {
      print(url);
      //prefs.remove('url');
     // Timer(Duration(seconds: 3), () => Get.toNamed('/SignIn'));
      if(url=="") {
        Timer(Duration(seconds: 3), () => Get.toNamed('/BaseUrl'));
      }
      else{
        Timer(Duration(seconds: 3), () => Get.toNamed('/SignIn'));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: AnimatedBuilder(
              animation: _animation,
              child: Image.asset("assets/Applogo.jpg", width: 100),
              builder: (context, child) {
                return Transform.rotate(
                  angle: _animation.value * 2.0 * 3.1415927,
                  child: child,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
