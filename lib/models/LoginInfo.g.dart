// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LoginInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginInfo _$LoginInfoFromJson(Map<String, dynamic> json) {
  return LoginInfo(
    json['multi_depart'] as int?,
    json['token'] as String?,
    json['userInfo'] == null
        ? null
        : User.fromJson(json['userInfo'] as Map<String, dynamic>),
  )
    ..logined = json['logined'] as bool
    ..autoLogin = json['autoLogin'] as bool;
}

Map<String, dynamic> _$LoginInfoToJson(LoginInfo instance) => <String, dynamic>{
      'multi_depart': instance.multi_depart,
      'token': instance.token,
      'userInfo': instance.userInfo,
      'logined': instance.logined,
      'autoLogin': instance.autoLogin,
    };
