
import 'dart:io';

class HomeModel {
  bool? status;
  List<ExpertCardModel>? data;


  HomeModel.fromJson(Map<String, dynamic> json){

    status = json['status'];

    if (json['data'] != null) {
      data = [];
      json['data'].forEach((element) {
        data!.add(ExpertCardModel.fromJson(element));
      });
    }

  }

}


class ExpertCardModel {

  int? id;
  //dynamic rate;
  String? name;
  String? type;
  dynamic price;
  //File? image;
  //bool? inFavorites;

  ExpertCardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    //rate = json['rate'];
    name = json['name'];
    type = json['type'];
    price = json['price'];
    //image = json['image'];
    //inFavorites = json['in_favorites'];
  }
}
