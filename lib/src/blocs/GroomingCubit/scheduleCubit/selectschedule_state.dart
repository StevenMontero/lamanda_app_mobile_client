part of 'selectschedule_cubit.dart';

class SelectscheduleState extends Equatable {
  const SelectscheduleState(
      {this.status,
      this.hourRerservation,
      required this.date,
      this.index = 0,
      this.schedule = const []});
  final DateTime? hourRerservation;
  final DateTime date;
  final int? index;
  final List<DateTime> schedule;
  final FormzStatus? status;

  SelectscheduleState copyWith({
    DateTime? hourRerservation,
    DateTime? date,
    List<DateTime>? schedule,
    int? index,
    FormzStatus? status,
  }) {
    return SelectscheduleState(
        hourRerservation: hourRerservation ?? this.hourRerservation,
        schedule: schedule ?? this.schedule,
        date: date ?? this.date,
        index: index ?? this.index,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [
        hourRerservation,
        date,
        schedule,
        index,
      ];
}
