part of 'authentication_bloc.dart';

enum AuthenticationStatus { authenticated, unauthenticated, unknown }

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final User user;
  final UserProfile? userProfile;
  final List<Pet> petList;
  const AuthenticationState._(
      {this.status = AuthenticationStatus.unknown,
      this.user = User.empty,
      this.petList = const [],
      this.userProfile});

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(
      {required User user,
      required UserProfile userProfile,
      required List<Pet> petList})
      : this._(
            status: AuthenticationStatus.authenticated,
            user: user,
            petList: petList,
            userProfile: userProfile);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object> get props => [status, user];
}
