
import 'package:consulting_app/models/login_model.dart';

class GetMessagemodel {

  bool? status;
  String? message;
  List<MessageCard>? data;

  GetMessagemodel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((element) {
        data!.add(MessageCard.fromJson(element));
      });
    }
  }


}

class MessageCard {
  MessageCard.fromJson(dynamic json) {
    message = json['message'];
    ismymessage = json['isMyMessage'];
    messageDate = json['messageDate'];
    chat_id = json['chat_id'];
  }

  String? message;
  bool? ismymessage;
  String? messageDate;
  String? chat_id;
}

