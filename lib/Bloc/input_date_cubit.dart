import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'input_date_state.dart';

class InputDateCubit extends Cubit<InputDateState> {
  InputDateCubit()
      : super(InputDateInitial(
            selectedDate: DateTime.now(),
            startTime: DateFormat('hh:mm a').format(DateTime.now()).toString(),
            endTime: DateFormat('hh:mm a')
                .format(DateTime.now().add(const Duration(minutes: 15)))
                .toString()));

  void getDateFromUser(context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: state.selectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2100));
    if (pickedDate != null) {
      emit( InputDateState(selectedDate: pickedDate,startTime: state.startTime,endTime: state.endTime));
    }
  }

  void getTimeFromUser({required bool isStartTime,context}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
          DateTime.now().add(const Duration(minutes: 15))),
    );

    String formattedTime = pickedTime!.format(context);

    if (isStartTime) {
      emit( InputDateState(selectedDate: state.selectedDate,startTime: formattedTime,endTime: state.endTime));
    } else{
      emit( InputDateState(selectedDate: state.selectedDate,startTime: state.startTime,endTime: formattedTime));
    }
  }

}
