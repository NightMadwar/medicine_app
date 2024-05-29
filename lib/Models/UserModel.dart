// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  int? id;
  String User_Name;
  String Password;
  String? Email;
  String? Gender;
  String? Age;
  double? Height;
  double? Weight;
  String? User_Location;
  String? accessToken;
  String? tokenType;

  UserModel({
    this.id,
    required this.User_Name,
    required this.Password,
    this.Email,
    this.Gender,
    this.Age,
    this.Height,
    this.Weight,
    this.User_Location,
    this.accessToken,
    this.tokenType,
  });

  UserModel copyWith({
    int? id,
    String? User_Name,
    String? Password,
    String? Email,
    String? Gender,
    String? Age,
    double? Height,
    double? Weight,
    String? User_Location,
    String? accessToken,
    String? tokenType,
  }) {
    return UserModel(
      id: id ?? this.id,
      User_Name: User_Name ?? this.User_Name,
      Password: Password ?? this.Password,
      Email: Email ?? this.Email,
      Gender: Gender ?? this.Gender,
      Age: Age ?? this.Age,
      Height: Height ?? this.Height,
      Weight: Weight ?? this.Weight,
      User_Location: User_Location ?? this.User_Location,
      accessToken: accessToken ?? this.accessToken,
      tokenType: tokenType ?? this.tokenType,
    );
  }

  Map<String, dynamic> toMap({bool includeId = false}) {
    final map = <String, dynamic>{
      'User_Name': User_Name,
      'Password': Password,
      'Email': Email,
      'Gender': Gender,
      'Age': Age,
      'Height': Height,
      'Weight': Weight,
      'User_Location': User_Location,
      'accessToken': accessToken,
      'tokenType': tokenType,
    };

    if (includeId) {
      map['id'] = id;
    }

    return map;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      User_Name: map['User_Name'] as String,
      Password: map['Password'] as String,
      Email: map['Email'] != null ? map['Email'] as String : null,
      Gender: map['Gender'] != null ? map['Gender'] as String : null,
      Age: map['Age'] != null ? map['Age'] as String : null,
      Height: map['Height'] != null ? map['Height'] as double : null,
      Weight: map['Weight'] != null ? map['Weight'] as double : null,
      User_Location:
          map['User_Location'] != null ? map['User_Location'] as String : null,
      accessToken:
          map['access_token'] != null ? map['access_token'] as String : null,
      tokenType: map['token_type'] != null ? map['token_type'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, User_Name: $User_Name, Password: $Password, Email: $Email, Gender: $Gender, Age: $Age, Height: $Height, Weight: $Weight, User_Location: $User_Location, accessToken: $accessToken, tokenType: $tokenType)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.User_Name == User_Name &&
        other.Password == Password &&
        other.Email == Email &&
        other.Gender == Gender &&
        other.Age == Age &&
        other.Height == Height &&
        other.Weight == Weight &&
        other.User_Location == User_Location &&
        other.accessToken == accessToken &&
        other.tokenType == tokenType;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        User_Name.hashCode ^
        Password.hashCode ^
        Email.hashCode ^
        Gender.hashCode ^
        Age.hashCode ^
        Height.hashCode ^
        Weight.hashCode ^
        User_Location.hashCode ^
        accessToken.hashCode ^
        tokenType.hashCode;
  }
}
