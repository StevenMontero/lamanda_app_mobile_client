part of 'pet_cubit.dart';

class PetState extends Equatable {
  const PetState({

    this.petID,
    this.userID,
    this.name,
    this.breed,
    this.age,
    this.fur,
    this.isVaccinationUpDate = false,
    this.isCastrated = false,
    this.isSociable = false,
    this.photoUrl,
    this.petList,
    this.status
  });

  final String? petID;
  final String? userID;
  final String? name;
  final String? breed;
  final int? age;
  final String? fur; 
  final bool isVaccinationUpDate;
  final bool isCastrated;
  final bool isSociable;
  final String? photoUrl;
  final List<Pet>? petList;
  final FormzStatus? status;
  
  PetState copyWith({
    String? petID,
    String? userID,
    String? name,
    String? breed,
    int? age,
    String? fur, 
    bool? isVaccinationUpDate,
    bool? isCastrated,
    bool? isSociable,
    String? photoUrl,
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
        isVaccinationUpDate: isVaccinationUpDate ?? this.isVaccinationUpDate,
        isCastrated: isCastrated ?? this.isCastrated,
        isSociable: isSociable ?? this.isSociable,
        photoUrl: photoUrl ?? this.photoUrl,
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
        isVaccinationUpDate,
        isCastrated,
        isSociable,
        photoUrl,
        petList,
        status,  
      ];
}
