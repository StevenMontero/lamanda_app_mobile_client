part of 'infoform_cubit.dart';

class InfoformState extends Equatable {
  const InfoformState(
      {this.transfer = false,
      this.description = const Text_NoEmpty.pure() ,
      this.status =  FormzStatus.pure,
      this.address = const AddrresForm.pure()});
  final bool transfer;
  final Text_NoEmpty description;
  final FormzStatus status;
  final AddrresForm address;

  InfoformState copyWith({
    Text_NoEmpty? description,
    bool? transfer,
    AddrresForm? address,
    FormzStatus? status,
  }) {
    return InfoformState(
        description: description ?? this.description,
        address: address ?? this.address,
        transfer: transfer ?? this.transfer,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [transfer, description, status, address];
}
