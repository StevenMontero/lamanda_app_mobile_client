import 'package:lamanda_petshopcr/src/models/veterinary_appointment.dart';


class VeterinaryAppointmenList {
  String date = '';
  List<VeterinaryAppointment> appointments = [];
  List<DateTime> reservedTimes = [];
  VeterinaryAppointmenList(
      {required this.date, required this.appointments, required this.reservedTimes});

  VeterinaryAppointmenList.fromJson(Map<String, dynamic> json) {
    this.date = json['date'];
    this.appointments =  List<VeterinaryAppointment>.from(json['appointments']
        .map((model) => VeterinaryAppointment.fromJson(model)));
    this.reservedTimes =
        List<DateTime>.from(json['reservedTimes'].map((date) => date.toDate()));
  }

  Map<String, dynamic> toJson() {
    return {
      'date': this.date,
      'reservedTimes': this.reservedTimes,
      'appointments': List<dynamic>.from(appointments.map((x) => x.toJson()))

    };
  }
}