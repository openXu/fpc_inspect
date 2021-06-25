// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Indicator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Indicator _$IndicatorFromJson(Map<String, dynamic> json) {
  return Indicator(
    json['taskitemid'] as String?,
    json['planitemid'] as String?,
    json['taskobjectid'] as String?,
    json['taskid'] as String?,
    json['taskgroupid'] as String?,
    json['indicatorid'] as String?,
    json['indicatorcode'] as String?,
    json['indicatorname'] as String?,
    json['displayname'] as String?,
    json['indicatorsign'] as String?,
    (json['scale'] as num).toDouble(),
    json['examinemode'] as String?,
    json['indicatortype'] as String?,
    json['enumstrs'] as String?,
    json['enumid'] as String?,
    json['datatype'] as String?,
    json['defaultvalue'] as String?,
    json['indicatorprecision'] as int?,
    (json['upperlimit'] as num?)?.toDouble(),
    (json['lowerlimit'] as num?)?.toDouble(),
    json['countvalue'] as int?,
    json['iscounttrue'] as int?,
    (json['standardscore'] as num?)?.toDouble(),
    (json['maxscore'] as num?)?.toDouble(),
    (json['minscore'] as num?)?.toDouble(),
    (json['score'] as num?)?.toDouble(),
    json['datavalue'] as String?,
    json['datatext'] as String?,
    json['isnormal'] as int?,
    json['risklevel'] as int?,
    json['hazardlevel'] as int?,
    json['accidentlevel'] as int?,
    json['createdby'] as String?,
    json['createdbyname'] as String?,
    json['createddate'] as String?,
    json['modifiedby'] as String?,
    json['modifieddate'] as String?,
    json['modifiedbyname'] as String?,
  );
}

Map<String, dynamic> _$IndicatorToJson(Indicator instance) => <String, dynamic>{
      'taskitemid': instance.taskitemid,
      'planitemid': instance.planitemid,
      'taskobjectid': instance.taskobjectid,
      'taskid': instance.taskid,
      'taskgroupid': instance.taskgroupid,
      'indicatorid': instance.indicatorid,
      'indicatorcode': instance.indicatorcode,
      'indicatorname': instance.indicatorname,
      'displayname': instance.displayname,
      'indicatorsign': instance.indicatorsign,
      'scale': instance.scale,
      'examinemode': instance.examinemode,
      'indicatortype': instance.indicatortype,
      'enumstrs': instance.enumstrs,
      'enumid': instance.enumid,
      'datatype': instance.datatype,
      'defaultvalue': instance.defaultvalue,
      'indicatorprecision': instance.indicatorprecision,
      'upperlimit': instance.upperlimit,
      'lowerlimit': instance.lowerlimit,
      'countvalue': instance.countvalue,
      'iscounttrue': instance.iscounttrue,
      'standardscore': instance.standardscore,
      'maxscore': instance.maxscore,
      'minscore': instance.minscore,
      'score': instance.score,
      'datavalue': instance.datavalue,
      'datatext': instance.datatext,
      'isnormal': instance.isnormal,
      'risklevel': instance.risklevel,
      'hazardlevel': instance.hazardlevel,
      'accidentlevel': instance.accidentlevel,
      'createdby': instance.createdby,
      'createdbyname': instance.createdbyname,
      'createddate': instance.createddate,
      'modifiedby': instance.modifiedby,
      'modifieddate': instance.modifieddate,
      'modifiedbyname': instance.modifiedbyname,
    };

IndicatorEnum _$IndicatorEnumFromJson(Map<String, dynamic> json) {
  return IndicatorEnum(
    json['EnumID'] as String?,
    json['EnumValue'] as String?,
    json['Descript'] as String?,
    json['ScoreSign'] as String?,
    json['Score'] as String?,
    json['IsNormal'] as String?,
    json['IndicatorID'] as String?,
    json['OrderIndex'] as String?,
  );
}

Map<String, dynamic> _$IndicatorEnumToJson(IndicatorEnum instance) =>
    <String, dynamic>{
      'EnumID': instance.EnumID,
      'EnumValue': instance.EnumValue,
      'Descript': instance.Descript,
      'ScoreSign': instance.ScoreSign,
      'Score': instance.Score,
      'IsNormal': instance.IsNormal,
      'IndicatorID': instance.IndicatorID,
      'OrderIndex': instance.OrderIndex,
    };
