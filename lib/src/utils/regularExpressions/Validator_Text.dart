import 'package:formz/formz.dart';

enum TextValidationError { invalid }

class ValidatorText extends FormzInput<String?, TextValidationError> {
  const ValidatorText.pure() : super.pure('');
  const ValidatorText.dirty([String value = '']) : super.dirty(value);
  static final _userNameRegExp = RegExp(r'^[a-zñ A-ZÑ0-9]+$');

  @override
  TextValidationError? validator(String? value) {
    return _userNameRegExp.hasMatch(value!) ? null : TextValidationError.invalid;
  }
}