import 'dart:io';

import 'package:consulting_app/Bloc/register/register_state.dart';
import 'package:consulting_app/UI/Components/constants.dart';
import 'package:consulting_app/models/login_model.dart';
import 'package:consulting_app/models/photo_model.dart';
import 'package:consulting_app/network/remote/dio_helper.dart';
import 'package:consulting_app/network/remote/end_point.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  File? image;

  MultipartFile? file;



  String imageString = "assets/images/imageprofile.jpeg";
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      this.image = imageTemp;
      String fileName = image.path.split('/').last;
      file = await MultipartFile.fromFile(image.path, filename: fileName);
    } on PlatformException {
      print('Failed to pick image');
    }
    emit(PickImage());
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_off;

  int? isExpert;

  void user() {
    isExpert = 0;
    print('$isExpert');
  }

  void expert() {
    isExpert = 1;
    print('$isExpert');
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off : Icons.visibility;
    emit(ChangePasswordVisibility());
  }

  LoginModel? loginModel;

  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoadingState());
    DioHelper.postData1(
      url: REGISTER1,
      data: FormData.fromMap({
        'name': name,
        'email': email,
        'password': password,
        'phone1': phone,
        'isExp': isExpert,
        'img': await MultipartFile.fromFile(
          image!.path,
          filename: image!.path.split('/').last,
        ),
      }),
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);

      emit(RegisterSuccessState(loginModel!));
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
      print(error.toString());
    });
  }

  List<Services> services = [];

  void addService(String id, String name, dynamic price) {
    services.add(Services(id, name, price));
  }

  void deleteService() {
    services.removeLast();
  }

  void deleteSpecificService(int id) {
    services.removeWhere((element) => element.id == id);
  }

  List<bool?> days = [];

  void addDays(isSunday, isMonday, isTuesday, isWednesday, isThursday, isFriday,
      isSaturday) {
    days.add(isSunday);
    days.add(isMonday);
    days.add(isTuesday);
    days.add(isWednesday);
    days.add(isThursday);
    days.add(isFriday);
    days.add(isSaturday);
  }

  List<Time> times = [];

  void addTimes(dynamic from, dynamic to) {
    times.add(Time(from, to));
  }

  void deleteTimes() {
    times.removeLast();
  }

  Future<void> ExpertRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String country,
    required String city,
    required String experience,
  }) async {
    emit(RegisterLoadingState());

    // var array = services.map((e) => e.toJson()).toList();
    // var array2 = times.map((e) => e.toJson()).toList();

    print(services);
    print(times);

    print('"name": $name');
    print('"email": $email');
    print('"password": $password');
    print('"phone1": $phone');
    print('"isExp": $isExpert');
    print('"country": $country');
    print('"city": $city');
    print('"skills": $experience');
    print('"categories": $services'.toString());
    print('"days": $days');
    print('"durations": $times'.toString());

    DioHelper.postData(url: REGISTER2,
        //data: FormData.fromMap({
        data: {
          'name': name,
          'email': email,
          'password': password,
          'phone1': phone,
          'isExp': isExpert,
          'country': country,
          'city': city,
          'skills': experience,
          'categories': services,
          'days': days,
          'durations': times,
          //}

          //'img':await MultipartFile.fromFile(image!.path,filename: image!.path.split('/').last,),
          //}),
        }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      //print(loginModel!.data!.user!.name);
      //print(loginModel!.data!.user!.phone);
      //print(loginModel!.data!.user!.email);
      emit(RegisterSuccessState(loginModel!));
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
      print(error.toString());
    });
  }

  PhotoModel? photoModel;

  void ExpertPhotoRegister() async {
    emit(RegisterPhotoLoadingState());
    DioHelper.postData1(
      url: 'registerExpertphoto',
      data: FormData.fromMap({
        'img': await MultipartFile.fromFile(
          image!.path,
          filename: image!.path.split('/').last,
        ),
      }),
      token: token,
    ).then((value) {
      photoModel = PhotoModel.fromJson(value.data);

      emit(RegisterPhotoSuccessState(photoModel!));
    }).catchError((error) {
      emit(RegisterPhotoErrorState(error.toString()));
      print(error.toString());
    });
  }
}

class Services {
  final String id;
  final String name;
  final dynamic price;

  Services(this.id, this.name, this.price);

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.id;
    data['category_name'] = this.name;
    data['price'] = this.price;
    return data;
  }
}

class Time {
  final dynamic from;
  final dynamic to;

  Time(this.from, this.to);

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    return data;
  }
}
