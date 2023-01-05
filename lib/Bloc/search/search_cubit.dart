import 'package:bloc/bloc.dart';
import 'package:consulting_app/Bloc/search/search_state.dart';

import 'package:consulting_app/models/search_model.dart';
import 'package:consulting_app/network/remote/dio_helper.dart';
import 'package:consulting_app/network/remote/end_point.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit() : super (SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);


  SearchModel? searchCategoryModel;

  void searchCategory(String text)
  {
    emit(SearchCategoryLoadingState());
    DioHelper.getData(
      url: 'search/$text',
    ).then((value)
    {
      searchCategoryModel = SearchModel.fromJson(value.data);
      emit(SearchCategorySuccessState());
    }).catchError((error)
    {
      emit(SearchCategoryErrorState(error.toString()));
    });
  }



  SearchModel? searchExpertModel;

  void searchExpert(String text)
  {
    emit(SearchExpertLoadingState());
    DioHelper.getData(
        url: 'searchbyname/$text',
    ).then((value)
    {
      searchExpertModel = SearchModel.fromJson(value.data);
      emit(SearchExpertSuccessState());
    }).catchError((error)
    {
      emit(SearchExpertErrorState(error.toString()));
    });
  }

}
