import 'package:bloc/bloc.dart';
import 'package:consulting_app/Bloc/public_profile/public_profile_state.dart';
import 'package:consulting_app/Bloc/reservation/reservation_state.dart';
import 'package:consulting_app/UI/Components/components.dart';
import 'package:consulting_app/UI/Components/constants.dart';
import 'package:consulting_app/models/login_model.dart';
import 'package:consulting_app/models/public_profile_model.dart';
import 'package:consulting_app/models/public_profile_user_model.dart';
import 'package:consulting_app/models/rate_model.dart';
import 'package:consulting_app/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';


class PublicProfileCubit extends Cubit<PublicProfileStates> {
  PublicProfileCubit() : super(PublicProfileInitialState());

  static PublicProfileCubit get(context) => BlocProvider.of(context);


  PublicProfileModel? publicExpertProfileModel;

  void getPublicExpertProfileData(id) {
    emit(PublicExpertProfileLoadingState());
    DioHelper.getData(
      url: 'profile/${id}',
      token: token,
    ).then((value) {
      publicExpertProfileModel = PublicProfileModel.fromJson(value.data);

      emit(PublicExpertProfileSuccessState());
    }).catchError((error) {
      emit(PublicExpertProfileErrorState(error.toString()));
      print(error.toString());

    });
  }


  PublicProfileModel? publicUserProfileModel;

  void getPublicUserProfileModelData(id) {
    emit(PublicUserProfileLoadingState());
    DioHelper.getData(
      url: 'profile/${id}',
    ).then((value) {
      publicUserProfileModel = PublicProfileModel.fromJson(value.data);
      emit(PublicUserProfileSuccessState());
    }).catchError((error) {
      emit(PublicUserProfileErrorState(error.toString()));
      print(error.toString());

    });
  }

  RateModel? rateModel;

  void changeRate(rating,expert_id,context){
    emit(ChangeRateLoadingState());
    DioHelper.postData(
      url: 'rate',
      data: {
        'rate' : rating,
        'expert_id':expert_id,
      },
      token: token,
    ).then((value) {
      rateModel = RateModel.fromJson(value.data);

      emit(ChangeRateSuccessState(rateModel!));
    }).catchError((error) {
      showToast(
        text: 'Unauthenticated',
        state: ToastState.error,
      );
      emit(ChangeRateErrorState(error.toString()));
      print(error.toString());
      Navigator.of(context).pushReplacementNamed('/login');

    });
  }


}
