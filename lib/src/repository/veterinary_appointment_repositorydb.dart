import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_petshopcr/src/models/veterinary_appoiment_list.dart';
import 'package:lamanda_petshopcr/src/models/veterinary_appointment.dart';

class VeterinaryAppointmentRepository {
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('veterinaryAppointment');
  final CollectionReference _refSchedule =
      FirebaseFirestore.instance.collection('schedule');

 void addNewAppointment(VeterinaryAppointment appointment, String dateId) async {
    var veterinaryAppointmentsList = await getDocumetAppointmentByDate(dateId);
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
    //TODO: iMPLEMENTAR REAL TIME
    List<DateTime> _schedule = await _getSchedule('0erT6C3IbEKcLJCRlxyb');
    final veterinaryAppointmentsList = await getDocumetAppointmentByDate(dateId);
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
