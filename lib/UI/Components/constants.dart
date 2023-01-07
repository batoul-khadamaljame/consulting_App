

import 'package:consulting_app/Bloc/consulting_cubit.dart';
import 'package:consulting_app/UI/Screens/login_screen.dart';
import 'package:consulting_app/network/local/cash_helper.dart';
import 'package:flutter/material.dart';


void signOut(context)
{
  CacheHelper.signOut(key: 'token').then((value)
  {
    if(value)
    {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),),
              (route) => false);
    }
  });
}


void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
//String? token;   =>  we write the value of token when we want to test the token without login screen
String? token;
bool switchValue = false;