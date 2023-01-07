class PhotoModel
{
  bool? status;
  String? message;
  PhotoModel.fromJson(Map<String ,dynamic>json)
  {
    status = json['status'];
    message = json['message'];
  }
}