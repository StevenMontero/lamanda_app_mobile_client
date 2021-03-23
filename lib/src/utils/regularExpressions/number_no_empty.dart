import 'package:formz/formz.dart';

enum NumberNoEmptyValidationError { invalid }

class NumberNoEmpty extends FormzInput<String, NumberNoEmptyValidationError > {
  const NumberNoEmpty.pure() : super.pure('');
  const NumberNoEmpty.dirty([String value = '']) : super.dirty(value);

  static final _numberRegExp =
      RegExp(r'^[0-9]+(.[0-9]+)?$');

  @override
  NumberNoEmptyValidationError? validator(String? value) {
    return _numberRegExp.hasMatch(value!)
        ? null
        : NumberNoEmptyValidationError.invalid;
  }
}