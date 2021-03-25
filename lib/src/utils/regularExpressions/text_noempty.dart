import 'package:formz/formz.dart';

enum TextNoEmptyValidationError { invalid }

class Text_NoEmpty extends FormzInput<String, TextNoEmptyValidationError> {
  const Text_NoEmpty.pure() : super.pure('');
  const Text_NoEmpty.dirty([String value = '']) : super.dirty(value);

  @override
  TextNoEmptyValidationError? validator(String? value) {
    return value != null && value.isNotEmpty
        ? null
        : TextNoEmptyValidationError.invalid;
  }
}