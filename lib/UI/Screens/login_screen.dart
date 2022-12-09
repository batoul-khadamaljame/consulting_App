import 'dart:ffi';

import 'package:consulting_app/Bloc/enter_moblie_number_cubit.dart';
import 'package:consulting_app/Bloc/input_date_cubit.dart';
import 'package:consulting_app/UI/Widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:consulting_app/theme/theme.dart';

var myemail = TextEditingController();
var mypassword = TextEditingController();

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    double heightscreen = MediaQuery.of(context).size.height;
    double widthscreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: heightscreen,
                width: widthscreen,
                color: ThemeColors.backgroundColor,
                child: Column(children: [
                  Container(
                    width: double.infinity,
                    // height: 100,
                    child: Image.asset(
                      "assets/images/image1.png",
                      fit: BoxFit.cover,
                      // height: 200,
                    ),
                  ),
                  SizedBox(
                    height: heightscreen * 0.09,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Text(
                              'Welcom Back..',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: heightscreen * 0.05,
                        ),
                        TextFormField(
                          controller: myemail,
                          keyboardType: TextInputType.emailAddress,
                          onFieldSubmitted: (String value) {
                            print(value);
                          },
                          decoration: InputDecoration(
                            labelText: "Enter Email",
                            prefixIcon: const Icon(
                              Icons.email,
                              color: ThemeColors.icon,
                            ),
                            labelStyle: const TextStyle(
                              color: ThemeColors.highlight,
                            ),
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35.0),
                              borderSide: const BorderSide(
                                color: ThemeColors.bordertextfromfiled,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: heightscreen * 0.03,
                        ),
                        TextFormField(
                          obscureText: _isObscure,
                          controller: mypassword,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: ' password',
                            labelStyle: TextStyle(
                              color: Colors.deepPurpleAccent,
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: ThemeColors.icon,
                            ),
                            suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: ThemeColors.icon,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                }),
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35.0),
                              borderSide: BorderSide(
                                color: ThemeColors.bordertextfromfiled,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: heightscreen * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MaterialButton(
                              onPressed: () {},
                              child: const Text(
                                'Forgot Password?',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 11,
                                  // decoration: TextDecoration.underline,
                                  color: ThemeColors.highlight,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: RadialGradient(radius: 4, colors: [
                              Color.fromARGB(255, 141, 68, 243),
                              Colors.purple
                            ]),
                            border: Border.all(
                              color: Color.fromARGB(255, 163, 33, 243),
                            ),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: ThemeColors.splashinkweel,
                              borderRadius: BorderRadius.circular(30),
                              onTap: () {
                                Navigator.of(context).pushNamed('/home');
                              },
                              child: const Center(
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyle(
                                      color: ThemeColors.backgroundColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: RadialGradient(radius: 4, colors: [
                              Color.fromARGB(255, 141, 68, 243),
                              Colors.purple
                            ]),
                            border: Border.all(
                              color: Color.fromARGB(255, 163, 33, 243),
                            ),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              // highlightColor: Colors.orange.withOpacity(0.3),
                              splashColor: ThemeColors.splashinkweel,
                              borderRadius: BorderRadius.circular(30),
                              onTap: () {
                                Navigator.of(context).pushNamed('/home');
                              },
                              child: const Center(
                                  child: Text(
                                    'login as Guests',
                                    style: TextStyle(
                                      color: ThemeColors.backgroundColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(height: heightscreen * 0.05),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Don\'t have an acount?'),
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushReplacementNamed('/getStarted');
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: ThemeColors.highlight,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}