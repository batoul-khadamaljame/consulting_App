
import 'package:consulting_app/Bloc/consulting_cubit.dart';
import 'package:consulting_app/Bloc/consulting_state.dart';
import 'package:consulting_app/theme/theme.dart';
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

          body: cubit.screens1[cubit.currentIndex],

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
              BoxShadow(
                color: Colors.blue.withOpacity(0.5),blurRadius: 100
              )
            ],
            selectedIndex: cubit.currentIndex,
            onTabChange: (index) {
              cubit.changeBottomNavBar(index);
            },
            tabs: cubit.bottomItems,
          ),
        );
      },
    );
  }
}
