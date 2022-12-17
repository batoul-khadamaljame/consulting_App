class LoginModel {

  LoginModel.fromJson(dynamic json) {
    status = json['status'];
    //message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? status;
  //String? message;
  Data? data;


}


class Data {

  Data.fromJson(dynamic json){
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
  }
  User? user;
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
