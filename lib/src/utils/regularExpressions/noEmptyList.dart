import 'package:formz/formz.dart';

enum NoEmptyListValidationError { invalid }

class ListValidator
    extends FormzInput<List<dynamic>, NoEmptyListValidationError> {
  const ListValidator.pure() : super.pure(const []);
  const ListValidator.dirty([List<dynamic> value = const []])
      : super.dirty(value);

  @override
  NoEmptyListValidationError? validator(List? value) {
    return value != null && value.isEmpty
        ? NoEmptyListValidationError.invalid
        : null;
  }
}
