import 'package:bloc/bloc.dart';
import 'package:consulting_app/models/regions.dart';
import 'package:meta/meta.dart';

part 'enter_moblie_number_state.dart';


class EnterMoblieNumberCubit extends Cubit<EnterMoblieNumberState> {

  EnterMoblieNumberCubit() : super(EnterMoblieNumberInitial(region: regions[0]));

  void update(Region region) {
    emit( EnterMoblieNumberState(region: region));
  }

}
