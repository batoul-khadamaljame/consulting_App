import 'package:consulting_app/Bloc/register/register_state.dart';
import 'package:consulting_app/UI/Components/constants.dart';
import 'package:consulting_app/models/login_model.dart';
import 'package:consulting_app/network/remote/dio_helper.dart';
import 'package:consulting_app/network/remote/end_point.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = Icons.visibility_off;

  bool? isExpert;

  void user(){
    isExpert = false;
    print('$isExpert');
  }

  void expert(){
    isExpert = true;
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
      url: REGISTER,
      data:
      {
        'name' : name,
        'email' : email,
        'password' : password,
        'phone' : phone,
      },
      token: token,
    ).then((value)
    {
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel!.data!.name);
      print(loginModel!.data!.phone);
      print(loginModel!.data!.email);
      emit(RegisterSuccessState(loginModel!));
    }).catchError((error)
    {
      emit(RegisterErrorState(error.toString()));
      print(error.toString());
    });
  }



}

