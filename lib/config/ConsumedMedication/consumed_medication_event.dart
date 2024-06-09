part of 'consumed_medication_bloc.dart';

@immutable
abstract class ConsumedMedicationEvent {}

class PostMedication extends ConsumedMedicationEvent {
  final DrugModel drug;
  final ConsumedMedicationModel medication;

  PostMedication(this.drug, this.medication);
}

class UpdateMedication extends ConsumedMedicationEvent {
  final int id;
  final DrugModel drug;
  final ConsumedMedicationModel medication;

  UpdateMedication(this.id, this.drug, this.medication);
}

class GetAllConsumedMedications extends ConsumedMedicationEvent {
  final String Name;

  GetAllConsumedMedications(this.Name);
}

class GetAllMorning extends ConsumedMedicationEvent {}

class GetAllAfternoon extends ConsumedMedicationEvent {}

class GetAllEvening extends ConsumedMedicationEvent {}
