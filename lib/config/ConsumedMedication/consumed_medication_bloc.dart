import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:medicine_app/Models/ConsumedMedicationModel.dart';
import 'package:medicine_app/Models/DrugModel.dart';
import 'package:medicine_app/Models/UserModel.dart';
import 'package:medicine_app/Service/ConsumedMedicationService.dart';
import 'package:meta/meta.dart';

part 'consumed_medication_event.dart';
part 'consumed_medication_state.dart';

class ConsumedMedicationBloc
    extends Bloc<ConsumedMedicationEvent, ConsumedMedicationState> {
  ConsumedMedicationBloc() : super(ConsumedMedicationInitial()) {
    on<PostMedication>((event, emit) async {
      emit(ConsumedMedicationLoading());
      try {
        Response temp = await ConsumedMedicationService()
            .postMedication(event.drug, event.medication);
        if (temp.statusCode == 201 && temp.data != null) {
          List<ConsumedMedicationModel> consumedMedications =
              List<ConsumedMedicationModel>.from(temp.data.map((item) {
            return ConsumedMedicationModel.fromMap(item);
          }));
          emit(ConsumedMedicationSuccess(
              consumedMedications: consumedMedications));
        } else {
          emit(ConsumedMedicationError(
              message: 'Failed to post medication: ${temp.statusMessage}'));
        }
      } catch (e) {
        emit(ConsumedMedicationError(message: e.toString()));
      }
    });
    on<UpdateMedication>((event, emit) async {
      emit(ConsumedMedicationLoading());
      try {
        Response response = await ConsumedMedicationService()
            .updateMedication(event.id, event.drug, event.medication);
        // print(response);
        if (response.statusCode == 200 && response.data != null) {
          emit(ConsumedMedicationUpdateSuccess(
              updatedMedication: response.data));
        } else {
          emit(ConsumedMedicationError(
              message:
                  'Failed to update medication: ${response.statusMessage}'));
        }
      } catch (e) {
        emit(ConsumedMedicationError(message: e.toString()));
      }
    });

    on<GetAllConsumedMedications>((event, emit) async {
      emit(ConsumedMedicationLoading());
      try {
        Response temp = await ConsumedMedicationService().search(event.Name);
        if (temp.statusCode == 200 && temp.data != null) {
          List<ConsumedMedicationModel> consumedMedications =
              List<ConsumedMedicationModel>.from(temp.data.map((item) {
            return ConsumedMedicationModel.fromMap(item);
          }));
          emit(ConsumedMedicationSuccess(
              consumedMedications: consumedMedications));
        } else {
          emit(ConsumedMedicationError(
              message: 'Failed to load medications: ${temp.statusMessage}'));
        }
      } catch (e) {
        emit(ConsumedMedicationError(message: e.toString()));
      }
    });

    on<GetAllMorning>((event, emit) async {
      emit(ConsumedMedicationLoading());
      try {
        Response temp = await ConsumedMedicationService().get2();
        if (temp.statusCode == 200 && temp.data != null) {
          List<ConsumedMedicationModel> consumedMedications =
              List<ConsumedMedicationModel>.from(temp.data.map((item) {
            return ConsumedMedicationModel.fromMap(item);
          }));
          emit(ConsumedMedicationSuccess(
              consumedMedications: consumedMedications));
        } else {
          emit(ConsumedMedicationError(
              message: 'Failed to load medications: ${temp.statusMessage}'));
        }
      } catch (e) {
        emit(ConsumedMedicationError(message: e.toString()));
      }
    });

    on<GetAllAfternoon>((event, emit) async {
      emit(ConsumedMedicationLoading());
      try {
        Response temp = await ConsumedMedicationService().get3();
        if (temp.statusCode == 200 && temp.data != null) {
          List<ConsumedMedicationModel> consumedMedications =
              List<ConsumedMedicationModel>.from(temp.data.map((item) {
            return ConsumedMedicationModel.fromMap(item);
          }));
          emit(ConsumedMedicationSuccess(
              consumedMedications: consumedMedications));
        } else {
          emit(ConsumedMedicationError(
              message: 'Failed to load medications: ${temp.statusMessage}'));
        }
      } catch (e) {
        emit(ConsumedMedicationError(message: e.toString()));
      }
    });

    on<GetAllEvening>((event, emit) async {
      emit(ConsumedMedicationLoading());
      try {
        Response temp = await ConsumedMedicationService().get4();
        if (temp.statusCode == 200 && temp.data != null) {
          List<ConsumedMedicationModel> consumedMedications =
              List<ConsumedMedicationModel>.from(temp.data.map((item) {
            return ConsumedMedicationModel.fromMap(item);
          }));
          emit(ConsumedMedicationSuccess(
              consumedMedications: consumedMedications));
        } else {
          emit(ConsumedMedicationError(
              message: 'Failed to load medications: ${temp.statusMessage}'));
        }
      } catch (e) {
        emit(ConsumedMedicationError(message: e.toString()));
      }
    });
  }
}
