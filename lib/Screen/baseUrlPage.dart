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
import 'package:html/parser.dart' show parse;  // Add this import



class AppConfig {
  static final AppConfig _instance = AppConfig._internal();

  factory AppConfig() {
    return _instance;
  }

  AppConfig._internal();

  String baseUrl = "";

  void updateBaseUrl(String newBaseUrl) {
    baseUrl = newBaseUrl;
    print("baseUrl$baseUrl");
  }
}
class BaseUrl extends StatefulWidget {

  const BaseUrl({super.key});

  @override

  State<BaseUrl> createState() => _BaseUrlState();
}

class _BaseUrlState extends State<BaseUrl> {
  List <Loginmodel> LoginModels = [];

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController BaseUrl = TextEditingController();
  bool _passwordVisible= false;

  String? _errorMessage;
  bool _validateUrl(String url) {
    final urlPattern = r'^(http:\/\/|https:\/\/).*$';
    final result = RegExp(urlPattern).hasMatch(url);
    return result;
  }

  void _handleSubmit() {
    setState(() async {
   /*   _errorMessage = null; // Reset error message
      if (!_validateUrl(BaseUrl.text)) {
        _errorMessage = 'Please enter a valid URL starting with http:// or https://';
      } else */
      {
         if(BaseUrl.text=="https://ri-square.com:4430/") {
           final prefs = await SharedPreferences.getInstance();

           print('URL submitted: ${BaseUrl.text}');
           prefs.setString('url', BaseUrl.text);
           Get.toNamed('/SignIn');
         }
        // Add your submit logic here
      }
    });
  }
  @override
  void initState() {
    _passwordVisible = false;
    // TODO: implement initState
    super.initState();
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
                  "Base Url",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w300,color:Colors.black,fontSize:46),
                ),
                const SizedBox(height: 15),
                Container(
                    width: 200,
                    height: 200,
                    child: Image.asset("assets/Loginpage.jpg",)),
                //SizedBox(height: size.height * 0.01),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 10,
                  ),
                  child: TextField(
                    controller: BaseUrl,
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
                      hintText: "Enter Base Url",
                      hintStyle: const TextStyle(
                        color: Colors.black45,
                        fontSize: 19,
                      ),
                      errorText: _errorMessage,
                    ),
                  ),
                ),
               


                SizedBox(height: size.height * 0.07),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      // for sign in button
                      InkWell(

                        onTap: () {


                          ValidateUrl(context);

                        },
                        child: Container(
                          width: size.width,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Center(
                            child: Text(
                              "Submit",
                              style: TextStyle(
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
  Future<void> ValidateUrl(BuildContext context, ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('url', "https://${BaseUrl.text}.ri-square.com/");

      print('URL submitted: ${BaseUrl.text}');
      var url = "https://${BaseUrl.text}.ri-square.com/welcome";
      print(url);

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        Get.toNamed('/SignIn');
      } else {
        _showErrorBanner(context, response.statusCode, "Invalid Url");
      }
    } catch (e) {
      print(e.toString());
      _showErrorBanner(context, null, "Invalid Url Please Check");
    }
  }

  void _showErrorBanner(BuildContext context, int? statusCode, String message) {
    final materialBanner = MaterialBanner(
      elevation: 0,
      backgroundColor: Colors.transparent,
      forceActionsBelow: false,
      content: AwesomeSnackbarContent(
        title: statusCode != null ? statusCode.toString() : 'Error',
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
}

