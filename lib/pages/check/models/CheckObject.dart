import 'package:json_annotation/json_annotation.dart';

part 'CheckObject.g.dart';

@JsonSerializable()
class CheckObject{

    String? taskid;     //"
    String? planobjectid;     //"
    String? taskobjectid;     //6788717623883599872"
    String? taskobjectname;     //众创空间A座"
    String? realobjectid;     //"          //实体对象ID(冗余)
    String? realobjectname;     //"        //实体对象名称(冗余)
    String? enableuploadattach;   //1"   //'启用附件上传(0,否;1,是)',

    String? routemode;     //1"            //'路线模式 1 自由路线 2 规定路线',
    String? examinemode;     //1"         //ExamineMode '检查模式 1 标准模式 2 巡更模式',
    String? limitmode;     //0"
    String? qrcode;     //"
    String? barcode;     //"
    String? rfidcode;     //"

    String? examindicatorcount;     //0"
    String? modifiedbyname;     //"
    String? modifieddate;     //"
    String? pdaid;     //"
    String? createddate;     //"
    String? createdby;     //"
    String? createdbyname;     //"
    String? examstatus;     //0"
    String? examtime;     //"
    String? examuser;     //"
    String? examusername;     //"
    String? isnormal;     //0"
    String? normalindicatorcount;     //0"
    String? abnormalindicatorcount;     //0"
    String? taskgroupid;     //"
    String? modifiedby;     //"
    String? serialkey;     //6788717623883599873"
    String? orderindex;     //0"
    String? totalindicatorcount;

    CheckObject(
      this.taskid,
      this.planobjectid,
      this.taskobjectid,
      this.taskobjectname,
      this.realobjectid,
      this.realobjectname,
      this.enableuploadattach,
      this.routemode,
      this.examinemode,
      this.limitmode,
      this.qrcode,
      this.barcode,
      this.rfidcode,
      this.examindicatorcount,
      this.modifiedbyname,
      this.modifieddate,
      this.pdaid,
      this.createddate,
      this.createdby,
      this.createdbyname,
      this.examstatus,
      this.examtime,
      this.examuser,
      this.examusername,
      this.isnormal,
      this.normalindicatorcount,
      this.abnormalindicatorcount,
      this.taskgroupid,
      this.modifiedby,
      this.serialkey,
      this.orderindex,
      this.totalindicatorcount); //11"



  //不同的类使用不同的mixin即可
  factory CheckObject.fromJson(Map<String, dynamic> json) => _$CheckObjectFromJson(json);
  Map<String?, dynamic> toJson() => _$CheckObjectToJson(this);
}