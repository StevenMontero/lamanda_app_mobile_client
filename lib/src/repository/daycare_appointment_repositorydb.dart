import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lamanda_petshopcr/src/models/daycare_appointment.dart';
import 'package:path/path.dart' as path;

class DaycareAppointmentRepository {
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('daycareAppointment');
  Reference storageRef = FirebaseStorage.instance.ref();
  Future<void> addNewAppointment(
      DaycareAppointment appointment, {File? proof}) async {
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

  Future<DaycareAppointment?> getUserAppointment(String appointmentId) async {
    DocumentSnapshot snapshot;
    snapshot = await _ref.doc(appointmentId).get();
    if (snapshot.exists) {
      return DaycareAppointment.fromJson(snapshot.data()!);
    } else {
      return null;
    }
  }

  Future<List<DaycareAppointment>> getListAppointmets(String userID) async {
    List<DaycareAppointment> daycareAppointmentList = [];
    QuerySnapshot snapshot = await _ref.get();
    final result = snapshot.docs.where((DocumentSnapshot document) =>
        document.data()!['entryUser']['id'].contains(userID));
    result.forEach((element) {
      daycareAppointmentList.add(DaycareAppointment.fromJson(element.data()!));
    });

    return daycareAppointmentList;
  }

  //Future<void> updateUser(DayCareAppointment user, ){
  //  return _ref.doc(user.id)
  //  .update(user.toJson())
  //  .then((value) => print('Success Update'))
  //  .catchError((error) => print('Failure Update'));
  //}
}
