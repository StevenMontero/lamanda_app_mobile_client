import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:lamanda_petshopcr/src/models/sthetic_appointment.dart';
import 'package:lamanda_petshopcr/src/models/userProfile.dart';
import 'package:lamanda_petshopcr/src/utils/regularExpressions/address.dart';
part 'grooming_state.dart';

class GroomingCubit extends Cubit<GroomingFormState> {
  GroomingCubit() : super(GroomingFormState(currentStep: 0));

  late StheticAppointment stheticAppointment;

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

  

  Future<void> addAppointmentGroomingForm(UserProfile user) async {
    // final idDate = '${state.date.day}-${state.date.month}-${state.date.year}';
    // try {
    //   stheticAppointment = new StheticAppointment(
    //       entrytDate: state.date,
    //       entrytHour: state.hourRerservation,
    //       client: user,
    //       isConfirmed: false,
    //       transfer: state.transfer,
    //       address: state.transfer ? state.address.value : '',
    //       fur: state.typeFur);
    //   // _appointmentRepository.addNewAppointment(stheticAppointment, idDate);
    // } catch (error) {
    //   emit(state.copyWith(status: FormzStatus.submissionFailure));
    // }
  }
}
