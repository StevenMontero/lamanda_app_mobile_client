import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:lamanda_petshopcr/src/models/userProfile.dart';
import 'package:lamanda_petshopcr/src/repository/user_repository.dart';
import 'package:lamanda_petshopcr/src/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository _authenticationRepository;
  LoginCubit(this._authenticationRepository)
      : assert(_authenticationRepository != null),
        super(const LoginState());

  final UserRepository _userRepository = new UserRepository();
  FirebaseAuth auth = FirebaseAuth.instance;
  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.password]),
    ));
  }

   void passwordChanged(String value) {
     final password = Password.dirty(value);
     emit(state.copyWith(
       password: password,
       status: Formz.validate([state.email, password]),
     ));
   }

  Future<void> logInWithCredentials() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
     
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.logInWithGoogle();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
      
      _userRepository.addNewUser(new UserProfile(
          userName: auth.currentUser!.displayName,
          email: auth.currentUser!.email,
          photoUri: auth.currentUser!.photoURL,
          id: auth.currentUser!.uid));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    } on NoSuchMethodError {
      emit(state.copyWith(status: FormzStatus.pure));
    }
  }

  Future<void> logInWithFacebook() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.logInWithFacebook();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
      _userRepository.addNewUser(new UserProfile(
          userName: auth.currentUser!.displayName,
          email: auth.currentUser!.email,
          photoUri: auth.currentUser!.photoURL,
          id: auth.currentUser!.uid));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    } on NoSuchMethodError {
      emit(state.copyWith(status: FormzStatus.pure));
    }
  }
}
