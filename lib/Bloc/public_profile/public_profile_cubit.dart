import 'package:bloc/bloc.dart';
import 'package:consulting_app/Bloc/public_profile/public_profile_state.dart';
import 'package:consulting_app/UI/Components/constants.dart';
import 'package:consulting_app/models/login_model.dart';
import 'package:consulting_app/models/public_profile_model.dart';
import 'package:consulting_app/models/rate_model.dart';
import 'package:consulting_app/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';


class PublicProfileCubit extends Cubit<PublicProfileStates> {
  PublicProfileCubit() : super(PublicProfileInitialState());

  static PublicProfileCubit get(context) => BlocProvider.of(context);



  PublicProfileModel? publicExpertProfileModel;

  int? servicesLength;

  void getPublicExpertProfileData(id) {
    emit(PublicExpertProfileLoadingState());
    DioHelper.getData(
      url: 'profile/${id}',
      //token: token,
    ).then((value) {
      publicUserProfileModel = PublicProfileModel.fromJson(value.data);
      print(publicUserProfileModel!.data!.user!.name);
      print(publicUserProfileModel!.data!.user!.email);
      print(publicUserProfileModel!.data!.user!.phone);
      print(publicUserProfileModel!.data!.expert!.experiences!.length);
      servicesLength = publicUserProfileModel!.data!.expert!.experiences!.length;
      emit(PublicExpertProfileSuccessState(publicUserProfileModel!));
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
      //token: token,
    ).then((value) {
      publicExpertProfileModel = PublicProfileModel.fromJson(value.data);
      emit(PublicUserProfileSuccessState(publicExpertProfileModel!));
    }).catchError((error) {
      emit(PublicUserProfileErrorState(error.toString()));
      print(error.toString());

    });
  }

  RateModel? rateModel;

  void changeRate(rating){
    emit(ChangeRateLoadingState());
    DioHelper.postData(
      url: 'rate',
      data: {
        '' : rating,
      }
      //token: token,
    ).then((value) {
      rateModel = RateModel.fromJson(value.data);

      emit(ChangeRateSuccessState(rateModel!));
    }).catchError((error) {
      emit(ChangeRateErrorState(error.toString()));
      print(error.toString());

    });
  }


}
