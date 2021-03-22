part of 'infoform_cubit.dart';

class InfoformState extends Equatable {
  const InfoformState(
      {this.transfer = false,
      this.description = '',
      this.status,
      this.address = const AddrresForm.pure()});
  final bool transfer;
  final String description;
  final FormzStatus? status;
  final AddrresForm address;

  InfoformState copyWith({
    String? description,
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
