import 'package:bloc/bloc.dart';
import 'package:consulting_app/Bloc/consulting_state.dart';
import 'package:consulting_app/UI/Screens/expert_profile.dart';
import 'package:consulting_app/UI/Screens/favorites.dart';
import 'package:consulting_app/UI/Screens/home.dart';
import 'package:consulting_app/UI/Screens/user_profile.dart';
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
    const UserProfileScreen(),
  ];
  List<Widget> screens2 = [
    HomePage(),
    const FavoritesScreen(),
    const ExpertProfileScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }
}
