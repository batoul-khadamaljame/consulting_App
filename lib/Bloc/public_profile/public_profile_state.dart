import 'package:consulting_app/models/login_model.dart';
import 'package:consulting_app/models/public_profile_model.dart';

abstract class PublicProfileStates {}

class PublicProfileInitialState extends PublicProfileStates{}

class PublicExpertProfileLoadingState extends PublicProfileStates{}

class PublicExpertProfileSuccessState extends PublicProfileStates
{
  final PublicProfileModel publicExpertProfileModel;

  PublicExpertProfileSuccessState(this.publicExpertProfileModel);
}
class PublicExpertProfileErrorState extends PublicProfileStates
{
  final String error;

  PublicExpertProfileErrorState(this.error);
}



class PublicUserProfileLoadingState extends PublicProfileStates{}

class PublicUserProfileSuccessState extends PublicProfileStates
{
  final PublicProfileModel publicUserProfileModel;

  PublicUserProfileSuccessState(this.publicUserProfileModel);
}
class PublicUserProfileErrorState extends PublicProfileStates
{
  final String error;

  PublicUserProfileErrorState(this.error);
}


class ChangeRateState extends PublicProfileStates{}