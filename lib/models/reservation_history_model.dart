

class ReservationHistoryModel {
  bool? status;
  List<UserReservationModel>? data;


  ReservationHistoryModel.fromJson(Map<String, dynamic> json){

    status = json['status'];

    if (json['data'] != null) {
      data = [];
      json['data'].forEach((element) {
        data!.add(UserReservationModel.fromJson(element));
      });
    }

  }

}

class UserReservationModel {

  dynamic user_id;
  String? userName;
  dynamic day;
  dynamic month;
  dynamic from;

  UserReservationModel.fromJson(Map<String, dynamic> json) {
    user_id = json['user_id'];
    userName = json['userName'];
    day = json['day'];
    month = json['month'];
    from = json['from'];
  }
}
