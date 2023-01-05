import 'package:bloc/bloc.dart';
import 'package:consulting_app/Bloc/public_profile/public_profile_state.dart';
import 'package:consulting_app/UI/Components/constants.dart';
import 'package:consulting_app/models/login_model.dart';
import 'package:consulting_app/models/public_profile_model.dart';
import 'package:consulting_app/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';


class PublicProfileCubit extends Cubit<PublicProfileStates> {
  PublicProfileCubit() : super(PublicProfileInitialState());

  static PublicProfileCubit get(context) => BlocProvider.of(context);


  PublicProfileModel? publicExpertProfileModel;

  void getPublicExpertProfileData(int id) {
    emit(PublicExpertProfileLoadingState());
    DioHelper.getData(
      url: 'profile/${id}',
      //token: token,
    ).then((value) {
      publicExpertProfileModel = PublicProfileModel.fromJson(value.data);
      print(publicExpertProfileModel!.data!.user!.name);
      print(publicExpertProfileModel!.data!.user!.phone);
      print(publicExpertProfileModel!.data!.user!.email);
      emit(PublicExpertProfileSuccessState(publicExpertProfileModel!));
    }).catchError((error) {
      emit(PublicExpertProfileErrorState(error.toString()));
      print(error.toString());

    });
  }


  PublicProfileModel? publicUserProfileModel;

  void getPublicUserProfileModelData(int id) {
    emit(PublicUserProfileLoadingState());
    DioHelper.getData(
      url: 'profile/${id}',
      //token: token,
    ).then((value) {
      publicUserProfileModel = PublicProfileModel.fromJson(value.data);
      print(publicUserProfileModel!.data!.user!.name);
      print(publicUserProfileModel!.data!.user!.phone);
      print(publicUserProfileModel!.data!.user!.email);
      emit(PublicUserProfileSuccessState(publicUserProfileModel!));
    }).catchError((error) {
      emit(PublicUserProfileErrorState(error.toString()));
      print(error.toString());

    });
  }




}
