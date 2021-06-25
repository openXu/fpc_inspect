import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'Indicator.g.dart';

//指标项
@JsonSerializable()
class Indicator{

    String? taskitemid;   //6777382896224440320",
    String? planitemid;   //计划检查指标id  6776797510540600442",
    String? taskobjectid;   //任务对象id  6777382896144748544",
    String? taskid;   //任务id  6777382895989559296",
    String? taskgroupid;   //任务组id  6777382896069251072",
    String? indicatorid;   //指标id  6776331179626210357",
    String? indicatorcode;   //指标编码 EXAMI20210313095300838",
    String? indicatorname;   //指标名称   是否消毒",
    String? displayname;   //显示名称    是否消毒",

    String? indicatorsign;   //指标符号（+/-）
    double scale;    // 权重 1,
    String? examinemode;   //检查方法（来自于字典examinemode观察、手摸、听、测量） 1",
    String? indicatortype;   //指标类型(1,固定项;2,枚举项;) 2",
    String? enumstrs ;   //枚举项字符拼接串
    //"[{\"EnumID\":\"6776331179626210359\",\"EnumValue\":\"已消毒\",\"Descript\":\"\",\"ScoreSign\":\"+\",\"Score\":\"1.00\",\"IsNormal\":\"1\",\"IndicatorID\":\"6776331179626210357\",\"OrderIndex\":\"1\"},{\"EnumID\":\"6776331179626210360\",\"EnumValue\":\"未消毒\",\"Descript\":\"\",\"ScoreSign\":\"+\",\"Score\":\"0.00\",\"IsNormal\":\"0\",\"IndicatorID\":\"6776331179626210357\",\"OrderIndex\":\"2\"}]"
    String? enumid;   //枚举项id
    String? datatype;        // 数据类型(字典datatype,整数型、字符型、小数型)'
    String? defaultvalue;   // 默认值
    int? indicatorprecision;    // 精度  0,
    double? upperlimit;    //上限值  null,
    double? lowerlimit;    // 下限值  null,
    int? countvalue;    //计数分值 0,
    int? iscounttrue;    //计数数量是否为正常值  0 大于0 为正常项  1 小于0为正常项'
    double? standardscore;    //标准分数
    double? maxscore;    // 最高分数
    double? minscore;    //最低分数
    double? score;         // 分值
    //需要设置的结果
    String? datavalue;   // 结果枚举项值,
    String? datatext;     // 结果枚举项文本
    int? isnormal;        //是否正常值(0,否;1,是)', 0,

    int? risklevel;    //风险等级 取自字典表risklevel 1,
    int? hazardlevel;    //隐患等级 1,
    int? accidentlevel;      //事故等级 取自字典表accidentlevel
    String? createdby;   //Administrator",
    String? createdbyname;   //系统管理员",
    String? createddate;   //创建时间 2021-03-16",
    String? modifiedby;   //修改人 Administrator",
    String? modifieddate;   //修改时间 2021-03-16",
    String? modifiedbyname;

    Indicator(this.taskitemid, this.planitemid, this.taskobjectid, this.taskid,
        this.taskgroupid, this.indicatorid, this.indicatorcode,
        this.indicatorname, this.displayname, this.indicatorsign, this.scale,
        this.examinemode, this.indicatortype, this.enumstrs, this.enumid,
        this.datatype, this.defaultvalue, this.indicatorprecision,
        this.upperlimit, this.lowerlimit, this.countvalue, this.iscounttrue,
        this.standardscore, this.maxscore, this.minscore, this.score,
        this.datavalue, this.datatext, this.isnormal, this.risklevel,
        this.hazardlevel, this.accidentlevel, this.createdby,
        this.createdbyname, this.createddate, this.modifiedby,
        this.modifieddate, this.modifiedbyname); //修改人姓名

    //不同的类使用不同的mixin即可
    factory Indicator.fromJson(Map<String, dynamic> json) => _$IndicatorFromJson(json);
    Map<String?, dynamic> toJson() => _$IndicatorToJson(this);
}

@JsonSerializable()
class IndicatorEnum {
    String? EnumID;   //6776331179626210359",
    String? EnumValue;   //已消毒",
    String? Descript;   //
    String? ScoreSign;   //"+
    String? Score;   //1.00"
    String? IsNormal;   //  是否正常值(0,否;1,是)',
    String? IndicatorID;   //6776331179626210357
    String? OrderIndex;

    IndicatorEnum(this.EnumID, this.EnumValue, this.Descript, this.ScoreSign,
      this.Score, this.IsNormal, this.IndicatorID, this.OrderIndex); //"1"
    //不同的类使用不同的mixin即可
    factory IndicatorEnum.fromJson(Map<String, dynamic> json) => _$IndicatorEnumFromJson(json);
    Map<String?, dynamic> toJson() => _$IndicatorEnumToJson(this);

}
