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
        dynamic temp = await ConsumedMedicationService()
            .postMedication(event.drug, event.medication);
        if (temp is Response) {
          List<ConsumedMedicationModel> ConsumedMedication =
              List.generate(temp.data.length, (index) {
            return ConsumedMedicationModel.fromMap(temp.data[index]);
          });
          emit(ConsumedMedicationSuccess(
              consumedMedications: ConsumedMedication));
        } else {
          // print(temp.toString());
        }
      } catch (e) {
        emit(ConsumedMedicationError());
      }
    });
    on<GetAllConsumedMedications>((event, emit) async {
      emit(ConsumedMedicationLoading());
      try {
        print(event.Name);
        dynamic temp = await ConsumedMedicationService().search(event.Name);
        if (temp is Response) {
          List<ConsumedMedicationModel> ConsumedMedication =
              List.generate(temp.data.length, (index) {
            return ConsumedMedicationModel.fromMap(temp.data[index]);
          });
          emit(ConsumedMedicationSuccess(
              consumedMedications: ConsumedMedication));
        } else {
          // print(temp.toString());
        }
      } catch (e) {
        emit(ConsumedMedicationError());
      }
    });
    on<GetAllMorning>((event, emit) async {
      emit(ConsumedMedicationLoading());
      try {
        dynamic temp = await ConsumedMedicationService().get2();

        if (temp is Response) {
          List<ConsumedMedicationModel> ConsumedMedication =
              List.generate(temp.data.length, (index) {
            return ConsumedMedicationModel.fromMap(temp.data[index]);
          });
          emit(ConsumedMedicationSuccess(
              consumedMedications: ConsumedMedication));
        } else {
          // print(temp.toString());
        }
      } catch (e) {
        emit(ConsumedMedicationError());
      }
    });
    on<GetAllAfternoon>((event, emit) async {
      emit(ConsumedMedicationLoading());
      try {
        dynamic temp = await ConsumedMedicationService().get3();

        if (temp is Response) {
          List<ConsumedMedicationModel> ConsumedMedication =
              List.generate(temp.data.length, (index) {
            return ConsumedMedicationModel.fromMap(temp.data[index]);
          });
          emit(ConsumedMedicationSuccess(
              consumedMedications: ConsumedMedication));
        } else {
          // print(temp.toString());
        }
      } catch (e) {
        emit(ConsumedMedicationError());
      }
    });
    on<GetAllEvening>((event, emit) async {
      emit(ConsumedMedicationLoading());
      try {
        dynamic temp = await ConsumedMedicationService().get4();

        if (temp is Response) {
          List<ConsumedMedicationModel> ConsumedMedication =
              List.generate(temp.data.length, (index) {
            return ConsumedMedicationModel.fromMap(temp.data[index]);
          });
          emit(ConsumedMedicationSuccess(
              consumedMedications: ConsumedMedication));
        } else {
          // print(temp.toString());
        }
      } catch (e) {
        emit(ConsumedMedicationError());
      }
    });
  }
}
