import 'dart:convert';
import 'package:medicine_app/Models/DrugModel.dart';
import 'package:medicine_app/Models/UserModel.dart';

class ConsumedMedicationModel {
  int? id;
  int Drug_ID;
  int User_ID;
  DrugModel? drug;
  UserModel? user;
  String Doctor_Name;
  String? Date_Prescibed;
  String period;

  ConsumedMedicationModel({
    this.id,
    required this.Drug_ID,
    required this.User_ID,
    this.drug,
    this.user,
    required this.Doctor_Name,
    this.Date_Prescibed,
    required this.period,
  });

  ConsumedMedicationModel copyWith({
    int? id,
    int? Drug_ID,
    int? User_ID,
    DrugModel? drug,
    UserModel? user,
    String? Doctor_Name,
    String? Date_Prescibed,
    String? period,
  }) {
    return ConsumedMedicationModel(
      id: id ?? this.id,
      Drug_ID: Drug_ID ?? this.Drug_ID,
      User_ID: User_ID ?? this.User_ID,
      drug: drug ?? this.drug,
      user: user ?? this.user,
      Doctor_Name: Doctor_Name ?? this.Doctor_Name,
      Date_Prescibed: Date_Prescibed ?? this.Date_Prescibed,
      period: period ?? this.period,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Drug_ID': Drug_ID,
      'User_ID': User_ID,
      'drug': drug?.toMap(),
      'user': user?.toMap(),
      'Doctor_Name': Doctor_Name,
      'Date_Prescibed': Date_Prescibed,
      'period': period,
    };
  }

  factory ConsumedMedicationModel.fromMap(Map<String, dynamic> map) {
    return ConsumedMedicationModel(
      id: map['id'] != null
          ? map['id'] is int
              ? map['id']
              : (map['id'] as double).toInt()
          : null,
      Drug_ID: map['Drug_ID'] is int
          ? map['Drug_ID']
          : (map['Drug_ID'] as double).toInt(),
      User_ID: map['User_ID'] is int
          ? map['User_ID']
          : (map['User_ID'] as double).toInt(),
      drug: map['drug'] != null ? DrugModel.fromMap(map['drug']) : null,
      user: map['user'] != null ? UserModel.fromMap(map['user']) : null,
      Doctor_Name: map['Doctor_Name'] as String,
      Date_Prescibed: map['Date_Prescibed'] != null
          ? map['Date_Prescibed'] as String
          : null,
      period: map['period'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConsumedMedicationModel.fromJson(String source) =>
      ConsumedMedicationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ConsumedMedicationModel(id: $id, Drug_ID: $Drug_ID, User_ID: $User_ID, drug: $drug, user: $user, Doctor_Name: $Doctor_Name, Date_Prescibed: $Date_Prescibed, period: $period)';
  }

  @override
  bool operator ==(covariant ConsumedMedicationModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.Drug_ID == Drug_ID &&
        other.User_ID == User_ID &&
        other.drug == drug &&
        other.user == user &&
        other.Doctor_Name == Doctor_Name &&
        other.Date_Prescibed == Date_Prescibed &&
        other.period == period;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        Drug_ID.hashCode ^
        User_ID.hashCode ^
        drug.hashCode ^
        user.hashCode ^
        Doctor_Name.hashCode ^
        Date_Prescibed.hashCode ^
        period.hashCode;
  }
}
