part of 'consumed_medication_bloc.dart';

@immutable
sealed class ConsumedMedicationEvent {}

final class GetAllConsumedMedications extends ConsumedMedicationEvent {
  String Name;
  GetAllConsumedMedications({required this.Name});
}

final class GetAllMorning extends ConsumedMedicationEvent {}

final class GetAllAfternoon extends ConsumedMedicationEvent {}

final class GetAllEvening extends ConsumedMedicationEvent {}

final class GetConsumedMedication extends ConsumedMedicationEvent {}

final class PostMedication extends ConsumedMedicationEvent {
  DrugModel drug;
  ConsumedMedicationModel medication;
  PostMedication({required this.drug, required this.medication});
}
