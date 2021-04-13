import 'package:formz/formz.dart';

enum TextNoEmptyValidationError { invalid }

class TextNotEmpty extends FormzInput<String, TextNoEmptyValidationError> {
  const TextNotEmpty.pure() : super.pure('');
  const TextNotEmpty.dirty([String value = '']) : super.dirty(value);

  @override
  TextNoEmptyValidationError? validator(String? value) {
    return value != null && value.isNotEmpty
        ? null
        : TextNoEmptyValidationError.invalid;
  }
}