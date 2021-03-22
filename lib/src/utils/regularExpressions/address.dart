import 'package:formz/formz.dart';

enum AddressValidationError { invalid }

class AddrresForm extends FormzInput<String, AddressValidationError > {
  const AddrresForm.pure() : super.pure('');
  const AddrresForm.dirty([String value = '']) : super.dirty(value);

  static final _userNameRegExp =
      RegExp(r'^[a-zñ A-ZÑ0-9]+$');

  @override
  AddressValidationError? validator(String? value) {
    return _userNameRegExp.hasMatch(value!)
        ? null
        : AddressValidationError.invalid;
  }
}