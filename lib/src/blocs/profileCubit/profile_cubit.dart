import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:equatable/equatable.dart';
import 'package:lamanda_petshopcr/src/models/userProfile.dart';
import 'package:lamanda_petshopcr/src/repository/user_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.userRepository) : super(ProfileState());
  final UserRepository userRepository;
  UserProfile? userProfile;

  void fillInitialDataUser(UserProfile user) async {
    //final user = await userRepository.getUserProfile(id);
    emit(state.copyWith(
        userName: user.userName,
        lastName: user.lastName,
        addres: user.address,
        email: user.email,
        phone: user.phone,
        photoUrl: user.photoUri,
        userID: user.id));
  }

  void userNameChanged(String username) {
    emit(state.copyWith(userName: username));
  }

  void emailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void photoUrlChanged(String photoUrl) {
    emit(state.copyWith(photoUrl: photoUrl));
  }

  void lastNameChanged(String lastName) {
    emit(state.copyWith(lastName: lastName));
  }

  void addresChanged(String addres) {
    emit(state.copyWith(addres: addres));
  }

  void phoneChanged(String phone) {
    emit(state.copyWith(phone: phone));
  }

  Future<void> editUserForm(String userID, String photoUrl) async {
    emit(state.copyWith(status: FormzStatus.submissionSuccess));
    try {
      userProfile = new UserProfile(
        id: userID,
        userName: state.userName,
        email: state.email,
        photoUri: photoUrl,
        lastName: state.lastName,
        address: state.addres,
        phone: state.phone,
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
