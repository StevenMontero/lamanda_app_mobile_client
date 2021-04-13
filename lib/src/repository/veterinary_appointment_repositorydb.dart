import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lamanda_petshopcr/src/models/veterinary_appoiment_list.dart';
import 'package:lamanda_petshopcr/src/models/veterinary_appointment.dart';
import 'package:path/path.dart' as path;

class VeterinaryAppointmentRepository {
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('veterinaryAppointment');
  final CollectionReference _refSchedule =
      FirebaseFirestore.instance.collection('schedule');
  Reference storageRef = FirebaseStorage.instance.ref();
  void addNewAppointment(VeterinaryAppointment appointment, String dateId,
      {File? proof}) async {
    try {
      if (appointment.pymentType == 'Sinpe' && proof != null) {
        String? filepath = path.basename(proof.path);
        await storageRef.child('proofPayment/' + '$filepath').putFile(proof);
        appointment.proofPhotoUrl = await FirebaseStorage.instance
            .ref('proofPayment/' + '$filepath')
            .getDownloadURL();
      }
      var veterinaryAppointmentsList =
          await getDocumetAppointmentByDate(dateId);
      if (veterinaryAppointmentsList != null) {
        veterinaryAppointmentsList.appointments.add(appointment);
        veterinaryAppointmentsList.reservedTimes.add(appointment.hour!);
      } else {
        veterinaryAppointmentsList = new VeterinaryAppointmenList(
            date: dateId,
            appointments: <VeterinaryAppointment>[appointment],
            reservedTimes: <DateTime>[appointment.hour!]);
      }
      _ref
          .doc(dateId)
          .set(veterinaryAppointmentsList.toJson())
          .then((value) => print('Appointment Added'))
          .catchError((error) => print('Failed to add Appointment: $error'));
    } on FirebaseException catch (e) {
      print('Error subir foto :' + e.toString());
    }
  }

  Future<VeterinaryAppointmenList?> getDocumetAppointmentByDate(
      String appointmentId) async {
    DocumentSnapshot snapshot;
    snapshot = await _ref.doc(appointmentId).get();
    if (snapshot.exists) {
      return VeterinaryAppointmenList.fromJson(snapshot.data()!);
    } else {
      return null;
    }
  }

  Future<List<VeterinaryAppointment>> getListAppointmets(String userID) async {
    List<VeterinaryAppointment> veterinaryAppointmentList = [];
    QuerySnapshot snapshot = await _ref.get();
    final result = snapshot.docs.where((DocumentSnapshot document) =>
        document.data()!['user']['id'].contains(userID));
    result.forEach((element) {
      veterinaryAppointmentList
          .add(VeterinaryAppointment.fromJson(element.data()!));
    });

    return veterinaryAppointmentList;
  }

  Future<List<DateTime>> _getSchedule(String appointmentId) async {
    List<DateTime> _schedule = [];
    DocumentSnapshot snapshot;
    snapshot = await _refSchedule.doc(appointmentId).get();
    if (snapshot.exists) {
      _schedule = List<DateTime>.from(
          snapshot.data()!['schedules'].map((x) => x.toDate()));
      final a = DateTime.now();
      print(a);
      return _schedule;
    } else {
      return _schedule;
    }
  }

  Future<List<DateTime>> getListAppointmetsFree(String dateId) async {
    List<DateTime> _schedule = await _getSchedule('0erT6C3IbEKcLJCRlxyb');
    final veterinaryAppointmentsList =
        await getDocumetAppointmentByDate(dateId);
    if (veterinaryAppointmentsList != null) {
      final result = veterinaryAppointmentsList.reservedTimes;
      result.forEach((element) {
        _schedule.removeWhere((a) => a.hour == element.hour);
      });
      return _schedule;
    } else {
      return _schedule;
    }
  }

  //Future<void> updateUser(DayCareAppointment user, ){
  //  return _ref.doc(user.id)
  //  .update(user.toJson())
  //  .then((value) => print('Success Update'))
  //  .catchError((error) => print('Failure Update'));
  //}
}
