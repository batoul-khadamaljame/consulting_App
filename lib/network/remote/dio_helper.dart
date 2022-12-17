import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl:'http://10.0.2.2:8000/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async
  {


    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,
  }) async
  {

    dio!.options.headers =
    {
      'Accept' : 'application/json',
    };

    return dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}