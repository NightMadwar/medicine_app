import 'dart:convert';

class DrugModel {
  int? id;
  String Drug_name;
  String Effective_Material;
  String Side_Effects;
  String Other_Information;
  String image;

  DrugModel({
    this.id,
    required this.Drug_name,
    required this.Effective_Material,
    required this.Side_Effects,
    required this.Other_Information,
    required this.image,
  });

  DrugModel copyWith({
    int? id,
    String? Drug_name,
    String? Effective_Material,
    String? Side_Effects,
    String? Other_Information,
    String? image,
  }) {
    return DrugModel(
      id: id ?? this.id,
      Drug_name: Drug_name ?? this.Drug_name,
      Effective_Material: Effective_Material ?? this.Effective_Material,
      Side_Effects: Side_Effects ?? this.Side_Effects,
      Other_Information: Other_Information ?? this.Other_Information,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Drug_name': Drug_name,
      'Effective_Material': Effective_Material,
      'Side_Effects': Side_Effects,
      'Other_Information': Other_Information,
      'image': image,
    };
  }

  factory DrugModel.fromMap(Map<String, dynamic> map) {
    return DrugModel(
      id: map['id'] != null
          ? map['id'] is int
              ? map['id']
              : (map['id'] as double).toInt()
          : null,
      Drug_name: map['Drug_name'] as String,
      Effective_Material: map['Effective_Material'] as String,
      Side_Effects: map['Side_Effects'] as String,
      Other_Information: map['Other_Information'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DrugModel.fromJson(String source) =>
      DrugModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DrugModel(id: $id, Drug_name: $Drug_name, Effective_Material: $Effective_Material, Side_Effects: $Side_Effects, Other_Information: $Other_Information, image: $image)';
  }

  @override
  bool operator ==(covariant DrugModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.Drug_name == Drug_name &&
        other.Effective_Material == Effective_Material &&
        other.Side_Effects == Side_Effects &&
        other.Other_Information == Other_Information &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        Drug_name.hashCode ^
        Effective_Material.hashCode ^
        Side_Effects.hashCode ^
        Other_Information.hashCode ^
        image.hashCode;
  }
}
