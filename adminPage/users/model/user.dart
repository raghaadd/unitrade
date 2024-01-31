import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String firstName;
  String LastName;
  String email;
  String phoneNO;
  int ID;
  //int isSelected;

  User({
    required this.firstName,
    required this.LastName,
    required this.email,
    required this.phoneNO,
    required this.ID,
    //required this.isSelected,
  });

  User copy({
    String? firstName,
    String? LastName,
    String? email,
    String? phoneNO,
    int? ID,
    //int? isSelected,
  }) =>
      User(
          firstName: firstName ?? this.firstName,
          LastName: LastName ?? this.LastName,
          email: email ?? this.email,
          phoneNO: phoneNO ?? this.phoneNO,
          ID: ID ?? this.ID,
          //isSelected: isSelected ?? this.isSelected
          );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  static bool? _tinyIntToBool(int? value) {
    if (value != null) {
      return value == 1;
    }
    return null;
  }

  User toggleSelection() {
    return User(
      firstName: firstName,
      LastName: LastName,
      email: email,
      phoneNO: phoneNO,
      ID: ID,
      //isSelected: isSelected,
    );
  }

  User copyWith({int? isSelected}) {
    return User(
      // Copy all fields, and update isSelected if provided
      firstName: firstName,
      LastName: LastName,
      email: email,
      phoneNO: phoneNO,
      ID: ID,
      //isSelected: isSelected ?? this.isSelected,
    );
  }


}
