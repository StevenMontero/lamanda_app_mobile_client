part of 'grooming_cubit.dart';

class GroomingFormState extends Equatable {
  const GroomingFormState({
    required this.currentStep,
  });

  final int currentStep;

  GroomingFormState copyWith({
    int? currentStep,
  }) {
    return GroomingFormState(currentStep: currentStep ?? this.currentStep);
  }

  @override
  List<Object?> get props => [
        currentStep,
      ];
}
