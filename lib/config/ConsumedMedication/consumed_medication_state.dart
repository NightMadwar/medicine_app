part of 'consumed_medication_bloc.dart';

@immutable
sealed class ConsumedMedicationState {}

final class ConsumedMedicationInitial extends ConsumedMedicationState {}

final class ConsumedMedicationLoading extends ConsumedMedicationState {}

final class ConsumedMedicationSuccess extends ConsumedMedicationState {
  List<ConsumedMedicationModel> consumedMedications;
  ConsumedMedicationSuccess({required this.consumedMedications});
}

final class ConsumedMedicationError extends ConsumedMedicationState {}
