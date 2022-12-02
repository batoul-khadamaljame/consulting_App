part of 'input_date_cubit.dart';

class InputDateState {
  DateTime selectedDate;
  String startTime;
  String endTime;

  InputDateState({required this.selectedDate,required this.startTime,required this.endTime});

  @override
  List<Object> get props => [selectedDate,startTime,endTime];

}


class InputDateInitial extends InputDateState {
  InputDateInitial({required super.selectedDate,required super.startTime,required super.endTime});
}
