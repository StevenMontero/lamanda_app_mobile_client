import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lamanda_petshopcr/src/models/pet.dart';
import 'package:lamanda_petshopcr/src/repository/pet_repositorydb.dart';
import 'package:lamanda_petshopcr/src/utils/regularExpressions/regular_expressions_models.dart';

part 'pet_state.dart';

class PetCubit extends Cubit<PetState> {
  PetCubit(this.petRepository) : super(PetState());
  final PetRepository petRepository;
  Pet? pet;
  final picker = ImagePicker();
  File? _photo;
  List<String> _kindPetList = ['Perro', 'Gato'];
  List<String> _furList = ['Largo', 'Corto'];

  void fillInitialDataPet(Pet pet) async {
    emit(state.copyWith(
      petID: pet.petId,
        userID: pet.userId,
        name: ValidatorText.dirty(pet.name!),
        breed: ValidatorText.dirty(pet.breed!),
        age: NumberNoEmpty.dirty(pet.age.toString()),
        fur: ValidatorText.dirty(pet.fur!),
        kindPet: ValidatorText.dirty(pet.kindPet!),
        weigth: NumberNoEmpty.dirty(pet.weight!.toString()),
        isVaccinationUpDate: pet.isVaccinationUpDate,
        isCastrated: pet.castrated,
        isSociable: pet.sociable,
        photoUrl: pet.photoUrl,
      ));
  }

  void nameChanged(String value) {
    final name = ValidatorText.dirty(value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate(
          [name, state.breed, state.age, state.fur, state.weigth, state.kindPet]),
    ));
  }

  void breedChanged(String value) {
    final breed = ValidatorText.dirty(value);
    emit(state.copyWith(
      breed: breed,
      status: Formz.validate(
          [state.name, breed, state.age, state.fur, state.weigth, state.kindPet]),
    ));
  }

  void ageChanged(String value) {
    final age = NumberNoEmpty.dirty(value);
    emit(state.copyWith(
      age: age,
      status: Formz.validate(
          [state.name, state.breed, age, state.fur, state.weigth, state.kindPet]),
    ));
  }

  void furChanged(String value) {
    final fur = ValidatorText.dirty(value);
    emit(state.copyWith(
      fur: fur,
      status: Formz.validate(
          [state.name, state.breed, state.age, fur, state.weigth, state.kindPet]),
    ));
    emit(state.copyWith(fur: fur));
  }

  void weigthChanged(String value) {
    final weigth = NumberNoEmpty.dirty(value);
    emit(state.copyWith(
      weigth: weigth,
      status: Formz.validate(
          [state.name, state.breed, state.age, state.fur, weigth, state.kindPet]),
    ));
  }

  void kindPetChanged(String value){
    final kindPet = ValidatorText.dirty(value);
    emit(state.copyWith(
      kindPet: kindPet,
      status: Formz.validate(
          [state.name, state.breed, state.age, state.fur, state.weigth, kindPet]),
    ));
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

  void filePhotoChange(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source, imageQuality: 70);
    if (pickedFile != null) {
      _photo = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    emit(state.copyWith(photoUrl: _photo!.path, photo: _photo));
  }

  Future<void> addPetForm(String userID) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      pet = new Pet(
        userId: userID,
        name: state.name.value,
        breed: state.breed.value,
        age: int.parse(state.age.value),
        fur: state.fur.value,
        kindPet: state.kindPet.value,
        weight: double.parse(state.weigth.value),
        isVaccinationUpDate: state.isVaccinationUpDate,
        castrated: state.isCastrated,
        sociable: state.isSociable,
        photoUrl: state.photoUrl,
      );
      petRepository.addNewPet(_photo!, pet!);
      state.petList!.add(pet!);
      emit(state.copyWith(status: FormzStatus.submissionSuccess, petList: state.petList));
    } catch (error) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
  //Actualiza los datos de la mascota
  Future<void> updatePet()async{
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      pet = new Pet(
        petId: state.petID,
        userId: state.userID,
        name: state.name.value,
        breed: state.breed.value,
        age: int.parse(state.age.value),
        fur: state.fur.value,
        kindPet: state.kindPet.value,
        weight: double.parse(state.weigth.value),
        isVaccinationUpDate: state.isVaccinationUpDate,
        castrated: state.isCastrated,
        sociable: state.isSociable,
        photoUrl: state.photoUrl,
      );
      petRepository.updatePet(pet!);
      emit(state.copyWith(status: FormzStatus.submissionSuccess, petList: state.petList));
    } catch (error) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }

  }
  //Elimina la mascota seleccionada
  Future<void> deletePet(String petID, int index) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      petRepository.deletePet(petID);
      state.petList!.removeAt(index);
      emit(state.copyWith(status: FormzStatus.submissionSuccess, petList: state.petList!));
    } catch (error) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<Pet?> getMyPet(String idPet) async {
    pet = await petRepository.getPet(idPet);
    if (pet != null) {
      emit(state.copyWith(petID: pet!.petId));
    }
    return pet;
  }

  Future<List<Pet>> getPets(String id) async {
    List<Pet> list = await petRepository.getpetList(id);
    if (list.isEmpty != true) {
      emit(state.copyWith(petList: list));
    }
    return list;
  }

  List<DropdownMenuItem<String>> getKindPetList() {
    List<DropdownMenuItem<String>> lista = [];
    _kindPetList.forEach((element) {
      lista.add(DropdownMenuItem(
        child: Text(element),
        value: element,
      ));
    });
    return lista;
  }

  List<DropdownMenuItem<String>> getfurList() {
    List<DropdownMenuItem<String>> lista = [];
    _furList.forEach((element) {
      lista.add(DropdownMenuItem(
        child: Text(element),
        value: element,
      ));
    });
    return lista;
  }
}
