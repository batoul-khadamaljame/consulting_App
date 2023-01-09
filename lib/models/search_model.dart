
import 'dart:io';

class SearchModel {
  bool? status;
  List<ExpertCardModelSearch>? data;


  SearchModel.fromJson(Map<String, dynamic> json){

    status = json['status'];

    if (json['data'] != null) {
      data = [];
      json['data'].forEach((element) {
        data!.add(ExpertCardModelSearch.fromJson(element));
      });
    }

  }

}


class ExpertCardModelSearch {

  int? id;
  dynamic rate;
  String? name;
  String? type;
  dynamic price;
  String? image_url;
  dynamic favorite_status;

  ExpertCardModelSearch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rate = json['rate'];
    name = json['name'];
    type = json['type'];
    price = json['price'];
    image_url = json['image_url'];
    favorite_status = json['favorite_status'];
  }
}
