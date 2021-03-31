import 'package:lamanda_petshopcr/src/models/pet.dart';
import 'package:lamanda_petshopcr/src/models/service.dart';
import 'package:lamanda_petshopcr/src/models/userProfile.dart';

class StheticAppointment {
  String? appointmentId;
  DateTime? entrytDate;
  DateTime? entrytHour;
  UserProfile? client;
  Pet? pet;
  bool? isConfirmed;
  bool? transfer;
  String? address;
  String proofPhotoUrl = '';
  List<Service>? listService;
  double priceTotal = 0;
  String pymentType = '';

  StheticAppointment({
    this.appointmentId,
    this.listService,
    this.priceTotal = 0,
    this.proofPhotoUrl = '',
    this.pymentType = '',
    this.entrytDate,
    this.client,
    this.pet,
    this.isConfirmed,
    this.entrytHour,
    this.address,
    this.transfer,
  });

  StheticAppointment.fromJson(Map<String, dynamic> json) {
    //PetList getPetList = new PetList.fromJsonList(json['petList']);

    this.address = json['direction']; // cambiar a addres
    this.entrytDate = json['entryDate'].toDate();
    this.client = UserProfile.fromJson(json['entryUser']);
    this.pymentType = json['pymentType'];
    this.appointmentId = json['id'];
    this.priceTotal = json['priceTotal'];
    this.entrytHour = json['entryHour'].toDate();
    this.pet = Pet.fromJson(json['pet']);
    this.isConfirmed = json['isConfirmed'];
    this.proofPhotoUrl = json['proofPhotoUrl'];
    this.transfer = json['transfer'];
    this.listService = List<Service>.from(
        json['listService'].map((service) => Service.fromJson(service)));
  }

  Map<String, dynamic> toJson() {
    return {
      'direction': this.address,
      'entryDate': this.entrytDate,
      'entryHour': this.entrytHour,
      'entryUser': this.client!.toJson(),
      'id': this.appointmentId,
      'pet': this.pet!.toJson(),
      'isConfirmed': this.isConfirmed,
      'transfer': this.transfer,
      'proofPhotoUrl': this.proofPhotoUrl,
      'pymentType': this.pymentType,
      'listService': List<dynamic>.from(listService!.map((x) => x.toJson())),
      'priceTotal': this.priceTotal
    };
  }
}
