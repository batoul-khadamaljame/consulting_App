abstract class ConsultingStates{}

class ConsultingInitialState extends ConsultingStates{}

class ChangeBottomNavState extends ConsultingStates{}

class LoadingHomeDataState extends ConsultingStates{}

class SuccessHomeDataState extends ConsultingStates{}

class ErrorHomeDataState extends ConsultingStates
{
  final String error;

  ErrorHomeDataState(this.error);
}

class SuccessChangeFavoritesState extends ConsultingStates
{
  //final ChangeFavoritesModel model;

  //ShopSuccessChangeFavoritesState(this.model);
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