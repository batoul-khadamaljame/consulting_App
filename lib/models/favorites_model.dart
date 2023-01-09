

class FavoritesModel {
  bool? status;
  List<ExpertCardModelFavorite>? data;


  FavoritesModel.fromJson(Map<String, dynamic> json){

    status = json['status'];

    if (json['data'] != null) {
      data = [];
      json['data'].forEach((element) {
        data!.add(ExpertCardModelFavorite.fromJson(element));
      });
    }

  }

}


class ExpertCardModelFavorite {

  int? id;
  dynamic rate;
  String? name;
  String? type;
  dynamic price;
  String? image_url;
  bool? favorite_status;

  ExpertCardModelFavorite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rate = json['rate'];
    name = json['name'];
    type = json['type'];
    price = json['price'];
    image_url = json['image_url'];
    favorite_status = json['favorite_status'];
  }
}
