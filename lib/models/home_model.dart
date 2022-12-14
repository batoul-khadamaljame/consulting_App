
import 'dart:io';

class HomeModel {
  bool? status;
  DataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataModel.fromJson(json['data']);
  }
}

class DataModel {
  List<ExpertModel> experts = [];

  DataModel.fromJson(Map<String, dynamic> json) {
    //name of map in backend
    json['experts'].forEach((element) {
      experts.add(ExpertModel.fromJson(element));
    });
  }
}

class ExpertModel {

  int? id;
  dynamic rate;
  String? name;
  String? type;
  dynamic price;
  File? image;
  bool? inFavorites;

  ExpertModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rate = json['rate'];
    name = json['name'];
    type = json['type'];
    price = json['price'];
    image = json['image'];
    inFavorites = json['in_favorites'];
  }
}
