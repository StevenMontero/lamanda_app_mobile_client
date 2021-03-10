part of 'grooming_cubit.dart';

class GroomingFormState extends Equatable {
  const GroomingFormState(
      {this.transfer,
      this.date,
      this.address,
      this.hourRerservation,
      this.typeFur = 'Liso',
      this.description = '',
      this.schedule,
      this.status});
  final DateTime? hourRerservation;
  final DateTime? date;
  final List<DateTime>? schedule;
  final String typeFur;
  final String description;
  final FormzStatus? status;
  final bool? transfer;
  final String? address;

  GroomingFormState copyWith({
    DateTime? hourRerservation,
    String? typeFur,
    DateTime? date,
    String? description,
    List<DateTime>? schedule,
    bool? transfer,
    String? address,
    FormzStatus? status,
  }) {
    return GroomingFormState(
        hourRerservation: hourRerservation ?? this.hourRerservation,
        typeFur: typeFur ?? this.typeFur,
        description: description ?? this.description,
        schedule: schedule ?? this.schedule,
        address: address ?? this.address,
        transfer: transfer ?? this.transfer,
        date: date ?? this.date,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [
        hourRerservation,
        typeFur,
        description,
        address,
        schedule,
        status,
        transfer,
        date
      ];
}
