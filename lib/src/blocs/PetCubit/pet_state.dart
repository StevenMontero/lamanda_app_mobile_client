part of 'pet_cubit.dart';

class PetState extends Equatable {

  final String? petID;
  final String? userID;
  final ValidatorText name;
  final ValidatorText breed;
  final NumberNoEmpty age;
  final ValidatorText fur;
  final NumberNoEmpty weigth; 
  final bool isVaccinationUpDate;
  final bool isCastrated;
  final bool isSociable;
  final String? photoUrl;
  final File? photo;
  final ValidatorText kindPet;
  final List<Pet>? petList;
  final FormzStatus status;

  const PetState({
    this.petID,
    this.userID,
    this.name = const ValidatorText.pure(),
    this.breed = const ValidatorText.pure(),
    this.age = const NumberNoEmpty.pure(),
    this.fur = const ValidatorText.pure(),
    this.weigth = const NumberNoEmpty.pure(),
    this.isVaccinationUpDate = false,
    this.isCastrated = false,
    this.isSociable = false,
    this.photoUrl,
    this.photo,
    this.kindPet = const ValidatorText.pure(),
    this.petList,
    this.status = FormzStatus.pure,
  });

  PetState copyWith({
    String? petID,
    String? userID,
    ValidatorText? name,
    ValidatorText? breed,
    NumberNoEmpty? age,
    ValidatorText? fur, 
    NumberNoEmpty? weigth,
    bool? isVaccinationUpDate,
    bool? isCastrated,
    bool? isSociable,
    String? photoUrl,
    File? photo,
    ValidatorText? kindPet,
    List<Pet>? petList,
    FormzStatus? status,
  }) {
    return PetState(
        petID: petID ?? this.petID,
        userID: userID ?? this.userID,
        name: name ?? this.name,
        breed: breed ?? this.breed,
        age: age ?? this.age,
        fur: fur ?? this.fur,
        weigth: weigth ?? this.weigth,
        isVaccinationUpDate: isVaccinationUpDate ?? this.isVaccinationUpDate,
        isCastrated: isCastrated ?? this.isCastrated,
        isSociable: isSociable ?? this.isSociable,
        photoUrl: photoUrl ?? this.photoUrl,
        photo: photo ?? this.photo,
        kindPet: kindPet ?? this.kindPet,
        petList: petList ?? this.petList,
        status: status ?? this.status,
        );
  }

  @override
  List<Object?> get props => [
        petID,
        userID,
        name,
        breed,
        age,
        fur,
        weigth,
        isVaccinationUpDate,
        isCastrated,
        isSociable,
        photoUrl,
        photo,
        kindPet,
        petList,
        status,  
      ];
}
