import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:lamanda_petshopcr/src/models/pet.dart';
import 'package:lamanda_petshopcr/src/utils/regularExpressions/address.dart';
import 'package:lamanda_petshopcr/src/utils/regularExpressions/text_noempty.dart';

part 'infoform_state.dart';

class InfoformCubit extends Cubit<InfoformState> {
  InfoformCubit() : super(InfoformState());

  void descriptionChanged(String des) async {
    final descriptionAux = TextNoEmpty.dirty(des);
    emit(state.copyWith(
        description: descriptionAux,
        status: caseValidateForm(
            isRequiredTrasnport: state.transfer,
            listToValidate: [state.address, descriptionAux])));
  }

  void istransferChanged(bool transfer) async {
    emit(state.copyWith(
        transfer: transfer,
        address: AddrresForm.pure(),
        status: caseValidateForm(
            isRequiredTrasnport: transfer,
            listToValidate: [AddrresForm.pure(), state.description])));
  }

  void addresChanged(String address) {
    final addressAux = AddrresForm.dirty(address);
    emit(state.copyWith(
        address: addressAux,
        status: caseValidateForm(
            isRequiredTrasnport: state.transfer,
            listToValidate: [addressAux, state.description])));
  }

  void petChanged(Pet pet) {
    emit(state.copyWith(pet: pet));
  }

  FormzStatus caseValidateForm(
      {required bool isRequiredTrasnport,
      required List<FormzInput<dynamic, dynamic>> listToValidate}) {
    if (isRequiredTrasnport) {
      return Formz.validate(listToValidate);
    } else {
      return Formz.validate([listToValidate[1]]);
    }
  }
}
