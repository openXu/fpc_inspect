// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CheckItems.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckItems _$CheckItemsFromJson(Map<String, dynamic> json) {
  return CheckItems(
    json['serialkey'] as String?,
    (json['taskitem'] as List<dynamic>?)
        ?.map((e) => Indicator.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CheckItemsToJson(CheckItems instance) =>
    <String, dynamic>{
      'serialkey': instance.serialkey,
      'taskitem': instance.taskitem,
    };
