import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:consulting_app/Bloc/consulting_state.dart';
import 'package:consulting_app/UI/Components/constants.dart';
import 'package:consulting_app/UI/Screens/expert_profile.dart';
import 'package:consulting_app/UI/Screens/favorites.dart';
import 'package:consulting_app/UI/Screens/guest_profile.dart';
import 'package:consulting_app/UI/Screens/home.dart';
import 'package:consulting_app/UI/Screens/user_profile.dart';
import 'package:consulting_app/models/change_favoirites_model.dart';
import 'package:consulting_app/models/favorites_model.dart';
import 'package:consulting_app/models/home_model.dart';
import 'package:consulting_app/network/remote/dio_helper.dart';
import 'package:consulting_app/network/remote/end_point.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ConsultingCubit extends Cubit<ConsultingStates> {
  ConsultingCubit() : super(ConsultingInitialState());

  static ConsultingCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<GButton> bottomItems = [
    GButton(icon: Icons.home, text: 'Home'),
    GButton(icon: Icons.favorite, text: 'Favorites'),
    GButton(icon: Icons.supervised_user_circle, text: 'Profile'),
  ];

  List<Widget> screens1 = [
    HomePage(),
    const FavoritesScreen(),
    const GuestProfileScreen(),
  ];
  List<Widget> screens2 = [
    HomePage(),
    const FavoritesScreen(),
    const UserProfileScreen(),
  ];
  List<Widget> screens3 = [
    HomePage(),
    const FavoritesScreen(),
    const ExpertProfileScreen(),
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

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getHomeData(id) {
    emit(LoadingHomeDataState());
    DioHelper.getData(
      url: id == 0
          ? HOME
          : id == 1
              ? HOME1
              : id == 2
                  ? HOME2
                  : id == 3
                      ? HOME3
                      : id == 4
                          ? HOME4
                          : id == 5
                              ? HOME5
                              : HOME6,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.experts.forEach((element) {
        favorites.addAll({
          element.id!: element.inFavorites!,
        });
      });
      print(favorites.toString());
      emit(SuccessHomeDataState());
    }).catchError((error) {
      emit(ErrorHomeDataState(error.toString()));
      print(error.toString());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ChangeFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }
      emit(SuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ErrorChangeFavoritesState(error.toString()));
    });
  }

  FavoriteModel? favoriteModel;

  void getFavorites() {
    emit(LoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      print(value.data.toString());
      emit(SuccessGetFavoritesState());
    }).catchError((error) {
      emit(ErrorGetFavoritesState(error.toString()));
    });
  }
}
