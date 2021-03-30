part of 'hotel_cubit.dart';

class HotelState extends Equatable {
  const HotelState({
    this.pet,
    this.entryDate = const DateForm.pure(),
    this.departureDate= const DateForm.pure(),
    this.userDeliver,
    this.userPickup = const UserName.pure(),
    this.direccion = const AddrresForm.pure(),
    this.isDeworming = false,
    this.lastDeworming = const DateForm.pure(),
    this.lastProtectionFleas = const DateForm.pure(),
    this.isProtectionFleas = false,
    this.transporte = false,
    this.ispickUpSomeoneElse = false,
    this.status = FormzStatus.pure,
  });

  final DateForm entryDate;
  final DateForm departureDate;
  final FormzStatus? status;
  final UserProfile? userDeliver;
  final UserName userPickup;
  final DateForm lastDeworming;
  final DateForm lastProtectionFleas;
  final AddrresForm direccion;
  final bool transporte;
  final bool ispickUpSomeoneElse;
  final bool isDeworming;
  final bool isProtectionFleas;
  final Pet? pet;

  HotelState copyWith({
    DateForm? entryDate,
    DateForm? departureDate,
    UserProfile? userDeliver,
    UserName? userPickup,
    DateForm? lastDeworming,
    DateForm? lastProtectionFleas,
    AddrresForm? direccion,
    bool? transporte,
    bool? isProtectionFleas,
    bool? ispickUpSomeoneElse,
    bool? isDeworming,
    Pet? pet,
    FormzStatus? status,
  }) {
    return HotelState(
      entryDate: entryDate ?? this.entryDate,
      departureDate: departureDate ?? this.departureDate,
      status: status ?? this.status,
      userDeliver: userDeliver ?? this.userDeliver,
      userPickup: userPickup ?? this.userPickup,
      lastDeworming: lastDeworming ?? this.lastDeworming,
      lastProtectionFleas: lastProtectionFleas ?? this.lastProtectionFleas,
      transporte: transporte ?? this.transporte,
      direccion: direccion ?? this.direccion,
      pet: pet ?? this.pet,
      isDeworming: isDeworming ?? this.isDeworming,
      isProtectionFleas: isProtectionFleas ?? this.isProtectionFleas,
      ispickUpSomeoneElse: ispickUpSomeoneElse ?? this.ispickUpSomeoneElse,
    );
  }

  @override
  List<Object?> get props => [
        entryDate,
        departureDate,
        status,
        userDeliver,
        userPickup,
        lastDeworming,
        lastProtectionFleas,
        transporte,
        direccion,
        isProtectionFleas,
        ispickUpSomeoneElse,
        isDeworming,
        pet,
      ];
}
