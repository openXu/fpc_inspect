// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserPermission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPermission _$UserPermissionFromJson(Map<String, dynamic> json) {
  return UserPermission(
    (json['sortno'] as num?)?.toDouble(),
    json['component'] as String?,
    json['name'] as String?,
    json['descrip'] as String?,
    json['id'] as String?,
    json['parentid'] as String?,
    (json['children'] as List<dynamic>?)
        ?.map((e) => UserPermission.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$UserPermissionToJson(UserPermission instance) =>
    <String, dynamic>{
      'sortno': instance.sortno,
      'component': instance.component,
      'name': instance.name,
      'descrip': instance.descrip,
      'id': instance.id,
      'parentid': instance.parentid,
      'children': instance.children,
    };
