import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:lamanda_petshopcr/src/models/daycare_appointment.dart';
import 'package:lamanda_petshopcr/src/models/userProfile.dart';
import 'package:lamanda_petshopcr/src/repository/daycare_appointment_repositorydb.dart';

part 'kinder_state.dart';

class KinderCubit extends Cubit<KinderState> {
  KinderCubit(this.daycareAppointmentRepository)
      : super(KinderState(
            date: DateTime.now(),
            entryHour: DateTime.now(),
            departureHour: DateTime.now()));

  final DaycareAppointmentRepository daycareAppointmentRepository;
  late DaycareAppointment daycareAppointment;

  void entryHourChanged(DateTime date) {
    emit(state.copyWith(entryHour: date));
  }

  void departureHourChanged(DateTime date) {
    emit(state.copyWith(departureHour: date));
  }

  void raceChanged(String? race) {
    emit(state.copyWith(race: race));
  }

  void ageChanged(int? age) {
    emit(state.copyWith(age: age));
  }

  void userDeliverChanged(UserProfile user) {
    emit(state.copyWith(userDeliver: user));
  }

  void userPickupChanged(String user) {
    emit(state.copyWith(userPickup: user));
  }

  void lastDewormingChanged(DateTime? date) {
    emit(state.copyWith(lastDeworming: date));
  }

  void lastProtectionFleasChanged(DateTime? date) {
    emit(state.copyWith(lastProtectionFleas: date));
  }

  void transporteChanged(bool transport) {
    emit(state.copyWith(
        transporte: transport, direccion: transport ? state.direccion : ''));
  }

  void direccionChanged(String direction) {
    emit(state.copyWith(direccion: direction));
  }

  void isVaccinationUpDateChanged(bool value) {
    emit(state.copyWith(isVaccinationUpDate: value));
  }

  void isCastratedDateChanged(bool value) {
    emit(state.copyWith(isCastrated: value));
  }

  void isSociableChanged(bool value) {
    emit(state.copyWith(isSociable: value));
  }

  void dateInCalendarChanged(DateTime date) {
    emit(state.copyWith(date: date));
  }

  Future<void> addAppointmentDaycareForm(UserProfile user) async {
    emit(state.copyWith(status: FormzStatus.submissionSuccess));
    try {
      daycareAppointment = new DaycareAppointment(
        age: state.age,
        date: state.date,
        entryHour: state.entryHour,
        departureHour: state.departureHour,
        race: state.race,
        userDeliver: state.userDeliver,
        userPickup: state.userPickup,
        direccion: state.direccion,
        isVaccinationUpDate: state.isVaccinationUpDate,
        isCastrated: state.isCastrated,
        isSociable: state.isSociable,
        lastDeworming: state.lastDeworming,
        lastProtectionFleas: state.lastProtectionFleas,
        transfer: state.transporte,
        isConfirmed: false,
      );
      daycareAppointmentRepository.addNewAppointment(daycareAppointment);
    } catch (error) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
