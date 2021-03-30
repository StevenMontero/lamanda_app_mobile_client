part of 'selectschedulevet_cubit.dart';

class SelectscheduleVetState extends Equatable {
  const SelectscheduleVetState(
      {this.status,
      required this.hourRerservation,
      required this.date,
      this.index = 0,
      this.schedule = const []});
  final DateTime hourRerservation;
  final DateTime date;
  final int? index;
  final List<DateTime> schedule;
  final FormzStatus? status;

  SelectscheduleVetState copyWith({
    DateTime? hourRerservation,
    DateTime? date,
    List<DateTime>? schedule,
    int? index,
    FormzStatus? status,
  }) {
    return SelectscheduleVetState(
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
