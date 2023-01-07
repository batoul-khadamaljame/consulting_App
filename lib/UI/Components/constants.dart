

import 'package:consulting_app/Bloc/consulting_cubit.dart';
import 'package:consulting_app/Bloc/register/register_cubit.dart';
import 'package:consulting_app/UI/Screens/expertRegister_screen.dart';
import 'package:consulting_app/UI/Screens/login_screen.dart';
import 'package:consulting_app/UI/Screens/userRegister_screen.dart';
import 'package:consulting_app/network/local/cash_helper.dart';
import 'package:flutter/material.dart';


void signOut(context)
{
  //Login
  emailControllerLogin.clear();
  passwordControllerLogin.clear();

  //Register
  firstnameControllerRegister.clear();
  lastnameControllerRegister.clear();
  RegisterCubit.get(context).imageString = "assets/images/imageprofile.jpeg";
  RegisterCubit.get(context).file = null;
  RegisterCubit.get(context).image = null;
  emailControllerRegister.clear();
  passwordControllerRegister.clear();
  confirmpasswordControllerRegister.clear();
  numberControllerRegister.clear();

  medicinePriceControllerRegister.clear();
  careerPriceControllerRegister.clear();
  psychologyPriceControllerRegister.clear();
  familyPriceControllerRegister.clear();
  managementPriceControllerRegister.clear();
  OtherNamesControllerRegister.clear();
  OtherPricesControllerRegister.clear();
  cityControllerRegister.clear();
  countryControllerRegister.clear();
  descriptionControllerRegister.clear();
  RegisterCubit.get(context).days.clear();
  startTimeControllerRegister.clear();
  endTimeControllerRegister.clear();
  starttimesControllerRegister.clear();
  endtimesControllerRegister.clear();

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