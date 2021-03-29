import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_petshopcr/src/models/sthetic_appoiments_list.dart';
import 'package:lamanda_petshopcr/src/models/sthetic_appointment.dart';

class StheticAppointmentRepository {
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('stheticAppointment');
  final CollectionReference _refSchedule =
      FirebaseFirestore.instance.collection('schedule');

  void addNewAppointment(StheticAppointment appointment, String dateId) async {
    var estheticAppointmentsList = await getDocumetAppointmentByDate(dateId);
    if (estheticAppointmentsList != null) {
      estheticAppointmentsList.appointments.add(appointment);
      estheticAppointmentsList.reservedTimes.add(appointment.entrytHour!);
      // _ref
      //     .doc(dateId)
      //     .update({
      //       'reservedTimes': estheticAppointmentsList.reservedTimes,
      //       'appointments': estheticAppointmentsList.appointments
      //     })
      //     .then((value) => print('Appointment Added'))
      //     .catchError((error) => print('Failed to add Appointment: $error'));
    } else {
      estheticAppointmentsList = new EstheticAppointmentsList(
          date: dateId,
          appointments: <StheticAppointment>[appointment],
          reservedTimes: <DateTime>[appointment.entrytHour!]);
    }
    _ref
        .doc(dateId)
        .set(estheticAppointmentsList.toJson())
        .then((value) => print('Appointment Added'))
        .catchError((error) => print('Failed to add Appointment: $error'));
  }

  Future<EstheticAppointmentsList?> getDocumetAppointmentByDate(
      String appointmentId) async {
    DocumentSnapshot snapshot;
    snapshot = await _ref.doc(appointmentId).get();
    if (snapshot.exists) {
      return EstheticAppointmentsList.fromJson(snapshot.data()!);
    } else {
      return null;
    }
  }

  Future<List<DateTime>> _getSchedule(String scheduleId) async {
    List<DateTime> _schedule = [];
    DocumentSnapshot snapshot = await _refSchedule.doc(scheduleId).get();
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
    final estheticAppointmentsList = await getDocumetAppointmentByDate(dateId);
    if (estheticAppointmentsList != null) {
      final result = estheticAppointmentsList.reservedTimes;
      result.forEach((element) {
        _schedule.removeWhere((a) => a.hour == element.hour);
      });
      return _schedule;
    } else {
      return _schedule;
    }
  }

  Future<List<StheticAppointment>> getListAppointmets(String userID) async {
    List<StheticAppointment> stheticAppointmentList = [];
    QuerySnapshot snapshot = await _ref.get();
    final result = snapshot.docs.where((DocumentSnapshot document) =>
        document.data()!['user']['id'].contains(userID));
    result.forEach((element) {
      stheticAppointmentList.add(StheticAppointment.fromJson(element.data()!));
    });

    return stheticAppointmentList;
  }

}
