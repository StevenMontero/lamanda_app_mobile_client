import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lamanda_petshopcr/src/models/userProfile.dart';
import 'package:lamanda_petshopcr/src/repository/veterinary_appointment_repositorydb.dart';
part 'veterinary_state.dart';

class VeterinaryCubit extends Cubit<VeterinaryFormState> {
  VeterinaryCubit(this._appointmentRepository)
      : super(VeterinaryFormState(currentStep: 0));
  final VeterinaryAppointmentRepository _appointmentRepository;

  void nextStep() async {
    emit(state.copyWith(
        currentStep:
            state.currentStep < 3 ? state.currentStep + 1 : state.currentStep));
  }

  void backStep() async {
    emit(state.copyWith(
        currentStep:
            state.currentStep > 0 ? state.currentStep - 1 : state.currentStep));
  }

  bool caseValidateForm(
      {
      required bool isDateFormValid,
      required bool isInfoFormValid,
      required int currentSetep}) {
    switch (currentSetep) {
      case 0:
        return isDateFormValid;
      case 1:
        return isInfoFormValid;
      default:
        return false;
    }
  }

  Future<void> addAppointmentVeterinaryForm(UserProfile user) async {
    //   try {
    //     final stheticAppointment = new VeterinaryAppointment(
    //         date: state.date,
    //         hour: state.hourRerservation,
    //         client: user,
    //         isConfirmed: false,
    //         transfer: state.transporte,
    //         direction: state.transporte ? state.direccion : '',
    //         symptoms: state.description,
    //         race: state.race);
    //     _appointmentRepository.addNewAppointment(stheticAppointment);
    //   } catch (error) {
    //     emit(state.copyWith(status: FormzStatus.submissionFailure));
    //   }
  }
}
