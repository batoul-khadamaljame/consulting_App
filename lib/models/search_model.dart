import 'dart:io';

class SearchModel {

  SearchModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? status;
  dynamic message;
  Data? data;
}

class Data {
  Data.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Expert.fromJson(v));
      });
    }
  }
  List<Expert>? data;

}

class Expert {

  int? id;
  dynamic rate;
  String? name;
  String? type;
  dynamic price;
  File? image;
  bool? inFavorites;

  Expert.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rate = json['rate'];
    name = json['name'];
    type = json['type'];
    price = json['price'];
    image = json['image'];
    inFavorites = json['in_favorites'];
  }

}