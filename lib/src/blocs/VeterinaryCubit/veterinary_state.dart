part of 'veterinary_cubit.dart';

class VeterinaryFormState extends Equatable {
  const VeterinaryFormState({
    required this.currentStep,
  });
  final int currentStep;

  VeterinaryFormState copyWith({int? currentStep}) {
    return VeterinaryFormState(currentStep: currentStep ?? this.currentStep);
  }

  @override
  List<Object?> get props => [
        currentStep,
      ];
}
