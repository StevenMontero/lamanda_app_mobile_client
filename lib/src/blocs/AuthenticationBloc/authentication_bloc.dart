import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lamanda_petshopcr/src/models/pet.dart';
import 'package:lamanda_petshopcr/src/models/userProfile.dart';
import 'package:lamanda_petshopcr/src/repository/pet_repositorydb.dart';
import 'package:lamanda_petshopcr/src/repository/user_repository.dart';
import 'package:pedantic/pedantic.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  final PetRepository _petRepository = new PetRepository();
  final UserRepository _userProfileRepository = new UserRepository();
  StreamSubscription<User>? _userSubscription;

  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })   : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(AuthenticationUserChanged(user)),
    );
  }
  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationUserChanged) {
      var _userProfile = UserProfile();
      var _petList = <Pet>[];
      if (event.user.id != '') {
        _userProfile =
            await _userProfileRepository.getUserProfile(event.user.id) ??
                UserProfile();
        _petList = await _petRepository.getpetList(event.user.id);
      }
      yield _mapAuthenticationUserChangedToState(event, _userProfile, _petList);
    } else if (event is AuthenticationUserUpdate) {
      yield _mapAuthenticationUserProfileUpdateToState(
          event, state.user, state.petList);
    } else if (event is AuthenticationPetUpdate) {
      yield _mapAuthenticationPetUpdateToState(event);
    } else if (event is AuthenticationAddPetUpdate) {
      yield _mapAuthenticationAddPetToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      unawaited(_authenticationRepository.logOut());
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }

  AuthenticationState _mapAuthenticationUserChangedToState(
      AuthenticationUserChanged event,
      UserProfile userProfile,
      List<Pet> petList) {
    return event.user != User.empty
        ? AuthenticationState.authenticated(
            user: event.user, petList: petList, userProfile: userProfile)
        : const AuthenticationState.unauthenticated();
  }

  AuthenticationState _mapAuthenticationUserProfileUpdateToState(
      AuthenticationUserUpdate event, User user, List<Pet> petList) {
    return AuthenticationState.authenticated(
        user: user, petList: petList, userProfile: event.userProfile);
  }

  AuthenticationState _mapAuthenticationPetUpdateToState(
    AuthenticationPetUpdate event,
  ) {
    final listPet = List<Pet>.from(state.petList);
    listPet.removeWhere((element) => element.petId == event.pet.petId);
    listPet.add(event.pet);
    return AuthenticationState.authenticated(
        user: state.user, petList: listPet, userProfile: state.userProfile!);
  }

  AuthenticationState _mapAuthenticationAddPetToState(
    AuthenticationAddPetUpdate event,
  ) {
    final listPet = List<Pet>.from(state.petList);
    listPet.add(event.pet);
    return AuthenticationState.authenticated(
        user: state.user, petList: listPet, userProfile: state.userProfile!);
  }
}
