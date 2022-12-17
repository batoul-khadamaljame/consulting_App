
import 'package:consulting_app/Bloc/register/register_cubit.dart';
import 'package:consulting_app/theme/theme.dart';
import 'package:flutter/material.dart';


class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
            color: ThemeColors.backgroundColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  //! Login Button
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 30),
                    width: width,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('/login');
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 20,color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.12,
                  ),
                  Container(
                    width: width,
                    padding: const EdgeInsets.only(left: 40),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: width,
                    padding: const EdgeInsets.only(left: 40),
                    child: const Text(
                      "Sign up by choosing your role.",
                      style: TextStyle(
                          fontSize: 16,color: Colors.black
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),

                  Container(
                    height: height * 0.2,
                    width: width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const RadialGradient(
                          radius: 3,colors: [Colors.blueAccent,Colors.purple]
                      ),
                      border: Border.all(
                        color: Colors.blue,
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(30),
                        onTap: () {
                          RegisterCubit.get(context)
                              .user();
                          Navigator.of(context).pushNamed('/userRegister');
                        },
                        child :Column(
                          children: [
                            Container(
                                width: width * 0.65,
                                padding: const EdgeInsets.only(top: 14),
                                child: const Icon(
                                  Icons.supervised_user_circle,
                                  size: 40,
                                )
                            ),
                            SizedBox(height: height/26,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: width * 0.65,
                                  height: height*0.07,
                                  padding: const EdgeInsets.only(left: 10, top: 10),
                                  child: const Text(
                                    "I'm a User",
                                    style: TextStyle(
                                        fontSize: 22, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_right_outlined,
                                  size: 40,
                                ),

                              ],
                            )
                          ],
                        ),

                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: height * 0.2,
                    width: width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const RadialGradient(
                          radius: 5,colors: [Colors.deepPurple,Colors.blue]
                      ),
                      border: Border.all(
                        color: Colors.deepPurple,
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(30),
                        onTap: () {
                          RegisterCubit.get(context)
                              .expert();
                          Navigator.of(context).pushNamed('/userRegister');

                        },

                        child :Column(
                          children: [
                            Container(
                                width: width * 0.65,
                                padding: const EdgeInsets.only(top: 14),
                                child: const Image(
                                  image: AssetImage('assets/img.png'),
                                  height: 40,
                                  width: 50,
                                )
                            ),
                            SizedBox(height: height/26,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: width * 0.65,
                                  height: height*0.07,
                                  padding: const EdgeInsets.only(left: 10, top: 10),
                                  child: const Text(
                                    "I'm an Expert",
                                    style: TextStyle(
                                        fontSize: 22, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_right_outlined,
                                  size: 40,
                                ),

                              ],
                            )
                          ],
                        ),

                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}