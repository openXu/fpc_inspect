// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CheckTaskPage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckTaskPage _$CheckTaskPageFromJson(Map<String, dynamic> json) {
  return CheckTaskPage(
    (json['records'] as List<dynamic>?)
        ?.map((e) => CheckTask.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['total'] as int?,
    json['size'] as int?,
    json['current'] as int?,
    (json['orders'] as List<dynamic>?)?.map((e) => e as int).toList(),
    json['optimizeCountSql'] as bool?,
    json['hitCount'] as bool?,
    json['searchCount'] as bool?,
    json['pages'] as int?,
  );
}

Map<String, dynamic> _$CheckTaskPageToJson(CheckTaskPage instance) =>
    <String, dynamic>{
      'records': instance.records,
      'total': instance.total,
      'size': instance.size,
      'current': instance.current,
      'orders': instance.orders,
      'optimizeCountSql': instance.optimizeCountSql,
      'hitCount': instance.hitCount,
      'searchCount': instance.searchCount,
      'pages': instance.pages,
    };
