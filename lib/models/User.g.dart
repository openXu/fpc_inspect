// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['id'] as String?,
    json['username'] as String?,
    json['realname'] as String?,
    json['avatar'] as String?,
    json['birthday'] as String?,
    json['sex'] as int?,
    json['email'] as String?,
    json['phone'] as String?,
    json['orgCode'] as String?,
    json['orgCodeTxt'] as String?,
    json['orgId'] as String?,
    json['orgName'] as String?,
    json['status'] as int?,
    json['delFlag'] as int?,
    json['workNo'] as String?,
    json['post'] as String?,
    json['telephone'] as String?,
    json['createBy'] as String?,
    json['createTime'] as String?,
    json['updateBy'] as String?,
    json['updateTime'] as String?,
    json['activitiSync'] as int?,
    json['userIdentity'] as int?,
    json['departIds'] as String?,
    json['thirdType'] as String?,
    json['relTenantIds'] as String?,
    json['postname'] as String?,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'realname': instance.realname,
      'avatar': instance.avatar,
      'birthday': instance.birthday,
      'sex': instance.sex,
      'email': instance.email,
      'phone': instance.phone,
      'orgCode': instance.orgCode,
      'orgCodeTxt': instance.orgCodeTxt,
      'orgId': instance.orgId,
      'orgName': instance.orgName,
      'status': instance.status,
      'delFlag': instance.delFlag,
      'workNo': instance.workNo,
      'post': instance.post,
      'telephone': instance.telephone,
      'createBy': instance.createBy,
      'createTime': instance.createTime,
      'updateBy': instance.updateBy,
      'updateTime': instance.updateTime,
      'activitiSync': instance.activitiSync,
      'userIdentity': instance.userIdentity,
      'departIds': instance.departIds,
      'thirdType': instance.thirdType,
      'relTenantIds': instance.relTenantIds,
      'postname': instance.postname,
    };
