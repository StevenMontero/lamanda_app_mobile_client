import 'package:formz/formz.dart';

enum NumberValidationError { invalid }

class NumberPhone extends FormzInput<String, NumberValidationError > {
  const NumberPhone.pure() : super.pure('');
  const NumberPhone.dirty([String value = '']) : super.dirty(value);

  static final _numberRegExp =
      RegExp(r'^[0-9]{8,}$');

  @override
  NumberValidationError? validator(String? value) {
    return _numberRegExp.hasMatch(value!)
        ? null
        : NumberValidationError.invalid;
  }
}