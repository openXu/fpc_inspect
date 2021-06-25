import 'package:json_annotation/json_annotation.dart';

import 'User.dart';

part 'UserPermission.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class UserPermission{

  double? sortno;      //排序3.0
  String? component;  //映射字段  effect
  String? name;       //模块名  功能
  String? descrip;    //说明
  String? id;         //模块id   1369168578380574721
  String? parentid;   //父级模块id
  List<UserPermission>? children; //子权限

  UserPermission(this.sortno, this.component, this.name, this.descrip, this.id,
      this.parentid, this.children);

  factory UserPermission.fromJson(Map<String, dynamic> json) => _$UserPermissionFromJson(json);
  Map<String?, dynamic> toJson() => _$UserPermissionToJson(this);
}

class PermissionComponent{
/**一级权限，控制app主页导航栏tab显示*/
static const String level1_home = "homePage";   //首页模块   {"sortno":1.0,"component":"homePage","name":"任务","descrip":"","id":"1369167908600557569","parentid":"","children":[]}
static const String level1_function = "effect";   //功能模块  {"sortno":2.0,"component":"effect","name":"功能","descrip":"","id":"1369168578380574721","parentid":"","children":[{"sortno":1.0,"component":"dp","name":"双控预防","descrip":"","id":"1369169134549479426","parentid":"1369168578380574721","children":[{"sortno":1.0,"component":"riskArchives","name":"风险档案","descrip":"","id":"1369169893764640769","parentid":"1369169134549479426","children":[]},{"sortno":3.0,"component":"relieveapply","name":"解除申请","descrip":"","id":"1369170756419727362","parentid":"1369169134549479426","children":[]},{"sortno":4.0,"component":"relieveAudit","name":"解除审批","descrip":"","id":"1369171215368859650","parentid":"1369169134549479426","children":[]}]},{"sortno":2.0,"component":"exam","name":"安全检查","descrip":"","id":"1369169473927393282","parentid":"1369168578380574721","children":[{"sortno":2.0,"component":"registerTask","name":"任务登记","descrip":"","id":"1369171680823357441","parentid":"1369169473927393282","children":[]}]},{"sortno":3.0,"component":"proc","name":"检查整改","descrip":"","id":"1372433453672361986","parentid":"1369168578380574721","children":[{"sortno":1.0,"component":"procsel","name":"整改查询","descrip":"","id":"1372434493574541313","parentid":"1372433453672361986","children":[]},{"sortno":2.0,"component":"procrelease","name":"整改下单","descrip":"","id":"1372433860205277186","parentid":"1372433453672361986","children":[]},{"sortno":3.0,"component":"procregister","name":"整改登记","descrip":"","id":"1372434292642213890","parentid":"1372433453672361986","children":[]}]},{"sortno":4.0,"component":"other","name":"其他功能","descrip":"","id":"1382867653793726466","parentid":"1369168578380574721","children":[{"sortno":1.0,"component":"otherduty","name":"我的职责","descrip":"","id":"1382868262802472962","parentid":"1382867653793726466","children":[]}]}]}
static const String level1_alarm = "onekeyalarm";   //一键报警  {"sortno":3.0,"component":"onekeyalarm","name":"一键报警","descrip":"","id":"1384019518910283778","parentid":"","children":[]}
static const String level1_message = "message";   //消息  {"sortno":4.0,"component":"message","name":"消息","descrip":"","id":"1384411276294930433","parentid":"","children":[]}
static const String level1_my = "me";   //我的  {"sortno":5.0,"component":"me","name":"我的","descrip":"","id":"1369168809608359938","parentid":"","children":[{"sortno":1.0,"component":"changeHead","name":"修改头像","descrip":"","id":"1369172545298771969","parentid":"1369168809608359938","children":[]},{"sortno":2.0,"component":"changePwd","name":"修改密码","descrip":"","id":"1369172656217141250","parentid":"1369168809608359938","children":[]},{"sortno":3.0,"component":"logPostBack","name":"日志回传","descrip":"","id":"1369172757111123969","parentid":"1369168809608359938","children":[]},{"sortno":4.0,"component":"feedback","name":"意见反馈","descrip":"","id":"1369173184967880705","parentid":"1369168809608359938","children":[]}
/**二级功能模块权限分组（标题）*/
static const String level2_sv = "sv";       //督导管控
static const String level2_dp = "dp";      //双控预防
static const String level2_exam = "exam";  //安全检查
static const String level2_other = "other";//其他功能
/**三级功能模块*/
/*督导管控  sv*/
static const String level3_dddj = "svregister";  //督导登记
/*双控预防  dp*/
static const String level3_fxda = "riskArchives";  //风险档案
static const String level3_jcsq = "relieveapply";  //解除申请
static const String level3_jcsp = "relieveAudit";  //解除审批
/*安全检查  exam*/
static const String level3_rwdj = "registerTask";  //任务登记
/*检查整改  proc*/
static const String level3_zgcx = "procsel";  //整改查询
static const String level3_zgxd = "procrelease";  //整改下单
static const String level3_zgdj = "procregister";  //整改登记
/*其他功能  other*/
static const String level3_wdzz = "otherduty";  //我的职责
static const String level3_wrw = "miniTask";  //微任务
static const String level3_sbbd = "bindembcode";  //设备绑定
static const String level3_qybd = "bindregioncode";  //区域绑定
static const String level3_zsk = "knowledge";  //知识库
}