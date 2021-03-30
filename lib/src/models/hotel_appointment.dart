//import 'package:lamanda_petshopcr/src/models/pet.dart';
//import 'package:lamanda_petshopcr/src/models/pet_list.dart';
import 'package:lamanda_petshopcr/src/models/pet.dart';
import 'package:lamanda_petshopcr/src/models/userProfile.dart';

class HotelAppointment {
  String? appointmentId;
  DateTime? startDate;
  DateTime? endDate;
  UserProfile? client;
  String? personPicksUp;
  DateTime? lastdeworming;
  DateTime? pestProtection;
  String? addres;
  bool? transfer;
  bool? isConfirmed;
  Pet? pet;
  String proofPhotoUrl = '';
  double priceTotal = 0;
  String pymentType = '';

  HotelAppointment({
    this.endDate,
    this.personPicksUp,
    this.addres,
    this.startDate,
    this.priceTotal = 0,
    this.proofPhotoUrl = '',
    this.pet,
    this.client,
    this.appointmentId,
    this.isConfirmed,
    this.lastdeworming,
    this.pestProtection,
    this.transfer,
    this.pymentType = '',
    //this.petList,
  });

  HotelAppointment.fromJson(Map<String, dynamic> json) {
    this.endDate = json['departureDate'];
    this.personPicksUp = json['departureUser'];
    this.addres = json['direction'];
    this.startDate = json['entryDate'];
    this.client = json['entryUser'];
    this.appointmentId = json['id'];
    this.isConfirmed = json['isConfirmed'];
    this.lastdeworming = json['lastDeworing'];
    this.pestProtection = json['lastProtectionFleas'];
    this.transfer = json['transfer'];
    this.pet = Pet.fromJson(json['pet'],json['pet']['petID']);
    this.priceTotal = json['priceTotal'];
    this.proofPhotoUrl = json['proofPhotoUrl'];
    this.pymentType = json['pymentType'];
  }

  Map<String, dynamic> toJson() {
    return {
      'departureDate': this.endDate,
      'departureUser': this.personPicksUp,
      'direction': this.addres,
      'entryDate': this.startDate,
      'entryUser': this.client!.toJson(),
      'id': this.appointmentId,
      'isConfirmed': this.isConfirmed,
      'lastDeworing': this.lastdeworming,
      'lastProtectionFleas': this.pestProtection,
      'transfer': this.transfer,
      'priceTotal': this.priceTotal,
      'proofPhotoUrl': this.proofPhotoUrl,
      'pymentType': this.pymentType,
      'pet': this.pet!.toJson(),
    };
  }
}
