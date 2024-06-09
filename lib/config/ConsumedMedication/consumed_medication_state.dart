part of 'consumed_medication_bloc.dart';

@immutable
abstract class ConsumedMedicationState {}

class ConsumedMedicationInitial extends ConsumedMedicationState {}

class ConsumedMedicationLoading extends ConsumedMedicationState {}

class ConsumedMedicationSuccess extends ConsumedMedicationState {
  final List<ConsumedMedicationModel> consumedMedications;
  ConsumedMedicationSuccess({required this.consumedMedications});
}

class ConsumedMedicationUpdateSuccess extends ConsumedMedicationState {
  final ConsumedMedicationModel updatedMedication;
  ConsumedMedicationUpdateSuccess({required this.updatedMedication});
}

class ConsumedMedicationError extends ConsumedMedicationState {
  final String message;
  ConsumedMedicationError({required this.message});
}
