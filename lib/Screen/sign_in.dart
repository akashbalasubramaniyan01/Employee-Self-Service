import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:employee_self_service/Screen/model/loginmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/colors.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:html/parser.dart' show parse;

import 'baseUrlPage.dart';  // Add this import
class SignIn extends StatefulWidget {

  const SignIn({super.key});

  @override

  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  List <Loginmodel> LoginModels = [];

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController BaseUrl = TextEditingController();
  bool _passwordVisible= false;

  void initState() {
    super.initState();
    _passwordVisible = false;
    Url();
  }
  String urls="";
  Url() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      urls = prefs.getString('url') ?? "";
    });

  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
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
        child: SafeArea(
            child: ListView(
              children: [
                SizedBox(height: size.height * 0.03),
                Text(
                  "Sign In",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w300,color:Colors.black,fontSize:46),
                ),
                const SizedBox(height: 15),
                Container(
                    width: 200,
                    height: 200,
                    child: Image.asset("assets/Loginpage.jpg",)),
                //SizedBox(height: size.height * 0.01),

                myTextField("Enter Mobile Number", Colors.white,emailController),
                myTextField("Password", Colors.black26, passwordController, isPassword: true),


                SizedBox(height: size.height * 0.07),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      // for sign in button
                      InkWell(

                        onTap: () {


                          if(emailController.text==""){
                            showDialog(
                              context: context,
                              builder: (_) {
                                return  AlertDialog(
                                  elevation: 14,
                                  backgroundColor: backgroundColor1,
                                  title: Center(child: Text('Please Enter the Email', style: GoogleFonts.quicksand(textStyle: Theme.of(context).textTheme.bodyMedium))),

                                );
                              },
                            );
                          }
                          else if(passwordController.text==""){
                            showDialog(
                              context: context,
                              builder: (_) {
                                return  AlertDialog(
                                  elevation: 14,
                                  backgroundColor:backgroundColor1,
                                  title: Text('Please Enter the Password',style: GoogleFonts.quicksand(textStyle: Theme.of(context).textTheme.bodyMedium)),

                                );
                              },
                            );
                          }
                          else{
                            login(emailController.text,passwordController.text);

                          }


                        },
                        child: Container(
                          width: size.width,
                          padding:  EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child:  Center(
                            child: Text(
                              "Sign In",
                              style:  GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 18),




                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Container socialIcon(image) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Image.asset(
        image,
        height: 35,
      ),
    );
  }

  Container myTextField(String hint, Color color, TextEditingController controller, {bool isPassword = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 10,
      ),
      child: TextField(
        obscureText: isPassword && !_passwordVisible,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 22,
          ),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.black45,
            fontSize: 19,
          ),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          )
              : null,
        ),
      ),
    );
  }
  void showSnackbar(BuildContext context, String title, String message) {
    final materialBanner = MaterialBanner(
      elevation: 0,
      backgroundColor: Colors.transparent,
      forceActionsBelow: false,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: ContentType.failure,
        inMaterialBanner: true,
      ),
      actions: const [SizedBox.shrink()],
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(materialBanner);

    Future.delayed(const Duration(seconds: 2), () {
      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    });

  }
 login(String email , password)  async {

   final prefs = await SharedPreferences.getInstance();
    try{

      var url = "${urls}getin";
      print(url);
       final response = await http.put(
          Uri.parse(url),
          body: jsonEncode(
              //hrms10002@gmail.com
              {
                "userid" : email,
                "password": password,
                "count": 0
              }
          ),
          headers: {
            'Content-Type': 'application/json',
          }
      );
      print(jsonEncode(
          {
            'email': email,
            'password': password,
            "count" :0
          }
      ),);
      print(response.statusCode);

      if(response.statusCode == 200)
      {

        var data = jsonDecode(response.body.toString());

        LoginModels = [data]
            .map((taskJson) => Loginmodel.fromJson(taskJson))
            .toList();
        print('Login successfully${[data]}');

        Get.toNamed('/MainScreen', arguments: LoginModels);
        /*Get.toNamed('/MainScreen', arguments: {
          'id': 0,
          'loginModels': LoginModels,
        });*/
        prefs.setString('UserName', email);
        prefs.setString('PassWord', password);
      }
      else if(response.statusCode==400){
        var jsonResponse = json.decode(response.body);
        final materialBanner = MaterialBanner(
          elevation: 0,
          backgroundColor: Colors.transparent,
          forceActionsBelow: false,
          content: AwesomeSnackbarContent(
            title: response.statusCode.toString(),
            message: jsonResponse['error'],
            contentType: ContentType.failure,
            inMaterialBanner: true,
          ),
          actions: const [SizedBox.shrink()],
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentMaterialBanner()
          ..showMaterialBanner(materialBanner);

        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          });
        });
      }


      else {
        var jsonResponse = json.decode(response.body);
        final materialBanner = MaterialBanner(
          elevation: 0,
          backgroundColor: Colors.transparent,
          forceActionsBelow: false,
          content: AwesomeSnackbarContent(
            title: response.statusCode.toString(),
            message: jsonResponse['message'],
            contentType: ContentType.failure,
            inMaterialBanner: true,
          ),
          actions: const [SizedBox.shrink()],
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentMaterialBanner()
          ..showMaterialBanner(materialBanner);

        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          });
        });

      }
    }catch(e){
      print(e.toString());
    }
  }
}

