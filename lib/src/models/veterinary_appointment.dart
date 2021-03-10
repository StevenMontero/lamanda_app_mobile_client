import 'package:lamanda_petshopcr/src/models/userProfile.dart';

class VeterinaryAppointment {
  String? appointmentId;
  DateTime? date;
  DateTime? hour;
  UserProfile? client;
  String? symptoms;
  bool? isConfirmed;
  bool? transfer;
  String? direction;
  String? race;

  VeterinaryAppointment(
      {this.appointmentId,
      this.date,
      this.client,
      this.symptoms,
      this.hour,
      this.race,
      this.transfer,
      this.direction,
      this.isConfirmed});

  VeterinaryAppointment.fromJson(Map<String, dynamic> json) {
    this.appointmentId = json['id'];
    this.date = json['entryDate'];
    this.hour = json['entryHour'];
    this.client = UserProfile.fromJson(json['entryUser']);
    this.transfer = json['transfer'];
    this.direction = json['direction'];
    this.symptoms = json['symptoms'];
    this.race = json['race'];
    this.isConfirmed = json['isConfirmed'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.appointmentId,
      'entryDate': this.date,
      'entryHour': this.hour,
      'entryUser': this.client!.toJson(),
      'race': this.race,
      'direction': this.direction,
      'transfer': this.transfer,
      'symptoms': this.symptoms,
      'isConfirmed': this.isConfirmed,
    };
  }
}
