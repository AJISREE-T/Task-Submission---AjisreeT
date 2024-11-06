import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:productapp/const/color.dart';

import 'package:productapp/controller/login_controller.dart';
import 'package:productapp/view/home_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool visible = true;
  final loginkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController pswdController = TextEditingController();

  Future<void> _loadLoginDetails() async {
    final loginDetails =
        await context.read<LoginController>().getLoginDetails();
    if (loginDetails['email'] != null && loginDetails['password'] != null) {
      emailController.text = loginDetails['email']!;
      pswdController.text = loginDetails['password']!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Container(
        // padding: EdgeInsets.only(top: 0, left: 20, right: 20),
        height: double.infinity,
        width: double.infinity,
        child: Form(
          key: loginkey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                      text: 'Hey,',
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500),
                      children: [
                        TextSpan(
                          text: '  Bring help to to your door steps',
                          style: TextStyle(
                              fontSize: 20,
                              color: AppColor.homepageTitle,
                              fontWeight: FontWeight.w700),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter an email id';
                    }
                  },
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: 'Enter Email',
                    hintStyle: const TextStyle(fontSize: 14),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: pswdController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter password';
                    }
                  },
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                    hintStyle: const TextStyle(fontSize: 14),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        )),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                          // decoration: TextDecoration.underline,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColor.homepageTitle,
                          letterSpacing: 1),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () async {
                    if (loginkey.currentState!.validate()) {
                      final result =
                          await context.read<LoginController>().loginUser(
                                email: emailController.text.trim(),
                                password: pswdController.text,
                                // context: context,
                              );
                      log(result.toString());
                      if (result['status'] == 'true') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Login failed, please try again.')),
                        );
                      }
                    }
                  },
                  child: Container(
                    height: 55,
                    width: 480,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.homepageTitle),
                    child: const Center(
                        child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    )),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
