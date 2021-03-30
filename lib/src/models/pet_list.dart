import 'package:lamanda_petshopcr/src/models/pet.dart';

class PetList {
  List<Pet>? _list = [];

  PetList();

  PetList.fromJsonList(List<dynamic> jsonList) {
    if (jsonList.any((element) => true)) {
      for (var petObj in jsonList) {
        _list!.add(Pet.fromJson(petObj, petObj.petId));
      }
    } else {
      _list = null;
    }
  }

  void addPetToList(Pet pet) {
    _list!.add(pet);
  }

  List<Pet?>? getPetList() {
    return _list;
  }
}
