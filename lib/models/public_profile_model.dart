import 'dart:convert';

import 'package:consulting_app/models/favorites_model.dart';

class PublicProfileModel {

  PublicProfileModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != '' ? Data.fromJson(json['data']) : null;
  }

  bool? status;
  String? message;
  Data? data;

}


class Data {

  Data.fromJson(dynamic json){
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    expert = json['expert'] != null ? Expert.fromJson(json['expert']) : null;
    token = json['token'];
  }
  User? user;
  Expert? expert;
  String? token;
}

class User {

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone1'];
    //image = json['image'];
    isExp = json['isExp'];
  }
  int? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  //String? image;
  dynamic isExp;

}

class Expert{
  Expert.fromJson(Map<String, dynamic> json){
    expertInfo = json['expertInfo'] != null ? ExpertInfo.fromJson(json['expertInfo']) : null;
    days = json['days'] != null ? Days.fromJson(json['days']) : null;

    if (json['experiences'] != null) {
      experiences=[];
      json['experiences'].forEach((element) {
        experiences!.add(Experiences.fromJson(element));
      });
    }

    if (json['duration'] != null) {
      duration = [];
      json['duration'].forEach((element) {
        duration!.add(Duration.fromJson(element));
      });
    }
  }

  ExpertInfo? expertInfo;
  Days? days;

  List<Experiences>? experiences;
  List<Duration>? duration;


}

class ExpertInfo{
  ExpertInfo.fromJson(Map<String, dynamic> json) {
    expert_id = json['user_id'];
    country = json['country'];
    city = json['city'];
    skills = json['skills'];
  }
  String? country;
  String? city;
  String? skills;
  dynamic expert_id;

}

class Days{
  Days.fromJson(Map<String, dynamic> json) {
    sunday = json['sunday'];
    monday = json['monday'];
    tuesday = json['tuesday'];
    wednesday = json['wednsday'];
    thursday = json['thursday'];
    friday = json['friday'];
    saturday = json['saturday'];

  }
  dynamic sunday;
  dynamic monday;
  dynamic tuesday;
  dynamic wednesday;
  dynamic thursday;
  dynamic friday;
  dynamic saturday;

/*
bool? sunday;
  bool? monday;
  bool? tuesday;
  bool? wednesday;
  bool? thursday;
  bool? friday;
  bool? saturday;
*/

}

class Experiences{

  Experiences.fromJson(dynamic json)
  {
    category_id = json['category_id'];
    category_name = json['category_name'];
    price = json['price'];
  }


  dynamic category_id;
  String? category_name;
  dynamic price;

}




class Duration{
  Duration.fromJson(dynamic json) {
    from = json['from'];
    to = json['to'];

  }

  dynamic from;
  dynamic to;

}