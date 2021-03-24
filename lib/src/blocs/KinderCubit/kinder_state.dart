part of 'kinder_cubit.dart';

class KinderState extends Equatable {
  const KinderState({
    this.userDeliver,
    this.userPickup = const UserName.pure(),
    required this.date,
    this.entryHour = const HourCheckIn.pure(),
    this.departureHour = const HourCheckOut.pure(),
    this.direccion = const AddrresForm.pure(),
    this.isDeworming = false,
    this.lastDeworming = const DateForm.pure(),
    this.lastProtectionFleas = const DateForm.pure(),
    this.isProtectionFleas = false,
    this.transporte = false,
    this.ispickUpSomeoneElse = false,
    this.status = FormzStatus.pure,
  });
  final DateTime date;
  final HourCheckIn entryHour;
  final HourCheckOut departureHour;
  final FormzStatus status;
  final UserProfile? userDeliver;
  final UserName userPickup;
  final DateForm lastDeworming;
  final DateForm lastProtectionFleas;
  final bool transporte;
  final AddrresForm direccion;
  final bool ispickUpSomeoneElse;
  final bool isDeworming;
  final bool isProtectionFleas;

  KinderState copyWith({
    DateTime? date,
    HourCheckIn? entryHour,
    HourCheckOut? departureHour,
    UserProfile? userDeliver,
    UserName? userPickup,
    DateForm? lastDeworming,
    DateForm? lastProtectionFleas,
    AddrresForm? direccion,
    bool? transporte,
    bool? isProtectionFleas,
    bool? ispickUpSomeoneElse,
    bool? isDeworming,
    FormzStatus? status,
  }) {
    return KinderState(
      date: date ?? this.date,
      entryHour: entryHour ?? this.entryHour,
      departureHour: departureHour ?? this.departureHour,
      userDeliver: userDeliver ?? this.userDeliver,
      userPickup: userPickup ?? this.userPickup,
      lastDeworming: lastDeworming ?? this.lastDeworming,
      lastProtectionFleas: lastProtectionFleas ?? this.lastProtectionFleas,
      transporte: transporte ?? this.transporte,
      direccion: direccion ?? this.direccion,
      status: status ?? this.status,
      isDeworming: isDeworming ?? this.isDeworming,
      isProtectionFleas: isProtectionFleas ?? this.isProtectionFleas,
      ispickUpSomeoneElse: ispickUpSomeoneElse ?? this.ispickUpSomeoneElse,
    );
  }

  @override
  List<Object?> get props => [
        entryHour,
        date,
        departureHour,
        userDeliver,
        userPickup,
        lastDeworming,
        lastProtectionFleas,
        transporte,
        direccion,
        isProtectionFleas,
        ispickUpSomeoneElse,
        isDeworming,
        status
      ];
}
