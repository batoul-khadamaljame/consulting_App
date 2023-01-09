import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:consulting_app/Bloc/consulting_state.dart';
import 'package:consulting_app/UI/Components/constants.dart';
import 'package:consulting_app/UI/Screens/favorites.dart';
import 'package:consulting_app/UI/Screens/guest_profile.dart';
import 'package:consulting_app/UI/Screens/home_guest.dart';
import 'package:consulting_app/UI/Screens/home_with_token.dart';
import 'package:consulting_app/UI/Screens/private_profile.dart';
import 'package:consulting_app/models/change_favoirites_model.dart';
import 'package:consulting_app/models/favorites_model.dart';
import 'package:consulting_app/models/home_model.dart';
import 'package:consulting_app/models/login_model.dart';
import 'package:consulting_app/models/logout_model.dart';
import 'package:consulting_app/models/search_model.dart';
import 'package:consulting_app/network/local/cash_helper.dart';
import 'package:consulting_app/network/remote/dio_helper.dart';
import 'package:consulting_app/network/remote/end_point.dart';
import 'package:consulting_app/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ConsultingCubit extends Cubit<ConsultingStates> {
  ConsultingCubit() : super(ConsultingInitialState());

  static ConsultingCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void indx(){
    currentIndex = 0;
  }

  List<GButton> bottomItems = [
    GButton(icon: Icons.home, text: LocaleKeys.Home.tr()),
    GButton(icon: Icons.favorite, text: LocaleKeys.Favorites.tr()),
    GButton(icon: Icons.supervised_user_circle, text: LocaleKeys.Profile.tr()),
  ];

  List<Widget> screens1 = [
    HomeGuest(),
    const GuestProfileScreen(),
    const GuestProfileScreen(),
  ];
  List<Widget> screens2 = [
    HomeWithToken(),
    const FavoritesScreen(),
     ProfileScreen(),
  ];


  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  int catIndex = 0;

  void changeCatIndex(id) {
    catIndex = categoriesList.indexOf(categoriesList[id]);
    emit(ChangeCatIndex());
  }

  //Drawer

  bool swValue = false;

  void changeLanguage(value,context) {
    print(switchValue);
    swValue = switchValue;
    CacheHelper.saveData(
      key: 'switchValue',
      value: value,
    );
    switchValue = value;
    emit(ChangeLanguage());
  }

  Map<int, bool> favorites = {};



  HomeModel? homeTokenModel;

  void getHomeDataToken(id) {
    emit(LoadingHomeDataState());

    DioHelper.getData(
      url:
      id == 0
          ? 'homewithtoken':
      'homewithtoken/$id',
    token: token,
    ).then((value) {
      homeTokenModel = HomeModel.fromJson(value.data);
      // homeModel!.data!.experts.forEach((element) {
      //  favorites.addAll({
      //    element.id!: element.inFavorites!,
      //  });
      // });
      //print(favorites.toString());
      emit(SuccessHomeDataState());
    }).catchError((error) {
      emit(ErrorHomeDataState(error.toString()));
      print(error.toString());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(experience_id) {
    emit(ChangeFavoritesState());
    DioHelper.postData(
      url: 'changefavourites',
      data: {
        'experience_id': experience_id,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      emit(SuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      emit(ErrorChangeFavoritesState(error.toString()));
    });
  }

  FavoritesModel? favoriteModel;

  void getFavorites() {
    emit(LoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoriteModel = FavoritesModel.fromJson(value.data);
      print(value.data.toString());
      emit(SuccessGetFavoritesState());
    }).catchError((error) {
      emit(ErrorGetFavoritesState(error.toString()));
    });
  }


  LoginModel? userDataModel;

  void getUserData() {
    if (state is SuccessHomeDataState) {
      emit(LoadingUserDataState());
      DioHelper.getData(
        url: MYPROFILE,
        token: token,
      ).then((value) {
        userDataModel = LoginModel.fromJson(value.data);

        emit(SuccessUserDataState());
      }).catchError((error) {
        emit(ErrorUserDataState(error.toString()));
        print(error.toString());
      });
    }
  }
  LogoutModel? logoutModel;

  void logout(){
    emit(LoadingLogoutState());
    DioHelper.postData(
      url: LOGOUT,
      token: token,
    ).then((value) {
      logoutModel = LogoutModel.fromJson(value.data);
      emit(SuccessLogoutState(logoutModel!));
    }).catchError((error) {
      emit(ErrorLogoutState(error.toString()));
      print(error.toString());
    });
  }




}
