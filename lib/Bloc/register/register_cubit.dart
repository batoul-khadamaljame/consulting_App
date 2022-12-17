import 'dart:io';

import 'package:consulting_app/Bloc/register/register_state.dart';
import 'package:consulting_app/UI/Components/constants.dart';
import 'package:consulting_app/models/login_model.dart';
import 'package:consulting_app/network/remote/dio_helper.dart';
import 'package:consulting_app/network/remote/end_point.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      this.image = imageTemp;

    } on PlatformException {
      print('Failed to pick image');
    }
    emit(PickImage());
  }



  bool isPassword = true;
  IconData suffix = Icons.visibility_off;

  int? isExpert;

  void user(){
    isExpert = 0;
    print('$isExpert');
  }

  void expert(){
    isExpert = 1;
    print('$isExpert');
  }

  void changePasswordVisibility()
  {
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

  })
  {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER1,
      data:
      {
        //'image' : image,//object from type file
        'name' : name,
        'email' : email,
        'password' : password,
        'phone1' : phone,
        'isExp': isExpert,
      },
    ).then((value)
    {
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel!.data!.user!.name);
      print(loginModel!.data!.user!.phone);
      print(loginModel!.data!.user!.email);
      emit(RegisterSuccessState(loginModel!));
    }).catchError((error)
    {
      emit(RegisterErrorState(error.toString()));
      print(error.toString());
    });
  }


}

