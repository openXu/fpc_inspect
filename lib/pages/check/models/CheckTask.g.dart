// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CheckTask.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckTask _$CheckTaskFromJson(Map<String, dynamic> json) {
  return CheckTask(
    json['taskendtime'] as String?,
    json['TaskCode'] as String?,
    json['TaskName'] as String?,
    json['companyname'] as String?,
    json['progress'] as String?,
    json['taskstarttime'] as String?,
    json['abnormalobjectcount'] as String?,
    json['taskid'] as String?,
  );
}

Map<String, dynamic> _$CheckTaskToJson(CheckTask instance) => <String, dynamic>{
      'taskendtime': instance.taskendtime,
      'TaskCode': instance.TaskCode,
      'TaskName': instance.TaskName,
      'companyname': instance.companyname,
      'progress': instance.progress,
      'taskstarttime': instance.taskstarttime,
      'abnormalobjectcount': instance.abnormalobjectcount,
      'taskid': instance.taskid,
    };
