import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'EqBind.g.dart';



///1. 区域列表
@JsonSerializable()
class Region{

    String? companyid;    //20210323144742424
    String? regionid;    //6780415483645792256
    String? sorting;    //0
    String? regionname;    //众创空间A座
    String? isend;    //0

    Region(this.companyid, this.regionid, this.sorting, this.regionname, this.isend);
    Region.defaultType({this.companyid = "", this.regionid= "", this.regionname});

    //不同的类使用不同的mixin即可
    factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
    Map<String?, dynamic> toJson() => _$RegionToJson(this);

}


///2. 设备分类列表
@JsonSerializable()
class EqType{
    String? classid;    //6776078366719348736",
    String? classcode;    //ec20210312175616074",
    String? classname;    //安防设备",

    EqType(this.classid, this.classcode, this.classname);
    EqType.defaultType({this.classid = "", this.classcode= "", this.classname});

    //不同的类使用不同的mixin即可
    factory EqType.fromJson(Map<String, dynamic> json) => _$EqTypeFromJson(json);
    Map<String?, dynamic> toJson() => _$EqTypeToJson(this);

}


@JsonSerializable()
class Equepment{
    String? id;     //6780680725307068416",
    String? equipmentcode;     //2021032510411105",
    String? equipmentname;     //烟感01",
    String? shortname;     //null,
    String? equipmentclassname;     //安防设备",
    String? rfidcode;     //http://baike.baidu.com",
    String? barcode;     //null,
    String? qrcode;     //null,
    String? regionname;     //",
    String? positions;     //null,
    String? organiseunitname;     //创业科技大厦",
    String? serialkey;

    Equepment(
      this.id,
      this.equipmentcode,
      this.equipmentname,
      this.shortname,
      this.equipmentclassname,
      this.rfidcode,
      this.barcode,
      this.qrcode,
      this.regionname,
      this.positions,
      this.organiseunitname,
      this.serialkey); //null,
    //不同的类使用不同的mixin即可
    factory Equepment.fromJson(Map<String, dynamic> json) => _$EquepmentFromJson(json);
    Map<String?, dynamic> toJson() => _$EquepmentToJson(this);

}

