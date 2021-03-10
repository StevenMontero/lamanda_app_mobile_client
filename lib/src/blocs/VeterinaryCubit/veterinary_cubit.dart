import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:lamanda_petshopcr/src/models/userProfile.dart';
import 'package:lamanda_petshopcr/src/models/veterinary_appointment.dart';
import 'package:lamanda_petshopcr/src/repository/veterinary_appointment_repositorydb.dart';

part 'veterinary_state.dart';

class VeterinaryCubit extends Cubit<VeterinaryFormState> {
  VeterinaryCubit(this._appointmentRepository) : super(VeterinaryFormState());
  final VeterinaryAppointmentRepository _appointmentRepository;

  void scheduleLoad(DateTime date) async {
    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      final list = await _appointmentRepository.getListAppointmetsFree(date);
      emit(state.copyWith(
          schedule: list,
          date: DateTime.now(),
          status: FormzStatus.submissionSuccess,
          hourRerservation: list[0]));
    } catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  void hourChanged(DateTime date) async {
    emit(state.copyWith(hourRerservation: date));
  }

  void dateChanged(DateTime date) async {
    final list = await _appointmentRepository.getListAppointmetsFree(date);
    emit(state.copyWith(hourRerservation: date, schedule: list));
  }

  void ageChanged(int age) async {
    emit(state.copyWith(age: age));
  }

  void typeRaceChanged(String fur) async {
    emit(state.copyWith(race: fur));
  }

  void descriptionSymptomsChanged(String des) async {
    emit(state.copyWith(description: des));
  }

  void transferChanged(bool transfer) async {
    emit(state.copyWith(
        transporte: transfer, direccion: transfer ? state.direccion : ''));
  }

  void direccionChanged(String dir) async {
    emit(state.copyWith(direccion: dir));
  }

  Future<void> addAppointmentVeterinaryForm(UserProfile user) async {
    try {
      final stheticAppointment = new VeterinaryAppointment(
          date: state.date,
          hour: state.hourRerservation,
          client: user,
          isConfirmed: false,
          transfer: state.transporte,
          direction: state.transporte ? state.direccion : '',
          symptoms: state.description,
          race: state.race);
      _appointmentRepository.addNewAppointment(stheticAppointment);
    } catch (error) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
