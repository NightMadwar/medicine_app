import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:medicine_app/Models/ConsumedMedicationModel.dart';
import 'package:medicine_app/Models/DrugModel.dart';
import 'package:medicine_app/Service/DrugService.dart';
import 'package:meta/meta.dart';

part 'drug_event.dart';
part 'drug_state.dart';

class DrugBloc extends Bloc<DrugEvent, DrugState> {
  DrugBloc() : super(DrugInitial()) {
    on<GetAllDrugs>((event, emit) async {
      emit(DrugLoading());
      try {
        Response? response = await DrugService().get();
        List<DrugModel> drugs = List<DrugModel>.from(
            response!.data.map((drug) => DrugModel.fromMap(drug)));
        if (response is Response) {
          emit(DrugSuccess(drugs: drugs));
        } else {
          print(response.toString());
        }
      } catch (e) {
        emit(DrugError());
      }
    });
  }
}
