import 'package:bloc/bloc.dart';
import 'package:consulting_app/Bloc/reservation_history/reservation_history_state.dart';
import 'package:consulting_app/UI/Components/constants.dart';
import 'package:consulting_app/models/reservation_history_model.dart';
import 'package:consulting_app/network/remote/dio_helper.dart';
import 'package:consulting_app/network/remote/end_point.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';


class ReservationHistoryCubit extends Cubit<ReservationHistoryStates> {
  ReservationHistoryCubit() : super(ReservationHistoryInitialState());

  static ReservationHistoryCubit get(context) => BlocProvider.of(context);

  ReservationHistoryModel? reservationHistoryModel;

  void getExpertReservations() {
    emit(ReservationHistoryLoadingState());
    DioHelper.getData(
      url: HISTORY,
      token: token,
    ).then((value) {
      reservationHistoryModel = ReservationHistoryModel.fromJson(value.data);
      emit(ReservationHistorySuccessState(reservationHistoryModel!));
    }).catchError((error) {
      emit(ReservationHistoryErrorState(error.toString()));
      print(error.toString());

    });
  }


}
