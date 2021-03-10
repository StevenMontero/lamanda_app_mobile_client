part of 'kinder_cubit.dart';

class KinderState extends Equatable {
  const KinderState({
    this.age = 1,
    this.date,
    this.entryHour,
    this.departureHour,
    this.race = 'Labrador',
    this.userDeliver,
    this.userPickup = '',
    this.direccion = '',
    this.isVaccinationUpDate = false,
    this.isCastrated = false,
    this.isSociable = false,
    this.lastDeworming,
    this.lastProtectionFleas,
    this.transporte = false,
    this.status,
  });
  final DateTime? date;
  final DateTime? entryHour;
  final DateTime? departureHour;
  final FormzStatus? status;
  final String race;
  final int age;
  final UserProfile? userDeliver;
  final String userPickup;
  final DateTime? lastDeworming;
  final DateTime? lastProtectionFleas;
  final bool transporte;
  final String direccion;
  final bool isVaccinationUpDate;
  final bool isCastrated;
  final bool isSociable;

  KinderState copyWith({
    DateTime? date,
    DateTime? entryHour,
    DateTime? departureHour,
    String? race,
    int? age,
    UserProfile? userDeliver,
    String? userPickup,
    DateTime? lastDeworming,
    DateTime? lastProtectionFleas,
    bool? transporte,
    String? direccion,
    bool? isVaccinationUpDate,
    bool? isCastrated,
    bool? isSociable,
    FormzStatus? status,

  }) {
    return KinderState(
        date: date ?? this.date,
        entryHour: entryHour ?? this.entryHour,
        departureHour: departureHour ?? this.departureHour,
        race: race ?? this.race,
        age: age ?? this.age,
        userDeliver: userDeliver ?? this.userDeliver,
        userPickup: userPickup ?? this.userPickup,
        lastDeworming: lastDeworming ?? this.lastDeworming,
        lastProtectionFleas: lastProtectionFleas ?? this.lastProtectionFleas,
        transporte: transporte ?? this.transporte,
        direccion: direccion ?? this.direccion,
        isCastrated: isCastrated ?? this.isCastrated,
        isSociable: isSociable ?? this.isSociable,
        status: status ?? this.status,
        isVaccinationUpDate: isVaccinationUpDate ?? this.isVaccinationUpDate);
  }

  @override
  List<Object?> get props => [
        entryHour,
        departureHour,
        race,
        age,
        userDeliver,
        userPickup,
        lastDeworming,
        lastProtectionFleas,
        transporte,
        direccion,
        isCastrated,
        isSociable,
        isVaccinationUpDate,
        status
      ];
}
