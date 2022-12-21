class LoginModel {

  LoginModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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
    balance = json['balance'];
  }
  int? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  //String? image;
  int? isExp;
  int? balance;

}

class Expert{
  Expert.fromJson(Map<String, dynamic> json){
    //expertInfo = json['expertInfo'] != null ? expertInfo.fromJson(json['expertInfo']) : null;
    //days = json['days'] != null ? days.fromJson(json['days']) : null;


  }
  ExpertInfo? expertInfo;
  Days? days;
}

class ExpertInfo{
  ExpertInfo.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    city = json['city'];
    skills = json['skills'];
  }
  String? country;
  String? city;
  String? skills;

}

class Days{

}
