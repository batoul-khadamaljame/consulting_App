

abstract class HomeDataGuestStates{}

class HomeGuestInitialState extends HomeDataGuestStates{}

class ChangeBottomNavGuestState extends HomeDataGuestStates{}

class ChangeCatIndexGuestState extends HomeDataGuestStates{}

class LoadingHomeDataGuestState extends HomeDataGuestStates{}

class SuccessHomeDataGuestState extends HomeDataGuestStates{

}

class ErrorHomeDataGuestState extends HomeDataGuestStates
{
  final String error;

  ErrorHomeDataGuestState(this.error);
}