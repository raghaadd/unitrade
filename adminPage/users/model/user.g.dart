// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      firstName: json['fname'] as String,
      LastName: json['lname'] as String,
      email: json['email'] as String,
      phoneNO: json['phoneNo'] as String? ?? '__',
      ID: json['registerID'] as int,
      // isSelected: json['isSelected'] as int,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'LastName': instance.LastName,
      'email': instance.email,
      'phoneNO': instance.phoneNO,
      'ID': instance.ID,
      // 'isSelected': instance.isSelected,
    };
