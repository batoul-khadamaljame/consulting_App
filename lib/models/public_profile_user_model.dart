class PublicProfileUserModel {

  PublicProfileUserModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }

  bool? status;
  String? message;
  Data? data;

}

class Data{
  Data.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone1'];
  }

  String? name;
  String? email;
  String? phone;

}