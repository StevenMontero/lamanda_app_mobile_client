class Pet{

  String? petId;
  String? userId;
  String? name;
  String? breed;
  int? age;
  String? fur;
  double? weight;
  bool? isVaccinationUpDate;
  bool? castrated;
  bool? sociable;
  String? photoUrl;
  String? kindPet;

  Pet({
    this.petId,
    this.userId,
    this.name,
    this.breed,
    this.age,
    this.fur,
    this.weight,
    this.isVaccinationUpDate,
    this.castrated,
    this.sociable,
    this.photoUrl,
    this.kindPet
  });

   Pet.fromJson(Map<String, dynamic> json, String petID){
    this.petId = petID;
    this.userId = json['userID'];
    this.name = json['petName'];
    this.breed = json['breed'];
    this.age = json['age'];
    this.fur = json['fur'];
    this.weight =  json['weight'].toDouble();
    this.isVaccinationUpDate = json['isVaccinationUpDate'];
    this.castrated = json['castrated'];
    this.sociable = json['sociable'];
    this.photoUrl = json['photoUrl'];
    this.kindPet = json['kindPet'];
  }

  Map<String, dynamic> toJson(){
    return {
      'petID': this.petId,
      'userID': this.userId,
      'petName': this.name,
      'breed': this.breed,
      'age': this.age,
      'fur': this.fur,
      'weight': this.weight,
      'isVaccinationUpDate': this.isVaccinationUpDate,
      'castrated': this.castrated,
      'sociable': this.sociable,
      'photoUrl': this.photoUrl,
      'kindPet': this.kindPet
    };
  }
}