
class ReservationDoneModel{

  bool? status;
  String? message;

  ReservationDoneModel.fromJson(dynamic json) {
    status = json['status']!= null ? json['status']: null;
    message = json['message'];
  }

}