import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_petshopcr/src/models/daycare_appointment.dart';

class DaycareAppointmentRepository {
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('daycareAppointment');

  Future<void> addNewAppointment(DaycareAppointment appointment) {
    return _ref
        .add(appointment.toJson())
        .then((value) => print('Appointment Added'))
        .catchError((error) => print('Failed to add Appointment: $error'));
  }

  Future<DaycareAppointment?> getUserAppointment(String appointmentId) async {
    DaycareAppointment appointment;
    DocumentSnapshot snapshot;
    snapshot = await _ref.doc(appointmentId).get();
    if (snapshot.exists) {
      return appointment = DaycareAppointment.fromJson(snapshot.data()!);
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
