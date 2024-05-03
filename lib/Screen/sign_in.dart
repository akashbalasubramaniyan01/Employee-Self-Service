import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../Utils/colors.dart';


class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                  "Hello Again!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 37,
                    color: textColor1,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Wellcome back vou've\nbeen missed!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 27, color: textColor2, height: 1.2),
                ),
                SizedBox(height: size.height * 0.04),
                // for username and password
                myTextField("Enter username", Colors.white,emailController),
                myTextField("Password", Colors.black26,passwordController),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Recovery Password               ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: textColor2,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      // for sign in button
                      InkWell(

                        onTap: () {
                          login(emailController.text,passwordController.text);
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
                              "Sign In",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.06),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 2,
                            width: size.width * 0.2,
                            color: Colors.black12,
                          ),
                          Text(
                            "  Or continue with   ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: textColor2,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            height: 2,
                            width: size.width * 0.2,
                            color: Colors.black12,
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.06),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          socialIcon("images/google.png"),
                          socialIcon("images/apple.png"),
                          socialIcon("images/facebook.png"),
                        ],
                      ),
                      SizedBox(height: size.height * 0.07),
                      Text.rich(
                        TextSpan(
                            text: "Not a member? ",
                            style: TextStyle(
                              color: textColor2,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            children: const [ TextSpan(
                              text: "Register now",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),)]
                        ),
                      ),
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

  Container myTextField(String hint, Color color, TextEditingController Controller) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 10,
      ),
      child: TextField(
        controller: Controller,
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
            suffixIcon: Icon(
              Icons.visibility_off_outlined,
              color: color,
            )),
      ),
    );
  }

  void login(String email , password) async {

    try{

      Response response = await http.put(
          Uri.parse('http://122.165.61.194/essapi/getin'),
          body: jsonEncode(
              {
                'userid': email,
                'password': password,
                "count" :0
              }
          ),
          headers: {
            'Content-Type': ' application/json',
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

      if(response.statusCode == 200){

        var data = jsonDecode(response.body.toString());

        print('Login successfully$data');

      }else {
        print('failed');
      }
    }catch(e){
      print(e.toString());
    }
  }
}

