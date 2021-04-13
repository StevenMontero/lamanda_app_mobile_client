import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'grooming_state.dart';

class GroomingCubit extends Cubit<GroomingFormState> {
  GroomingCubit() : super(GroomingFormState(currentStep: 0));

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
      {required bool isServiceFormValid,
      required bool isDateFormValid,
      required bool isInfoFormValid,
      required int currentSetep}) {
    switch (currentSetep) {
      case 0:
        return isServiceFormValid;
      case 1:
        return isDateFormValid;
      case 2:
        return isInfoFormValid;
      default:
        return false;
    }
  }

  
}
