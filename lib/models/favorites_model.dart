import 'dart:io';

class FavoriteModel {

  FavoriteModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? status;
  dynamic message;
  Data? data;
}

class Data {
  List<FavoritesData>? data;
  Data.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(FavoritesData.fromJson(v));
      });
    }
  }
}

class FavoritesData {

  FavoritesData.fromJson(dynamic json) {
    id = json['id'];
    expert = json['expert'] != null ? Expert.fromJson(json['expert']) : null;
  }
  int? id;
  Expert? expert;

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

