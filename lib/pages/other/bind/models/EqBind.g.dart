// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EqBind.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Region _$RegionFromJson(Map<String, dynamic> json) {
  return Region(
    json['companyid'] as String?,
    json['regionid'] as String?,
    json['sorting'] as String?,
    json['regionname'] as String?,
    json['isend'] as String?,
  );
}

Map<String, dynamic> _$RegionToJson(Region instance) => <String, dynamic>{
      'companyid': instance.companyid,
      'regionid': instance.regionid,
      'sorting': instance.sorting,
      'regionname': instance.regionname,
      'isend': instance.isend,
    };

EqType _$EqTypeFromJson(Map<String, dynamic> json) {
  return EqType(
    json['classid'] as String?,
    json['classcode'] as String?,
    json['classname'] as String?,
  );
}

Map<String, dynamic> _$EqTypeToJson(EqType instance) => <String, dynamic>{
      'classid': instance.classid,
      'classcode': instance.classcode,
      'classname': instance.classname,
    };

Equepment _$EquepmentFromJson(Map<String, dynamic> json) {
  return Equepment(
    json['id'] as String?,
    json['equipmentcode'] as String?,
    json['equipmentname'] as String?,
    json['shortname'] as String?,
    json['equipmentclassname'] as String?,
    json['rfidcode'] as String?,
    json['barcode'] as String?,
    json['qrcode'] as String?,
    json['regionname'] as String?,
    json['positions'] as String?,
    json['organiseunitname'] as String?,
    json['serialkey'] as String?,
  );
}

Map<String, dynamic> _$EquepmentToJson(Equepment instance) => <String, dynamic>{
      'id': instance.id,
      'equipmentcode': instance.equipmentcode,
      'equipmentname': instance.equipmentname,
      'shortname': instance.shortname,
      'equipmentclassname': instance.equipmentclassname,
      'rfidcode': instance.rfidcode,
      'barcode': instance.barcode,
      'qrcode': instance.qrcode,
      'regionname': instance.regionname,
      'positions': instance.positions,
      'organiseunitname': instance.organiseunitname,
      'serialkey': instance.serialkey,
    };
