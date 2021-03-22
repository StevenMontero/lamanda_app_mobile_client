import 'package:formz/formz.dart';

enum HourCheckInValidationError { invalid }

class HourCheckIn
    extends FormzInput<List<DateTime?>?, HourCheckInValidationError> {
  const HourCheckIn.pure()
      : super.pure(
          null,
        );
  const HourCheckIn.dirty([List<DateTime?>? value]) : super.dirty(value);

  @override
  HourCheckInValidationError? validator(List<DateTime?>? value) {
    /* value[0] = Fecha seleccionada en el calendario
       value[1] = Hora seleccionada 
     */
    final openHour = 10;
    final clouseHour = 17;
    final clouseMinute = 30;

    if (value != null &&
        value.isEmpty != true &&
        value[0] != null &&
        value[1] != null &&
        value[1]!.hour >= openHour &&
        value[1]!.hour <= clouseHour) {
      if (value[0]!.month == DateTime.now().month &&
          value[0]!.day == DateTime.now().day) {
        if (DateTime.now().hour == value[1]!.hour &&
            DateTime.now().minute <= value[1]!.minute) {
          return null;
        } else if (DateTime.now().hour < value[1]!.hour) {
          if (value[1]!.hour == clouseHour && value[1]!.minute < clouseMinute) {
            return null;
          } else if (value[1]!.hour < clouseHour) {
            return null;
          }
          return HourCheckInValidationError.invalid;
        } else {
          return HourCheckInValidationError.invalid;
        }
      } else {
        if (value[1]!.hour == clouseHour && value[1]!.minute < clouseMinute) {
          return null;
        } else if (value[1]!.hour < clouseHour) {
          return null;
        }
        return HourCheckInValidationError.invalid;
      }
    } else {
      return HourCheckInValidationError.invalid;
    }
  }
}
