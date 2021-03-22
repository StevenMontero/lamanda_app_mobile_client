import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_petshopcr/src/models/veterinary_appointment.dart';

class VeterinaryAppointmentRepository {
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('veterinaryAppointment');
  final CollectionReference _refSchedule =
      FirebaseFirestore.instance.collection('schedule');

  Future<void> addNewAppointment(VeterinaryAppointment appointment) {
    return _ref
        .add(appointment.toJson())
        .then((value) => print('Appointment Added'))
        .catchError((error) => print('Failed to add Appointment: $error'));
  }

  Future<VeterinaryAppointment?> getUserAppointment(
      String appointmentId) async {
    DocumentSnapshot snapshot;
    snapshot = await _ref.doc(appointmentId).get();
    if (snapshot.exists) {
      return VeterinaryAppointment.fromJson(snapshot.data()!);
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

  Future<List<DateTime>> getListAppointmetsFree(DateTime date) async {
    List<DateTime> _schedule = await _getSchedule('0erT6C3IbEKcLJCRlxyb');
    QuerySnapshot snapshot = await _ref.get();
    DateTime? _auxDaate;
    DateTime? _auxHour;
    final result = snapshot.docs;
    result.forEach((element) {
      _auxDaate = element.data()!['entryDate'].toDate();
      _auxHour = element.data()!['entryHour'].toDate();
      if (_auxDaate!.day == date.day &&
          _auxDaate!.month == date.month &&
          _auxDaate!.year == date.year) {
        _schedule.removeWhere((a) => a.hour == _auxHour!.hour);
      }
    });

    return _schedule;
  }

  //Future<void> updateUser(DayCareAppointment user, ){
  //  return _ref.doc(user.id)
  //  .update(user.toJson())
  //  .then((value) => print('Success Update'))
  //  .catchError((error) => print('Failure Update'));
  //}
}
