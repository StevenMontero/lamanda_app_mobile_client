//import 'package:lamanda_petshopcr/src/models/pet.dart';
//import 'package:lamanda_petshopcr/src/models/pet_list.dart';
import 'package:lamanda_petshopcr/src/models/userProfile.dart';

class StheticAppointment {
  String? appointmentId;
  DateTime? entrytDate;
  DateTime? entrytHour;
  UserProfile? client;
  //List<Pet> petList;
  bool? isConfirmed;
  bool? transfer;
  String? address;
  String? fur;

  StheticAppointment(
      {this.appointmentId,
      this.entrytDate,
      this.client,
      //this.petList,
      this.isConfirmed,
      this.entrytHour,
      this.address,
      this.transfer,
      this.fur});

  StheticAppointment.fromJson(Map<String, dynamic> json) {
    //PetList getPetList = new PetList.fromJsonList(json['petList']);

    this.address = json['direction']; // cambiar a addres
    this.entrytDate = json['entrytDate'].toDate();
    this.client = json['entryUser'];
    this.appointmentId = json['id'];
    this.entrytHour = json['entrytHour'].toDate();
    //this.petList = getPetList.getPetList();
    this.isConfirmed = json['isConfirmed'];
    this.transfer = json['transfer'];
    this.fur = json['fur'];
  }

  Map<String, dynamic> toJson() {
    return {
      'direction': this.address,
      'entryDate': this.entrytDate,
      'entryHour': this.entrytHour,
      'entryUser': this.client!.toJson(),
      'id': this.appointmentId,
      //'petList': this.petList,
      'isConfirmed': this.isConfirmed,
      'transfer': this.transfer,
      'fur': this.fur
    };
  }
}
