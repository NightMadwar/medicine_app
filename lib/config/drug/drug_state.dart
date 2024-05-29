part of 'drug_bloc.dart';

@immutable
sealed class DrugState {}

final class DrugInitial extends DrugState {}

final class DrugLoading extends DrugState {}

final class DrugSuccess extends DrugState {
  final List<DrugModel> drugs;
  DrugSuccess({required this.drugs});
}

final class DrugError extends DrugState {}
