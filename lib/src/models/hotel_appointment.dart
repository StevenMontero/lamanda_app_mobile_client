//import 'package:lamanda_petshopcr/src/models/pet.dart';
//import 'package:lamanda_petshopcr/src/models/pet_list.dart';
import 'package:lamanda_petshopcr/src/models/userProfile.dart';

class HotelAppointment{

  String? appointmentId;
  DateTime? startDate;
  DateTime? endDate;
  UserProfile? client; 
  String? personPicksUp;
  //List<Pet> petList;
  String? race;
  int? age;
  bool? vaccine;
  DateTime? lastdeworming;
  DateTime? pestProtection;
  bool? sociable;
  bool? castrated;
  String? addres;
  bool? transfer;
  bool? isConfirmed;

    HotelAppointment({
    this.age,
    this.endDate,
    this.personPicksUp,
    this.addres,
    this.startDate,
    this.client,
    this.appointmentId,
    this.castrated,
    this.isConfirmed,
    this.sociable,
    this.vaccine,
    this.lastdeworming,
    this.pestProtection,
    this.race,
    this.transfer,
    //this.petList,
  });

  HotelAppointment.fromJson(Map<String, dynamic> json){
    
      //PetList getPetList = new PetList.fromJsonList(json['petList']);
      this.age = json['age'];
      this.endDate = json['departureDate'];
      this.personPicksUp = json['departureUser'];
      this.addres = json['direction'];
      this.startDate = json['entryDate'];
      this.client = json['entryUser'];
      this.appointmentId =json['id'];
      this.castrated =json['isCastrated'];
      this.isConfirmed = json['isConfirmed'];
      this.sociable = json['isSociable'];
      this.vaccine =json['isVaccinationUpDate'];
      this.lastdeworming = json['lastDeworing'];
      this.pestProtection =json['lastProtectionFleas'];
      this.race =json['race'];
      this.transfer = json['transfer'];
      //this.petList = getPetList.getPetList();
  }
  
  Map<String, dynamic> toJson(){
    return {
      'age': this.age,
      'departureDate': this.endDate,
      'departureUser': this.personPicksUp,
      'direction': this.addres,
      'entryDate': this.startDate,
      'entryUser': this.client!.toJson(),
      'id': this.appointmentId,
      'isCastrated':this.castrated,
      'isConfirmed': this.isConfirmed,
      'isSociable': this.sociable,
      'isVaccinationUpDate': this.vaccine,
      'lastDeworing': this.lastdeworming,
      'lastProtectionFleas': this.pestProtection,
      'race': this.race,
      'transfer': this.transfer,
      //'petList': this.petList,
    };
  }

}