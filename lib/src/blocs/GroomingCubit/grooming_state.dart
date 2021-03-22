part of 'grooming_cubit.dart';

class GroomingFormState extends Equatable {
  const GroomingFormState(
      {this.transfer = false,
      required this.currentStep,
      this.address = const AddrresForm.pure(),
      this.description = '',
      this.status});

  final bool transfer;
  final String description;
  final FormzStatus? status;
  final AddrresForm address;
  final int currentStep;

  GroomingFormState copyWith({
    String? description,
    bool? transfer,
    AddrresForm? address,
    FormzStatus? status,
    int? currentStep,
  }) {
    return GroomingFormState(
        description: description ?? this.description,
        address: address ?? this.address,
        transfer: transfer ?? this.transfer,
        currentStep: currentStep ?? this.currentStep,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [
        description,
        address,
        status,
        transfer,
        currentStep,
      ];
}
