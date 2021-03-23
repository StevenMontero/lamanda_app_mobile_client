import 'package:formz/formz.dart';

enum TextValidationError { invalid }

class TextNoEmpty extends FormzInput<String?, TextValidationError> {
  const TextNoEmpty.pure() : super.pure('');
  const TextNoEmpty.dirty([String value = '']) : super.dirty(value);

  static final _userNameRegExp = RegExp(r'^[a-zñ A-ZÑ0-9]+$');

  @override
  TextValidationError? validator(String? value) {
    return _userNameRegExp.hasMatch(value!) ? null : TextValidationError.invalid;
  }
}