import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:lamanda_petshopcr/src/models/daycare_appointment.dart';
import 'package:lamanda_petshopcr/src/models/pet.dart';
import 'package:lamanda_petshopcr/src/models/userProfile.dart';
import 'package:lamanda_petshopcr/src/repository/daycare_appointment_repositorydb.dart';
import 'package:lamanda_petshopcr/src/utils/regularExpressions/regular_expressions_models.dart';

part 'kinder_state.dart';

class KinderCubit extends Cubit<KinderState> {
  KinderCubit(this.daycareAppointmentRepository)
      : super(KinderState(date: DateTime.now()));
// entryHour: DateTime.now(),
//             departureHour: DateTime(DateTime.now().year, DateTime.now().month,
//                 DateTime.now().day, (DateTime.now().hour + 1),DateTime.now().minute))
  final DaycareAppointmentRepository daycareAppointmentRepository;
  late DaycareAppointment daycareAppointment;

  void entryHourChanged(DateTime date) {
    HourCheckOut? departureHour;
    if (state.departureHour.value != null &&
        state.departureHour.value![1] != null)
      departureHour =
          HourCheckOut.dirty([date, state.departureHour.value![1]!]);
    final entryHour = HourCheckIn.dirty([state.date, date]);
    emit(state.copyWith(
        entryHour: entryHour,
        departureHour: departureHour,
        status: caseValidateForm(
            ispickUpSomeoneElse: state.ispickUpSomeoneElse,
            isRequiredTrasnport: state.transporte,
            listToValidate: [
              entryHour,
              departureHour ?? state.departureHour,
              state.userPickup,
              state.direccion
            ])));
  }

  void departureHourChanged(DateTime date) {
    final departureHour =
        HourCheckOut.dirty([state.entryHour.value![1] ?? DateTime.now(), date]);
    emit(state.copyWith(
        departureHour: departureHour,
        status: caseValidateForm(
            ispickUpSomeoneElse: state.ispickUpSomeoneElse,
            isRequiredTrasnport: state.transporte,
            listToValidate: [
              state.entryHour,
              departureHour,
              state.userPickup,
              state.direccion
            ])));
  }

  void userDeliverChanged(UserProfile user) {
    emit(state.copyWith(userDeliver: user));
  }

  void userPickupChanged(String user) {
    final userName = UserName.dirty(user);
    emit(state.copyWith(
        userPickup: userName,
        status: caseValidateForm(
            ispickUpSomeoneElse: state.ispickUpSomeoneElse,
            isRequiredTrasnport: state.transporte,
            listToValidate: [
              state.entryHour,
              state.departureHour,
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
              state.entryHour,
              state.departureHour,
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
              state.entryHour,
              state.departureHour,
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
              state.entryHour,
              state.departureHour,
              UserName.pure(),
              state.direccion
            ])));
  }

  void dateInCalendarChanged(DateTime date) {
    emit(state.copyWith(date: date));
  }

  Future<void> addAppointmentDaycareForm(UserProfile user) async {
    if (state.status.isValidated) {
      print('Hola');
    }
    // emit(state.copyWith(status: FormzStatus.submissionSuccess));
    try {
      // daycareAppointment = new DaycareAppointment(
      //   age: state.age,
      //   date: state.date,
      //   entryHour: state.entryHour,
      //   departureHour: state.departureHour,
      //   race: state.race,
      //   userDeliver: state.userDeliver,
      //   userPickup: state.userPickup,
      //   direccion: state.direccion,
      //   isVaccinationUpDate: state.isVaccinationUpDate,
      //   isCastrated: state.isCastrated,
      //   isSociable: state.isSociable,
      //   lastDeworming: state.lastDeworming,
      //   lastProtectionFleas: state.lastProtectionFleas,
      //   transfer: state.transporte,
      //   isConfirmed: false,
      // );
      // daycareAppointmentRepository.addNewAppointment(daycareAppointment);
    } catch (error) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
   void petChanged(Pet pet) {
    emit(state.copyWith(pet: pet));
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
