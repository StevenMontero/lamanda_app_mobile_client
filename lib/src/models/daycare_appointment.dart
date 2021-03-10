//import 'package:lamanda_petshopcr/src/models/pet.dart';
//import 'package:lamanda_petshopcr/src/models/pet_list.dart';
import 'package:lamanda_petshopcr/src/models/userProfile.dart';

class DaycareAppointment{

  String? appointmentId;
  DateTime? date;
  DateTime? entryHour;
  DateTime? departureHour;
  String? race;
  int? age;
  UserProfile? userDeliver; 
  String? userPickup;
  DateTime? lastDeworming;
  DateTime? lastProtectionFleas;
  String? direccion;
  bool? isVaccinationUpDate;
  bool? isCastrated;
  bool? isSociable;
  bool? transfer;
  bool? isConfirmed;

    DaycareAppointment({
    this.appointmentId,
    this.date,
    this.entryHour,
    this.departureHour,
    this.race,
    this.age,
    this.userDeliver,
    this.userPickup,
    this.direccion,
    this.isVaccinationUpDate,
    this.isCastrated,
    this.isSociable,
    this.lastDeworming,
    this.lastProtectionFleas,
    this.transfer,
    this.isConfirmed
    //this.petList,
  });

  DaycareAppointment.fromJson(Map<String, dynamic> json){
    
      //PetList getPetList = new PetList.fromJsonList(json['petList']);
      this.appointmentId =json['id'];
      this.age = json['age'];
      this.date = json['date'];
      this.entryHour = json['entryHour'];
      this.departureHour= json['departureHour'];
      this.race =json['race'];
      this.userDeliver = json['userDeliver'];
      this.userPickup = json['userPickup'];
      this.direccion = json['direction'];
      this.isVaccinationUpDate =json['isVaccinationUpDate'];
      this.isCastrated =json['isCastrated'];
      this.isSociable = json['isSociable'];
      this.lastDeworming = json['lastDeworing'];
      this.lastProtectionFleas =json['lastProtectionFleas'];
      this.transfer = json['transfer'];
      this.isConfirmed = json['isConfirmed'];
  }
  
  Map<String, dynamic> toJson(){
    return {
      'id': this.appointmentId,
      'age': this.age,
      'date': this.date,
      'entryHour': this.entryHour,
      'departureHour': this.departureHour,
      'race': this.race,
      'userDeliver': this.userDeliver!.toJson(),
      'userPickup': this.userPickup,
      'direction': this.direccion,
      'isVaccinationUpDate': this.isVaccinationUpDate,
      'isCastrated': this.isCastrated,
      'isSociable': this.isSociable,
      'lastDeworing': this.lastDeworming,
      'lastProtectionFleas': this.lastProtectionFleas,
      'transfer': this.transfer,
      'isConfirmed': this.isConfirmed,
      //'petList': this.petList,
    };
  }

}