
import 'package:lamanda_petshopcr/src/models/pet.dart';

class PetList{

  List<Pet?>? _list = [];
  Pet? pet;

  PetList();

  //PetList.fromJsonList(List<dynamic> jsonList){
  //  if(jsonList.any((element) => true)){
  //    for (var petObj in jsonList){
  //      pet = new Pet.fromJson(petObj);
  //      _list!.add(pet);
  //    }
  //  }else {
  //    _list = null;
  //  }
  //}

  void addPetToList(Pet pet){
    _list!.add(pet);
  }

  List<Pet?>? getPetList(){
    return _list;
  }

}