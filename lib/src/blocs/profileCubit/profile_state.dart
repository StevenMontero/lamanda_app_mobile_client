part of 'profile_cubit.dart';

class ProfileState extends Equatable {

  final String? userID;
  final UserName userName;
  final Email email;
  final String? photoUrl;
  final ValidatorText lastName;
  final AddrresForm addres; 
  final NumberPhone phone;
  final FormzStatus? status;

const ProfileState({
    this.userID,
    this.userName = const UserName.pure(),
    this.email = const Email.pure(),
    this.photoUrl,
    this.lastName = const ValidatorText.pure(),
    this.addres = const AddrresForm.pure(),
    this.phone = const NumberPhone.pure(),
    this.status
  });

  ProfileState copyWith({
   String? userID,
   UserName? userName,
   Email? email,
   String? photoUrl,
   ValidatorText? lastName,
   AddrresForm? addres,
   NumberPhone? phone,
  FormzStatus? status,
  }) {
    return ProfileState(
      userID: userID ?? this.userID,
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