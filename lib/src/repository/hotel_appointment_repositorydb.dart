import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_petshopcr/src/models/hotel_appointment.dart';

class HotelAppointmentRepository{
  final CollectionReference _ref = FirebaseFirestore.instance.collection('hotelAppointment');

  Future<void> addNewAppointment(HotelAppointment appointment){
    return _ref.add(appointment.toJson())
    .then((value) => print('Appointment Added'))
    .catchError((error) => print('Failed to add Appointment: $error'));
  }

  Future<HotelAppointment?> getUserAppointment(String appointmentId) async{
    HotelAppointment appointment;
    DocumentSnapshot snapshot;
    snapshot = await _ref.doc(appointmentId).get();
    if(snapshot.exists){
      return appointment = HotelAppointment.fromJson(snapshot.data()!);
    }else{
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