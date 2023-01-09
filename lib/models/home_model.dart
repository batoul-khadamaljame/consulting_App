
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
  dynamic rate;
  String? name;
  String? type;
  dynamic price;
  String? image_url;
  dynamic favorite_status;

  ExpertCardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rate = json['rate'];
    name = json['name'];
    type = json['type'];
    price = json['price'];
    image_url = json['image_url'];
    favorite_status = json['favorite_status'];
  }
}
