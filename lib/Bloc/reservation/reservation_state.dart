import 'package:consulting_app/models/ReservationDoneModel.dart';

abstract class ReservationStates{}

class ReservationInitialState extends ReservationStates{}

class changeDateReservation extends ReservationStates{}

class ChangeTimeIndex extends ReservationStates{}

class ReservationLoadingState extends ReservationStates{}
class ReservationSuccessState extends ReservationStates{}
class ReservationErrorState extends ReservationStates
{
  final String error;

  ReservationErrorState(this.error);

}

class initDateState extends ReservationStates{}


class ReservationDoneLoadingState extends ReservationStates{}

class ReservationDoneSuccessState extends ReservationStates
  {
  final ReservationDoneModel reservationDoneModel;

  ReservationDoneSuccessState(this.reservationDoneModel);
}

class ReservationDoneErrorState extends ReservationStates
{
  final String error;

  ReservationDoneErrorState(this.error);

}