import 'package:consulting_app/Bloc/consulting_cubit.dart';
import 'package:consulting_app/Bloc/consulting_state.dart';
import 'package:consulting_app/Bloc/login/login_cubit.dart';
import 'package:consulting_app/Bloc/register/register_cubit.dart';
import 'package:consulting_app/theme/theme.dart';
import 'package:consulting_app/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class PagesControllScreen extends StatelessWidget {
  const PagesControllScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConsultingCubit, ConsultingStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ConsultingCubit.get(context);
        return Scaffold(
          backgroundColor: ThemeColors.backgroundColor,
          appBar: null,
          body: LoginCubit.get(context).isLoginAsGuest == true?cubit.screens1[cubit.currentIndex]:cubit.screens2[cubit.currentIndex],


          /*
              ? cubit.screens1[cubit.currentIndex]
              : LoginCubit.get(context).loginModel!.data!.user!.isExp == 2
                  ? RegisterCubit.get(context).loginModel!.data!.user!.isExp == 0
                      ? cubit.screens2[cubit.currentIndex]
                      : cubit.screens3[cubit.currentIndex]
                  : LoginCubit.get(context).loginModel!.data!.user!.isExp == 0
                      ? cubit.screens2[cubit.currentIndex]
                      : cubit.screens3[cubit.currentIndex],*/
          bottomNavigationBar: GNav(
            iconSize: 30,
            gap: 20,
            tabMargin: EdgeInsets.all(8),
            tabBackgroundColor: Colors.deepPurple,
            padding: EdgeInsets.all(16),
            activeColor: Colors.white,
            color: Colors.black,
            backgroundColor: Colors.white60,
            tabShadow: [
              BoxShadow(color: Colors.blue.withOpacity(0.5), blurRadius: 100)
            ],
            selectedIndex: cubit.currentIndex,
            onTabChange: (index) {
              cubit.changeBottomNavBar(index);
              if(index ==0 ){
                ConsultingCubit.get(context).getHomeDataToken(0);
              }
            },
            tabs: [
              GButton(icon: Icons.home, text: LocaleKeys.Home.tr()),
              GButton(icon: Icons.favorite, text: LocaleKeys.Favorites.tr()),
              GButton(icon: Icons.supervised_user_circle, text: LocaleKeys.Profile.tr()),
            ],
          ),
        );
      },
    );
  }
}
