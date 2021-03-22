import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:lamanda_petshopcr/src/utils/regularExpressions/address.dart';

part 'infoform_state.dart';

class InfoformCubit extends Cubit<InfoformState> {
  InfoformCubit() : super(InfoformState());

  void descriptionChanged(String des) async {
    emit(state.copyWith(description: des));
  }

  void istransferChanged(bool transfer) async {
    emit(state.copyWith(transfer: transfer, address: AddrresForm.pure()));
  }

  void addresChanged(String address) {
    final addressAux = AddrresForm.dirty(address);
    emit(state.copyWith(address: addressAux));
  }
}
