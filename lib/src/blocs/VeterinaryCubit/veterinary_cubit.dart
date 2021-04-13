import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'veterinary_state.dart';

class VeterinaryCubit extends Cubit<VeterinaryFormState> {
  VeterinaryCubit()
      : super(VeterinaryFormState(currentStep: 0));

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

}
