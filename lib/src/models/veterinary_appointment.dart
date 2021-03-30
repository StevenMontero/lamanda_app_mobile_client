import 'package:lamanda_petshopcr/src/models/pet.dart';
import 'package:lamanda_petshopcr/src/models/userProfile.dart';

class VeterinaryAppointment {
  String? appointmentId;
  DateTime? date;
  DateTime? hour;
  UserProfile? client;
  String? symptoms;
  bool? isConfirmed;
  Pet? pet;
  bool? transfer;
  String? direction;
  String proofPhotoUrl = '';
  double priceTotal = 0;
  String pymentType = '';

  VeterinaryAppointment(
      {this.appointmentId,
      this.date,
      this.pymentType = '',
      this.client,
      this.priceTotal = 0,
      this.proofPhotoUrl = '',
      this.symptoms,
      this.hour,
      this.pet,
      this.transfer,
      this.direction,
      this.isConfirmed});

  VeterinaryAppointment.fromJson(Map<String, dynamic> json) {
    this.appointmentId = json['id'];
    this.date = json['entryDate'].toDate();
    this.hour = json['entryHour'].toDate();
    this.pymentType = json['pymentType'];
    this.pet = Pet.fromJson(json['pet'],json['pet']['petID']);
    this.client = UserProfile.fromJson(json['entryUser']);
    this.transfer = json['transfer'];
    this.direction = json['direction'];
    this.symptoms = json['symptoms'];
    this.isConfirmed = json['isConfirmed'];
    this.priceTotal = json['priceTotal'];
    this.proofPhotoUrl = json['proofPhotoUrl'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.appointmentId,
      'entryDate': this.date,
      'pymentType': this.pymentType,
      'entryHour': this.hour,
      'entryUser': this.client!.toJson(),
      'direction': this.direction,
      'transfer': this.transfer,
      'symptoms': this.symptoms,
      'pet': this.pet!.toJson(),
      'isConfirmed': this.isConfirmed,
      'priceTotal': this.priceTotal,
      'proofPhotoUrl': this.proofPhotoUrl,
    };
  }
}
