class CreatChatmodel {
  bool? status;
  String? message;
  List<ChatCreatDadtaModel>? data;

  CreatChatmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    message = json['message'];

    if (json['data'] != null) {
      data = [];
      json['data'].forEach((element) {
        data!.add(ChatCreatDadtaModel.fromJson(element));
      });
    }
  }
}

class ChatCreatDadtaModel {
  String? userid;
  String? expertid;
  String? chatid;
  String? createdtime;
  String? updatedtime;
  //File? image;

  ChatCreatDadtaModel.fromJson(Map<String, dynamic> json) {
    userid = json['user_id'];
    expertid = json['expert_id'];
    chatid = json['id'];
    createdtime = json['created_at'];
    updatedtime = json['updated_at'];
    //image = json['image'];
  }
}