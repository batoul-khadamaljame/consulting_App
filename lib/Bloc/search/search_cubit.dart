import 'package:bloc/bloc.dart';
import 'package:consulting_app/Bloc/search/search_state.dart';
import 'package:consulting_app/UI/Components/constants.dart';
import 'package:consulting_app/models/search_model.dart';
import 'package:consulting_app/network/remote/dio_helper.dart';
import 'package:consulting_app/network/remote/end_point.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit() : super (SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text)
  {
    SearchLoadingState();
    DioHelper.postData(
      url: SEARCH,
      data:
      {
        'text' : text,
      },
      token: token,
    ).then((value)
    {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error)
    {
      emit(SearchErrorState(error.toString()));
    });
  }

}
