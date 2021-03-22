import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:lamanda_petshopcr/src/repository/esthetic_appointment_repositorydb.dart';

part 'selectschedule_state.dart';

class SelectscheduleCubit extends Cubit<SelectscheduleState> {
  SelectscheduleCubit(this._appointmentRepository)
      : super(SelectscheduleState(date: DateTime.now()));
  final StheticAppointmentRepository _appointmentRepository;
  void scheduleLoad(DateTime date) async {
    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      final idDate = '${date.day}-${date.month}-${date.year}';
      final list = await _appointmentRepository.getListAppointmetsFree(idDate);
      emit(state.copyWith(
          schedule: list,
          date: DateTime.now(),
          status: FormzStatus.submissionSuccess,
          index: 0,
          hourRerservation: list[0]));
    } catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  void dateInCalendarChanged(DateTime date) async {
    emit(state.copyWith(date: date));
    final idDate = '${date.day}-${date.month}-${date.year}';
    final list = await _appointmentRepository.getListAppointmetsFree(idDate);
    emit(state.copyWith(schedule: list));
  }

  void hourChanged(DateTime date, int? index) async {
    emit(state.copyWith(hourRerservation: date, index: index,));
  }
}
