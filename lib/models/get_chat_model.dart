import 'dart:io';

class GetChatModel {
  bool? status;
  String? message;
  List<ChatDadtaModel>? data;

  GetChatModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    message = json['message'];

    if (json['data'] != null) {
      data = [];
      json['data'].forEach((element) {
        data!.add(ChatDadtaModel.fromJson(element));
      });
    }
  }
}

class ChatDadtaModel {
  dynamic chat_id;
  String? name;
  String? lastMessage;
  String? lastMessageTime;
  //File? image;

  ChatDadtaModel.fromJson(Map<String, dynamic> json) {
    chat_id = json['chat_id'];
    name = json['name'];
    lastMessage = json['lastMessage'];
    lastMessageTime = json['lastMessageTime'];
    //image = json['image'];
  }
}