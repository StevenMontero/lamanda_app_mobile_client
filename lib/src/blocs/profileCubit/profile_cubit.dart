import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:equatable/equatable.dart';
import 'package:lamanda_petshopcr/src/models/userProfile.dart';
import 'package:lamanda_petshopcr/src/repository/user_repository.dart';
import 'package:lamanda_petshopcr/src/utils/regularExpressions/regular_expressions_models.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.userRepository) : super(ProfileState());
  final UserRepository userRepository;
  UserProfile? userProfile;

  void fillInitialDataUser(UserProfile user) async {
    emit(state.copyWith(
        userName: UserName.dirty(user.userName!),
        lastName: ValidatorText.dirty(user.lastName!),
        addres: AddrresForm.dirty(user.address!),
        email: Email.dirty(user.email!),
        phone: NumberPhone.dirty(user.phone!),
        photoUrl: user.photoUri,
        userID: user.id));
  }

  void userNameChanged(String value) {
    final userName = UserName.dirty(value);
    emit(state.copyWith(
      userName: userName,
      status: Formz.validate(
          [userName, state.lastName, state.addres, state.email, state.phone]),
    ));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate(
          [state.userName, state.lastName, state.addres, email, state.phone]),
    ));
  }

  void photoUrlChanged(String photoUrl) {
    emit(state.copyWith(photoUrl: photoUrl));
  }

  void lastNameChanged(String value) {
    final lastName = ValidatorText.dirty(value);
    emit(state.copyWith(
      lastName: lastName,
      status: Formz.validate(
          [state.userName, lastName, state.addres, state.email, state.phone]),
    ));
  }

  void addresChanged(String value) {
    final addres = AddrresForm.dirty(value);
    emit(state.copyWith(
      addres: addres,
      status: Formz.validate(
          [state.userName, state.lastName, addres, state.email, state.phone]),
    ));
  }

  void phoneChanged(String value) {
    final phone = NumberPhone.dirty(value);
    emit(state.copyWith(
      phone: phone,
      status: Formz.validate(
          [state.userName, state.lastName, state.addres, state.email, phone]),
    ));
  }

  Future<void> editUserForm(String userID, String photoUrl) async {
    emit(state.copyWith(status: FormzStatus.submissionSuccess));
    try {
      userProfile = new UserProfile(
        id: userID,
        userName: state.userName.value,
        email: state.email.value,
        photoUri: photoUrl,
        lastName: state.lastName.value,
        address: state.addres.value,
        phone: state.phone.value,
      );
      userRepository.updateUser(userProfile!);
    } catch (error) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<UserProfile?> getUser(String? idUser) async {
    userProfile = await userRepository.getUserProfile(idUser);
    if (userProfile != null) {
      return userProfile;
    }
    return null;
  }
}
