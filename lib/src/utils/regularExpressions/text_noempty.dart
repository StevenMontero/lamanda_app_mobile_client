import 'package:formz/formz.dart';

enum TextNoEmptyValidationError { invalid }

class TextNoEmpty extends FormzInput<String, TextNoEmptyValidationError> {
  const TextNoEmpty.pure() : super.pure('');
  const TextNoEmpty.dirty([String value = '']) : super.dirty(value);

  @override
  TextNoEmptyValidationError? validator(String? value) {
    return value != null && value.isNotEmpty
        ? null
        : TextNoEmptyValidationError.invalid;
  }
}
