import 'package:formz/formz.dart';

enum HourCheckOutValidationError { invalid }

class HourCheckOut
    extends FormzInput<List<DateTime?>?, HourCheckOutValidationError> {
  const HourCheckOut.pure()
      : super.pure(
          null,
        );
  const HourCheckOut.dirty([List<DateTime?>? value]) : super.dirty(value);

  @override
  HourCheckOutValidationError? validator(List<DateTime?>? value) {
    /* value[0] = Hora de entrada
       value[1] = Hora seleccionada 
     */

    final clouseHour = 17;
    final clouseMinute = 30;

    if (value != null &&
        value.isEmpty != true &&
        value[0] != null &&
        value[1] != null &&
        value[1]!.hour <= clouseHour) {
      if (value[0]!.hour == value[1]!.hour &&
          value[0]!.minute < value[1]!.minute&& value[0]!.hour != clouseHour) {
        return null;
      } else if(value[0]!.hour == value[1]!.hour && value[1]!.hour == clouseHour && value[1]!.minute <= clouseMinute){
          return null;
      }else if (value[0]!.hour < value[1]!.hour) {
        if (value[1]!.hour < clouseHour) {
          return null;
        } else if (value[1]!.hour == clouseHour &&
            value[1]!.minute <= clouseMinute) {
          return null;
        } else {
          return HourCheckOutValidationError.invalid;
        }
      } else {
        return HourCheckOutValidationError.invalid;
      }
    } else {
      return HourCheckOutValidationError.invalid;
    }
  }
}
