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
          Formz.validate([email, state.password, state.userName, state.phone]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status:
          Formz.validate([state.email, password, state.userName, state.phone]),
    ));
  }

  //valida el campo de texto del nombre de usuario.
  void userNameChanged(String value) {
    final userName = UserName.dirty(value);
    emit(state.copyWith(
      userName: userName,
      status:
          Formz.validate([state.email, state.password, userName, state.phone]),
    ));
  }

  //validad el campo de texto del telefono
  void phoneChanged(String value) {
    final phone = NumberPhone.dirty(value);
    emit(state.copyWith(
      phone: phone,
      status:
          Formz.validate([state.email, state.password, state.userName, phone]),
    ));
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      await _authenticationRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );
      repository.addNewUser(new UserProfile(
          userName: state.userName.value,
          email: auth.currentUser!.email,
          phone: state.phone.value,
          id: auth.currentUser!.uid));

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignUpFailure catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, message: e.getErrorMessage()));
    }
  }
}
