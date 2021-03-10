import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:lamanda_petshopcr/src/models/hotel_appointment.dart';
import 'package:lamanda_petshopcr/src/models/userProfile.dart';
import 'package:lamanda_petshopcr/src/repository/hotel_appointment_repositorydb.dart';

part 'hotel_state.dart';

class HotelCubit extends Cubit<HotelState> {
  HotelCubit(this.hotelAppointmentRepository)
      : super(HotelState(
            entryDate: DateTime.now(), departureDate: DateTime.now()));
  final HotelAppointmentRepository hotelAppointmentRepository;
  late HotelAppointment hotelAppointment;

  void entryDateChanged(DateTime? date) {
    emit(state.copyWith(entryDate: date));
  }

  void departureDateChanged(DateTime? date) {
    emit(state.copyWith(departureDate: date));
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

  Future<void> addAppointmentHotelForm(UserProfile user) async {
    emit(state.copyWith(status: FormzStatus.submissionSuccess));
    try {
      hotelAppointment = new HotelAppointment(
        age: state.age,
        endDate: state.departureDate,
        personPicksUp: state.userPickup,
        addres: state.direccion,
        startDate: state.entryDate,
        client: user,
        castrated: state.isCastrated,
        isConfirmed: false,
        sociable: state.isSociable,
        vaccine: state.isVaccinationUpDate,
        lastdeworming: state.lastDeworming,
        pestProtection: state.lastProtectionFleas,
        race: state.race,
        transfer: state.transporte,
      );
      hotelAppointmentRepository.addNewAppointment(hotelAppointment);
    } catch (error) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
