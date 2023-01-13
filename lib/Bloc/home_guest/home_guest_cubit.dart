import 'package:bloc/bloc.dart';
import 'package:consulting_app/Bloc/home_guest/home_guest_state.dart';
import 'package:consulting_app/UI/Screens/home_guest.dart';
import 'package:consulting_app/models/home_model.dart';
import 'package:consulting_app/network/remote/dio_helper.dart';
import 'package:consulting_app/network/remote/end_point.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class HomeGuestCubit extends Cubit<HomeDataGuestStates> {
  HomeGuestCubit() : super(HomeGuestInitialState());

  static HomeGuestCubit get(context) => BlocProvider.of(context);

  int currentIndexGuest = 0;

  void changeBottomNavBar(int index) {
    currentIndexGuest = index;
    emit(ChangeBottomNavGuestState());
  }

  int catIndexGuest = 0;

  void changeCatIndexGuest(id) {
    catIndexGuest = categoriesListGuest.indexOf(categoriesListGuest[id]);
    emit(ChangeCatIndexGuestState());
  }

  HomeModel? homeGuestModel;

  void getHomeDataGuest(id) {
    emit(LoadingHomeDataGuestState());

    DioHelper.getData(
      url: id == 0 ? HOME : 'home/$id',
    ).then((value) {
      homeGuestModel = HomeModel.fromJson(value.data);
      // homeModel!.data!.experts.forEach((element) {
      //  favorites.addAll({
      //    element.id!: element.inFavorites!,
      //  });
      // });
      //print(favorites.toString());
      emit(SuccessHomeDataGuestState());
    }).catchError((error) {
      emit(ErrorHomeDataGuestState(error.toString()));
      print(error.toString());
    });
  }
}
