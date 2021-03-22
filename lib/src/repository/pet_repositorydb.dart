import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_petshopcr/src/models/pet.dart';

class PetRepository {
  final CollectionReference _ref = FirebaseFirestore.instance.collection('pet');

  Future<void> addNewPet(Pet pet) {
    return _ref
        .add(pet.toJson())
        .then((value) => print('Pet Added'))
        .catchError((error) => print('Failed to add pet: $error'));
  }

  Future<Pet?> getPet(String idPet) async {
    DocumentSnapshot snapshot;
    snapshot = await _ref.doc(idPet).get();
    if (snapshot.exists) {
      return Pet.fromJson(snapshot.data()!);
    } else {
      return null;
    }
  }

  Future<void> updatePet(Pet pet) {
    return _ref
        .doc(pet.petId)
        .update(pet.toJson())
        .then((value) => print('Success Update'))
        .catchError((error) => print('Failure Update'));
  }

  Future<List<Pet>> getpetList(String id) async {
    List<Pet> pets = [];
    QuerySnapshot snapshot = await _ref.get();
    final result = snapshot.docs.where(
        (DocumentSnapshot document) => document.data()!['userID'].contains(id));
    result.forEach((element) {
      pets.add(Pet.fromJson(element.data()!));
    });

    return pets;
  }
}
