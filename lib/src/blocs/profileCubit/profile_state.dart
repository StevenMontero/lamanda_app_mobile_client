part of 'profile_cubit.dart';

class ProfileState extends Equatable {
ProfileState({
    this.userID,
    this.userName,
    this.email,
    this.photoUrl,
    this.lastName,
    this.addres,
    this.phone,
    this.status
  });

   ProfileState.fromObject(UserProfile user){
    this.userID = user.id;
    this.userName = user.userName;
    this.email= user.email;
    this.photoUrl= user.photoUri;
    this.lastName= user.lastName;
    this.addres= user.address;
    this.phone= user.phone;
    this.status = null;
  }

   String? userID;
   String? userName;
   String? email;
   String? photoUrl;
   String? lastName;
   String? addres; 
   String? phone;
   FormzStatus? status;
  
  ProfileState copyWith({
   String? userID,
   String? userName,
   String? email,
   String? photoUrl,
   String? lastName,
   String? addres,
   String? phone,
  FormzStatus? status,
  }) {
    return ProfileState(
      userID: userID ?? this.userName,
        userName: userName ?? this.userName,
        email: email ?? this.email,
        photoUrl: photoUrl ?? this.photoUrl,
        lastName: lastName ?? this.lastName,
        addres: addres ?? this.addres,
        phone: phone ?? this.phone,
        status: status ?? this.status,
        );
  }

  @override
  List<Object?> get props => [
        userID,
        userName,
        email,
        photoUrl,
        lastName,
        addres,
        phone,
        status,  
      ];
}