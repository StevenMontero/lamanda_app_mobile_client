import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:lamanda_petshopcr/src/models/hotel_appointment.dart';
import 'package:lamanda_petshopcr/src/models/pet.dart';
import 'package:lamanda_petshopcr/src/models/userProfile.dart';
import 'package:lamanda_petshopcr/src/repository/hotel_appointment_repositorydb.dart';
import 'package:lamanda_petshopcr/src/utils/regularExpressions/regular_expressions_models.dart';

part 'hotel_state.dart';

class HotelCubit extends Cubit<HotelState> {
  HotelCubit(this.hotelAppointmentRepository) : super(HotelState());
  final HotelAppointmentRepository hotelAppointmentRepository;
  late HotelAppointment hotelAppointment;

  void entryDateChanged(DateTime? date) {
    final entryDateAux = DateForm.dirty(date);
    emit(state.copyWith(
        entryDate: entryDateAux,
        status: caseValidateForm(
            ispickUpSomeoneElse: state.ispickUpSomeoneElse,
            isRequiredTrasnport: state.transporte,
            listToValidate: [
              entryDateAux,
              state.departureDate,
              state.userPickup,
              state.direccion
            ])));
  }

  void departureDateChanged(DateTime? date) {
    final departureDateAux = DateForm.dirty(date);
    emit(state.copyWith(
        departureDate: departureDateAux,
        status: caseValidateForm(
            ispickUpSomeoneElse: state.ispickUpSomeoneElse,
            isRequiredTrasnport: state.transporte,
            listToValidate: [
              state.entryDate,
              departureDateAux,
              state.userPickup,
              state.direccion
            ])));
  }

  void userDeliverChanged(UserProfile user) {
    emit(state.copyWith(userDeliver: user));
  }

  void petChanged(Pet pet) {
    emit(state.copyWith(pet: pet));
  }

  void userPickupChanged(String user) {
    final userName = UserName.dirty(user);
    emit(state.copyWith(
        userPickup: userName,
        status: caseValidateForm(
            ispickUpSomeoneElse: state.ispickUpSomeoneElse,
            isRequiredTrasnport: state.transporte,
            listToValidate: [
              state.entryDate,
              state.departureDate,
              userName,
              state.direccion
            ])));
  }

  void lastDewormingChanged(DateTime? date) {
    final lastDewormingAux = DateForm.dirty(date);
    emit(state.copyWith(lastDeworming: lastDewormingAux));
  }

  void lastProtectionFleasChanged(DateTime? date) {
    final lastProtectionFleasAux = DateForm.dirty(date);
    emit(state.copyWith(lastProtectionFleas: lastProtectionFleasAux));
  }

  void istransporteChanged(bool transport) {
    emit(state.copyWith(
        transporte: transport,
        direccion: AddrresForm.pure(),
        status: caseValidateForm(
            ispickUpSomeoneElse: state.ispickUpSomeoneElse,
            isRequiredTrasnport: transport,
            listToValidate: [
              state.entryDate,
              state.departureDate,
              state.userPickup,
              AddrresForm.pure()
            ])));
  }

  void direccionChanged(String address) {
    final addressAux = AddrresForm.dirty(address);
    emit(state.copyWith(
        direccion: addressAux,
        status: caseValidateForm(
            ispickUpSomeoneElse: state.ispickUpSomeoneElse,
            isRequiredTrasnport: state.transporte,
            listToValidate: [
              state.entryDate,
              state.departureDate,
              state.userPickup,
              addressAux
            ])));
  }

  void isDewormingChanged(bool value) {
    emit(state.copyWith(
        isDeworming: value,
        lastDeworming:
            value ? DateForm.dirty(DateTime.now()) : DateForm.pure()));
  }

  void isProtectionFleasChanged(bool value) {
    emit(state.copyWith(
        isProtectionFleas: value,
        lastProtectionFleas:
            value ? DateForm.dirty(DateTime.now()) : DateForm.pure()));
  }

  void ispickUpSomeoneElseChanged(bool value) {
    emit(state.copyWith(
        ispickUpSomeoneElse: value,
        userPickup: UserName.pure(),
        status: caseValidateForm(
            ispickUpSomeoneElse: value,
            isRequiredTrasnport: state.transporte,
            listToValidate: [
              state.entryDate,
              state.departureDate,
              UserName.pure(),
              state.direccion
            ])));
  }

  Future<void> addAppointmentHotelForm(UserProfile user) async {
    // emit(state.copyWith(status: FormzStatus.submissionSuccess));
    // try {
    //   hotelAppointment = new HotelAppointment(
    //     age: state.age,
    //     endDate: state.departureDate,
    //     personPicksUp: state.userPickup,
    //     addres: state.direccion,
    //     startDate: state.entryDate,
    //     client: user,
    //     castrated: state.isCastrated,
    //     isConfirmed: false,
    //     sociable: state.isSociable,
    //     vaccine: state.isVaccinationUpDate,
    //     lastdeworming: state.lastDeworming,
    //     pestProtection: state.lastProtectionFleas,
    //     race: state.race,
    //     transfer: state.transporte,
    //   );
    //   hotelAppointmentRepository.addNewAppointment(hotelAppointment);
    // } catch (error) {
    //   emit(state.copyWith(status: FormzStatus.submissionFailure));
    // }
  }

  FormzStatus caseValidateForm(
      {required bool ispickUpSomeoneElse,
      required bool isRequiredTrasnport,
      required List<FormzInput<dynamic, dynamic>> listToValidate}) {
    if (ispickUpSomeoneElse == false && isRequiredTrasnport == false) {
      return Formz.validate([listToValidate[0], listToValidate[1]]);
    } else if (ispickUpSomeoneElse && isRequiredTrasnport) {
      return Formz.validate(listToValidate);
    } else if (ispickUpSomeoneElse) {
      return Formz.validate(
          [listToValidate[0], listToValidate[1], listToValidate[2]]);
    } else {
      return Formz.validate(
          [listToValidate[0], listToValidate[1], listToValidate[3]]);
    }
  }
}
