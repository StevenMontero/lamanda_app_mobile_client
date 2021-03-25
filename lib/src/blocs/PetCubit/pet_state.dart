part of 'pet_cubit.dart';

class PetState extends Equatable {

  final String? petID;
  final String? userID;
  final TextNoEmpty name;
  final TextNoEmpty breed;
  final NumberNoEmpty age;
  final TextNoEmpty fur;
  final NumberNoEmpty weigth; 
  final bool isVaccinationUpDate;
  final bool isCastrated;
  final bool isSociable;
  final String? photoUrl;
  final File? photo;
  final TextNoEmpty kindPet;
  final List<Pet>? petList;
  final FormzStatus status;

  const PetState({
    this.petID,
    this.userID,
    this.name = const TextNoEmpty.pure(),
    this.breed = const TextNoEmpty.pure(),
    this.age = const NumberNoEmpty.pure(),
    this.fur = const TextNoEmpty.pure(),
    this.weigth = const NumberNoEmpty.pure(),
    this.isVaccinationUpDate = false,
    this.isCastrated = false,
    this.isSociable = false,
    this.photoUrl,
    this.photo,
    this.kindPet = const TextNoEmpty.pure(),
    this.petList,
    this.status = FormzStatus.pure,
  });

  PetState copyWith({
    String? petID,
    String? userID,
    TextNoEmpty? name,
    TextNoEmpty? breed,
    NumberNoEmpty? age,
    TextNoEmpty? fur, 
    NumberNoEmpty? weigth,
    bool? isVaccinationUpDate,
    bool? isCastrated,
    bool? isSociable,
    String? photoUrl,
    File? photo,
    TextNoEmpty? kindPet,
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
