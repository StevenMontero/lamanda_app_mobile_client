import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_petshopcr/src/models/pet.dart';

class PetRepository {
  final CollectionReference _ref = FirebaseFirestore.instance.collection('pet');
  Reference storageRef = FirebaseStorage.instance.ref();
  Pet? pet;
  
 // Future<void> addNewPet(Pet pet ) {
 //   return _ref
 //       .add(pet.toJson())
 //       .then((value) => print('Pet Added'))
 //       .catchError((error) => print('Failed to add pet: $error'));
 // }

  Future<Pet?> getPet(String idPet) async {
    DocumentSnapshot snapshot;
    snapshot = await _ref.doc(idPet).get();
    if (snapshot.exists) {
      return pet = Pet.fromJson(snapshot.data()!);
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

  Future<void> addNewPet(File? file, Pet pet) async {
    String? filepath = p.basename(file!.path);
    try {
      await storageRef.child('pets/' + '$filepath').putFile(file); 
      pet.photoUrl = await FirebaseStorage.instance.ref('pets/' + '$filepath').getDownloadURL();
      await _ref.add(pet.toJson())
        .then((value) => print('Pet Added'))
        .catchError((error) => print('Failed to add pet: $error'));
    } on FirebaseException catch (e) {
      print('Error subir foto :' + e.toString());
    }
  }
}
