part of 'infoformvet_cubit.dart';

class InfoformVetState extends Equatable {
  const InfoformVetState(
      {this.transfer = false,
      this.description = const Text_NoEmpty.pure(),
      this.status = FormzStatus.pure,
      this.pet,
      required this.service,
      this.address = const AddrresForm.pure()});
  final bool transfer;
  final Text_NoEmpty description;
  final FormzStatus status;
  final AddrresForm address;
  final Pet? pet;
  final Service service;

  InfoformVetState copyWith(
      {Text_NoEmpty? description,
      bool? transfer,
      AddrresForm? address,
      FormzStatus? status,
      Service? service,
      Pet? pet}) {
    return InfoformVetState(
        description: description ?? this.description,
        address: address ?? this.address,
        transfer: transfer ?? this.transfer,
        pet: pet ?? this.pet,
        service: service ?? this.service,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props =>
      [transfer, description, status, address, pet, service];
}
