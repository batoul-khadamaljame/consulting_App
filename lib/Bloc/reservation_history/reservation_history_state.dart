import 'package:consulting_app/UI/Screens/reservation_history.dart';
import 'package:consulting_app/models/login_model.dart';
import 'package:consulting_app/models/public_profile_model.dart';
import 'package:consulting_app/models/reservation_history_model.dart';

abstract class ReservationHistoryStates {}

class ReservationHistoryInitialState extends ReservationHistoryStates{}

class ReservationHistoryLoadingState extends ReservationHistoryStates{}

class ReservationHistorySuccessState extends ReservationHistoryStates
{
  final ReservationHistoryModel publicExpertProfileModel;

  ReservationHistorySuccessState(this.publicExpertProfileModel);
}
class ReservationHistoryErrorState extends ReservationHistoryStates
{
  final String error;

  ReservationHistoryErrorState(this.error);
}

