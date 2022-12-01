part of 'enter_moblie_number_cubit.dart';

@immutable
 class EnterMoblieNumberState {
  Region region;

  EnterMoblieNumberState({required this.region});

  @override
  List<Object> get props => [region];
}

class EnterMoblieNumberInitial extends EnterMoblieNumberState {
  EnterMoblieNumberInitial({required super.region});
}
