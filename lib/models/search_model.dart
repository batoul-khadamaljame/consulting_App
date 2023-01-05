
import 'dart:io';

class SearchModel {

  bool? status;
  List<ExpertCardSearchModel>? data;


  SearchModel.fromJson(Map<String, dynamic> json){

    status = json['status'];

    if (json['data'] != null) {
      data = [];
      json['data'].forEach((element) {
        data!.add(ExpertCardSearchModel.fromJson(element));
      });
    }

  }

}


class ExpertCardSearchModel {

  int? id;
  //dynamic rate;
  String? name;
  String? type;
  dynamic price;
  //File? image;
  //bool? inFavorites;

  ExpertCardSearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    //rate = json['rate'];
    name = json['name'];
    type = json['type'];
    price = json['price'];
    //image = json['image'];
    //inFavorites = json['in_favorites'];
  }
}
