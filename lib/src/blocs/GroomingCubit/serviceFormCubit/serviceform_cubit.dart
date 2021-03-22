import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:lamanda_petshopcr/src/models/service.dart';
import 'package:lamanda_petshopcr/src/utils/Calculators/price_calculator.dart';

part 'serviceform_state.dart';

class ServiceformCubit extends Cubit<ServiceformState> {
  ServiceformCubit() : super(ServiceformState());

  void isWashChanged(
      bool value, double weight, String kindPet, String kindHair) async {
    final List<Service> listAdd;

    if (value) {
      final _price = PriceCalculator.calculateWashPet(
          weightPet: weight, kindPet: kindPet, kindHair: kindHair);
      listAdd = List.from(state.listService)
        ..add(Service(name: 'Baño', price: _price));
    } else {
      listAdd = List.from(state.listService)
        ..removeWhere((element) => element.name == 'Baño');
    }
    emit(state.copyWith(
        isWash: value,
        listService: listAdd,
        status: listAdd.isEmpty
            ? StatusFormService.invalidForm
            : StatusFormService.validForm));
  }

  void isEarCleaningChanged(bool value) async {
    final List<Service> listAdd;

    if (value) {
      final _price = PriceCalculator.earCleaning;
      listAdd = List.from(state.listService)
        ..add(Service(name: 'Limpieza de oídos', price: _price));
    } else {
      listAdd = List.from(state.listService)
        ..removeWhere((element) => element.name == 'Limpieza de oídos');
    }
    emit(state.copyWith(
        isEarCleaning: value,
        listService: listAdd,
        status: listAdd.isEmpty
            ? StatusFormService.invalidForm
            : StatusFormService.validForm));
  }

  void isHaircutAndWashChanged(
      bool value, double weight, String kindPet) async {
    final List<Service> listAdd;

    if (value) {
      final _price = PriceCalculator.calculatePriceHairCutAndWashPet(
          weightPet: weight, kindPet: kindPet);
      listAdd = List.from(state.listService)
        ..add(Service(name: 'Corte', price: _price));
    } else {
      listAdd = List.from(state.listService)
        ..removeWhere((element) => element.name == 'Corte');
    }
    emit(state.copyWith(
        isHaircutAndWash: value,
        listService: listAdd,
        status: listAdd.isEmpty
            ? StatusFormService.invalidForm
            : StatusFormService.validForm));
  }

  void isTeethCleaningChanged(bool value) async {
    final List<Service> listAdd;

    if (value) {
      final _price = PriceCalculator.teethCleaning;
      listAdd = List.from(state.listService)
        ..add(Service(name: 'Lavado de dientes', price: _price));
    } else {
      listAdd = List.from(state.listService)
        ..removeWhere((element) => element.name == 'Lavado de dientes');
    }
    emit(state.copyWith(
        isTeethCleaning: value,
        listService: listAdd,
        status: listAdd.isEmpty
            ? StatusFormService.invalidForm
            : StatusFormService.validForm));
  }
}
