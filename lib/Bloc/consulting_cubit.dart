import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'consulting_state.dart';

class ConsultingCubit extends Cubit<ConsultingState> {
  ConsultingCubit() : super(ConsultingInitial());
}
