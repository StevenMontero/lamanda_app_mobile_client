import 'package:formz/formz.dart';

enum UserNameValidationError { invalid }

class UserName extends FormzInput<String, UserNameValidationError > {
  const UserName.pure() : super.pure('');
  const UserName.dirty([String value = '']) : super.dirty(value);

  static final _userNameRegExp =
      RegExp(r'^[a-zñ A-ZÑ0-9]+$');

  @override
  UserNameValidationError? validator(String? value) {
    return _userNameRegExp.hasMatch(value!)
        ? null
        : UserNameValidationError.invalid;
  }
}