part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationUserChanged extends AuthenticationEvent {
  final User user;
  const AuthenticationUserChanged(this.user);

  @override
  List<Object> get props => [user];
}
class AuthenticationUserUpdate extends AuthenticationEvent {
  final UserProfile userProfile;
  const AuthenticationUserUpdate(this.userProfile);

  @override
  List<Object> get props => [userProfile];
}

class AuthenticationPetUpdate extends AuthenticationEvent {
  final Pet pet;
  const AuthenticationPetUpdate(this.pet);

  @override
  List<Object> get props => [pet];
}

class AuthenticationAddPetUpdate extends AuthenticationEvent {
  final Pet pet;
  const AuthenticationAddPetUpdate(this.pet);

  @override
  List<Object> get props => [pet];
}

class AuthenticationPetDelete extends AuthenticationEvent {
  final Pet pet;
  const AuthenticationPetDelete(this.pet);

  @override
  List<Object> get props => [pet];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
