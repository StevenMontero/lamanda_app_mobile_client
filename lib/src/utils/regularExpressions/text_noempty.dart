import 'package:formz/formz.dart';

enum TextNumbersValidationError { invalid }

class TextNoEmpty extends FormzInput<String?, TextNumbersValidationError> {
  const TextNoEmpty.pure() : super.pure(null);
  const TextNoEmpty.dirty([String value = '']) : super.dirty(value);

  @override
  TextNumbersValidationError? validator(String? value) {
    return value!.isEmpty ? null : TextNumbersValidationError.invalid;
  }
}
