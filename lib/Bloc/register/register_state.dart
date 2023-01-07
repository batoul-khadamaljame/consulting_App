import 'package:consulting_app/models/login_model.dart';
import 'package:consulting_app/models/photo_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates{}

class PickImage extends RegisterStates{}

class ChangePasswordVisibility extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates
{
  final LoginModel loginModel;

  RegisterSuccessState(this.loginModel);
}
class RegisterErrorState extends RegisterStates
{
  final String error;

  RegisterErrorState(this.error);
}

class RegisterPhotoLoadingState extends RegisterStates{}

class RegisterPhotoSuccessState extends RegisterStates
{
  final PhotoModel photoModel;

  RegisterPhotoSuccessState(this.photoModel);
}
class RegisterPhotoErrorState extends RegisterStates
{
  final String error;

  RegisterPhotoErrorState(this.error);
}