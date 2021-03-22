import 'package:formz/formz.dart';

enum DateValidationError { invalid }

class DateForm extends FormzInput<DateTime?, DateValidationError> {
  const DateForm.pure()
      : super.pure(
          null,
        );
  const DateForm.dirty([DateTime? value]) : super.dirty(value);

  @override
  DateValidationError? validator(DateTime? value) {
      return value != null ? null : DateValidationError.invalid;
  }
}