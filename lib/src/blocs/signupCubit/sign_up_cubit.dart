import 'package:authentication_repository/authentication_repository.dart';
import 'package:formz/formz.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lamanda_petshopcr/src/utils/regularExpressions/numberPhone.dart';
import 'package:lamanda_petshopcr/src/utils/regularExpressions/userName.dart';
import 'package:lamanda_petshopcr/src/utils/utils.dart';
import 'package:lamanda_petshopcr/src/repository/user_repository.dart';
import 'package:lamanda_petshopcr/src/models/userProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authenticationRepository)
      : super(const SignUpState());

  final AuthenticationRepository _authenticationRepository;
  final UserRepository repository = new UserRepository();
  FirebaseAuth auth = FirebaseAuth.instance;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status:
          Formz.validate([email, state.password]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status:
          Formz.validate([state.email, password]),
    ));
  }

  //valida el campo de texto del nombre de usuario.

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      await _authenticationRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );

      repository.addNewUser(new UserProfile(
          email: auth.currentUser!.email,
          id: auth.currentUser!.uid));

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignUpFailure catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, message: e.getErrorMessage()));
    }
  }
}
