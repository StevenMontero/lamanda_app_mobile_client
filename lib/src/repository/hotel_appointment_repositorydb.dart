import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lamanda_petshopcr/src/models/hotel_appointment.dart';
import 'package:path/path.dart' as path;

class HotelAppointmentRepository {
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('hotelAppointment');
  Reference storageRef = FirebaseStorage.instance.ref();
  Future<void> addNewAppointment(HotelAppointment appointment,
      {File? proof}) async {
    try {
      if (appointment.pymentType == 'Sinpe' && proof != null) {
        String? filepath = path.basename(proof.path);
        await storageRef.child('proofPayment/' + '$filepath').putFile(proof);
        appointment.proofPhotoUrl = await FirebaseStorage.instance
            .ref('proofPayment/' + '$filepath')
            .getDownloadURL();
      }
      return _ref
          .add(appointment.toJson())
          .then((value) => print('Appointment Added'))
          .catchError((error) => print('Failed to add Appointment: $error'));
    } on FirebaseException catch (e) {
      print('Error subir foto :' + e.toString());
    }
  }

  Future<HotelAppointment?> getUserAppointment(String appointmentId) async {
    DocumentSnapshot snapshot;
    snapshot = await _ref.doc(appointmentId).get();
    if (snapshot.exists) {
    } else {
      return null;
    }
  }

  Future<List<HotelAppointment>> getListAppointmets(String userID) async {
    List<HotelAppointment> hotelAppointmentList = [];
    QuerySnapshot snapshot = await _ref.get();
    final result = snapshot.docs.where((DocumentSnapshot document) =>
        document.data()!['entryUser']['id'].contains(userID));
    result.forEach((element) {
      hotelAppointmentList.add(HotelAppointment.fromJson(element.data()!));
    });

    return hotelAppointmentList;
  }

  //Future<void> updateUser(DayCareAppointment user, ){
  //  return _ref.doc(user.id)
  //  .update(user.toJson())
  //  .then((value) => print('Success Update'))
  //  .catchError((error) => print('Failure Update'));
  //}
}
