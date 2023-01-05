
class ReservertionModel{

  bool? status;
  Data? data;

  ReservertionModel.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != '' ? Data.fromJson(json['data']) : null;
  }

}

class Data{

  Data.fromJson(Map<String, dynamic> json){

    experience_id = json['experience_id'];
    name = json['name'];
    expert_id = json['expert_id'];
    type = json['type'];
    price = json['price'];
    days = json['days'] != null ? Days.fromJson(json['days']) : null;
    workStartTimes = json['worktimes'];

  }

  dynamic experience_id;
  String? name;
  dynamic expert_id;
  String? type;
  dynamic price;
  Days? days;
  List<dynamic>?workStartTimes;

}

class Days{
  Days.fromJson(Map<String, dynamic> json) {
    sunday = json['sunday'];
    monday = json['monday'];
    tuesday = json['tuesday'];
    wednesday = json['wednsday'];
    thursday = json['thursday'];
    friday = json['friday'];
    saturday = json['saturday'];
  }

  dynamic sunday;
  dynamic monday;
  dynamic tuesday;
  dynamic wednesday;
  dynamic thursday;
  dynamic friday;
  dynamic saturday;

}