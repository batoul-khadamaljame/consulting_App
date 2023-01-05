import 'package:consulting_app/models/change_favoirites_model.dart';
import 'package:consulting_app/models/logout_model.dart';

abstract class ConsultingStates{}

class ConsultingInitialState extends ConsultingStates{}

class ChangeBottomNavState extends ConsultingStates{}

class ChangeCatIndex extends ConsultingStates{}

class LoadingHomeDataState extends ConsultingStates{}

class SuccessHomeDataState extends ConsultingStates{}

class ErrorHomeDataState extends ConsultingStates
{
  final String error;

  ErrorHomeDataState(this.error);
}

class SuccessChangeFavoritesState extends ConsultingStates
{
  final ChangeFavoritesModel model;

  SuccessChangeFavoritesState(this.model);
}

class ErrorChangeFavoritesState extends ConsultingStates
{
  final String error;

  ErrorChangeFavoritesState(this.error);
}

class ChangeFavoritesState extends ConsultingStates{}


class LoadingGetFavoritesState extends ConsultingStates
{}

class SuccessGetFavoritesState extends ConsultingStates
{}

class ErrorGetFavoritesState extends ConsultingStates
{
  final String error;

  ErrorGetFavoritesState(this.error);
}

class LoadingUserDataState extends ConsultingStates{}

class SuccessUserDataState extends ConsultingStates{}

class ErrorUserDataState extends ConsultingStates{
  final String error;

  ErrorUserDataState(this.error);
}

class LoadingLogoutState extends ConsultingStates{}

class SuccessLogoutState extends ConsultingStates{
  final LogoutModel logoutModel;

  SuccessLogoutState(this.logoutModel);
}

class ErrorLogoutState extends ConsultingStates{
  final String error;

  ErrorLogoutState(this.error);
}