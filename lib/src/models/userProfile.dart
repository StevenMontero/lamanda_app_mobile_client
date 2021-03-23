
class UserProfile {
  String? id;
  String? userName;
  String? email;
  String? photoUri;
  String? lastName;
  String? address;
  String? phone; 

  UserProfile({
    this.id,
    this.userName,
    this.email,
    this.photoUri,
    this.lastName,
    this.address,
    this.phone
  });

  UserProfile.fromJson(Map<String, dynamic> json){
    
      this.id = json['id'];
      this.userName = json['userName'];
      this.email = json['email'];
      this.photoUri = json['photoUri'];
      this.lastName = json['lastName'];
      this.address = json['address'];
      this.phone = json['phone'];
  }
  
  Map<String, dynamic> toJson(){
    return {
      'id': this.id,
      'userName': this.userName,
      'email': this.email,
      'photoUri': this.photoUri,
      'lastName': this.lastName,
      'address': this.address,
      'phone': this.phone
    };
  }

}