part of 'drug_bloc.dart';

@immutable
sealed class DrugEvent {}

final class GetDrug extends DrugEvent {}

final class GetAllDrugs extends DrugEvent {}

final class PostDrug extends DrugEvent {}
