import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:consulting_app/Bloc/reservation/reservation_state.dart';
import 'package:consulting_app/UI/Components/components.dart';
import 'package:consulting_app/UI/Components/constants.dart';
import 'package:consulting_app/models/ReservationDoneModel.dart';
import 'package:consulting_app/models/reservation_model.dart';
import 'package:consulting_app/network/remote/dio_helper.dart';
import 'package:consulting_app/network/remote/end_point.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReservationCubit extends Cubit<ReservationStates> {
  ReservationCubit() : super(ReservationInitialState());

  static ReservationCubit get(context) => BlocProvider.of(context);

  ReservertionModel? reservertionModel;

  void getReservationData(id) {
    print(id);
    emit(ReservationLoadingState());

    DioHelper.getData(
      url: 'experience/${id}',
    ).then((value) {
      reservertionModel = ReservertionModel.fromJson(value.data);
      print(reservertionModel!.data!.workStartTimes!);
      print(reservertionModel!.data!.days!.sunday);
      print(reservertionModel!.data!.days!.monday);
      print(reservertionModel!.data!.days!.tuesday);
      print(reservertionModel!.data!.days!.wednesday);
      print(reservertionModel!.data!.days!.thursday);
      print(reservertionModel!.data!.days!.friday);
      print(reservertionModel!.data!.days!.saturday);

      emit(ReservationSuccessState());
    }).catchError((error) {
      emit(ReservationErrorState(error.toString()));
      print(error.toString());
    });
  }



  DateTime SundayDate = DateTime.now();
  DateTime MondayDate = DateTime.now();
  DateTime TuesdayDate = DateTime.now();
  DateTime WednesdayDate = DateTime.now();
  DateTime ThrusdayDate= DateTime.now();
  DateTime FridayDate= DateTime.now();
  DateTime SaturdayDate= DateTime.now();

  void initDate() {
    if (DateTime.now().weekday == 7) {
      MondayDate= MondayDate!.add(Duration(days: 1));
      TuesdayDate =TuesdayDate!.add(Duration(days: 2));
      WednesdayDate =WednesdayDate!.add(Duration(days: 3));
      ThrusdayDate=ThrusdayDate!.add(Duration(days: 4));
      FridayDate=FridayDate!.add(Duration(days: 5));
      SaturdayDate=SaturdayDate!.add(Duration(days: 6));
    }
    else if (DateTime.now().weekday == 1) {
      TuesdayDate=TuesdayDate!.add(Duration(days: 1));
      WednesdayDate=WednesdayDate!.add(Duration(days: 2));
      ThrusdayDate=ThrusdayDate!.add(Duration(days: 3));
      FridayDate=FridayDate!.add(Duration(days: 4));
      SaturdayDate=SaturdayDate!.add(Duration(days: 5));
      SundayDate=SundayDate!.add(Duration(days: 6));
    }
    else if (DateTime.now().weekday == 2) {
      WednesdayDate=WednesdayDate!.add(Duration(days: 1));
      ThrusdayDate=ThrusdayDate!.add(Duration(days: 2));
      FridayDate=FridayDate!.add(Duration(days: 3));
      SaturdayDate=SaturdayDate!.add(Duration(days: 4));
      SundayDate=SundayDate!.add(Duration(days: 5));
      MondayDate=MondayDate!.add(Duration(days: 6));

    }
    else if (DateTime.now().weekday == 3) {
      ThrusdayDate=ThrusdayDate!.add(Duration(days: 1));
      FridayDate=FridayDate!.add(Duration(days: 2));
      SaturdayDate=SaturdayDate!.add(Duration(days: 3));
      SundayDate=SundayDate!.add(Duration(days: 4));
      MondayDate=MondayDate!.add(Duration(days: 5));
      TuesdayDate=TuesdayDate!.add(Duration(days: 6));
    }
    else if (DateTime.now().weekday == 4) {
      FridayDate=FridayDate!.add(Duration(days: 1));
      SaturdayDate=SaturdayDate!.add(Duration(days: 2));
      SundayDate=SundayDate!.add(Duration(days: 3));
      MondayDate=MondayDate!.add(Duration(days: 4));
      TuesdayDate=TuesdayDate!.add(Duration(days: 5));
      WednesdayDate=WednesdayDate!.add(Duration(days: 6));
    }
    else if (DateTime.now().weekday == 5) {
      SaturdayDate=SaturdayDate!.add(Duration(days: 1));
      SundayDate=SundayDate!.add(Duration(days: 2));
      MondayDate=MondayDate!.add(Duration(days: 3));
      TuesdayDate=TuesdayDate!.add(Duration(days: 4));
      WednesdayDate=WednesdayDate!.add(Duration(days: 5));
      ThrusdayDate=ThrusdayDate!.add(Duration(days: 6));
    }
    else {
      SundayDate=SundayDate!.add(Duration(days: 1));
      MondayDate=MondayDate!.add(Duration(days: 2));
      TuesdayDate=TuesdayDate!.add(Duration(days: 3));
      WednesdayDate=WednesdayDate!.add(Duration(days: 4));
      ThrusdayDate=ThrusdayDate!.add(Duration(days: 5));
      FridayDate=FridayDate!.add(Duration(days: 6));
    }
    emit(initDateState());
  }

  late var selectedDate = reservertionModel!.data!.days!.sunday == 1
      ? SundayDate
      : reservertionModel!.data!.days!.monday ==
      1
      ? MondayDate
      : reservertionModel!.data!.days!
      .tuesday ==
      1
      ? TuesdayDate
      : reservertionModel!.data!.days!
      .wednesday ==
      1
      ? WednesdayDate
      : reservertionModel!.data!
      .days!.thursday ==
      1
      ? ThrusdayDate
      : reservertionModel!.data!
      .days!.friday ==
      1
      ? FridayDate
      : SaturdayDate;

  void changeSelectedDate(newDate) {
    selectedDate = newDate;
    emit(changeDateReservation());
  }

  var timeIndex = 0;

  void changeTimeIndex(id) {
    timeIndex = reservertionModel!.data!.workStartTimes!
        .indexOf(reservertionModel!.data!.workStartTimes![id]);
    print(reservertionModel!.data!.workStartTimes!.length);
    emit(ChangeTimeIndex());
  }


  ReservationDoneModel? reservationDoneModel;

  void userReservation({
    required dynamic experience_id,
    required dynamic from,
    required dynamic day,
    required dynamic month,
    required dynamic year,
    required BuildContext context,

  }) {
    emit(ReservationDoneLoadingState());
    DioHelper.postData(
      url: RESERVATIONDONE,
      data:
      {
        'experience_id': experience_id,
        'from': from,
        'day': day,
        'month': month,
        'year': year,
      },
      token: token,
    ).then((value) {
      reservationDoneModel = ReservationDoneModel.fromJson(value.data);

      emit(ReservationDoneSuccessState(reservationDoneModel!));
    }).catchError((error) {
      showToast(
        text: 'Unauthenticated',
        state: ToastState.error,
      );
      emit(ReservationDoneErrorState(error.toString()));
      print(error.toString());
      Navigator.of(context).pushReplacementNamed('/login');
    });
  }

}
