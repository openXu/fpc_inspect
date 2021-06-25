import 'package:json_annotation/json_annotation.dart';

// user.g.dart 将在我们运行生成命令后自动生成
part 'User.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class User{
  String? id;   //"e9ca23d68d884d4ebb19d07889727dae",
  String? username;   //"admin",
  String? realname;   //"管理员",
  String? avatar;   //"temp/5dc84ec2c93246469a3869890383346e_1603420206108.jpeg",
  String? birthday;   //"2018-12-05",
  int? sex;   //1,
  String? email;   //"11@qq.com",
  String? phone;   //"18566666661",
  String? orgCode;   //"A00000",
  String? orgCodeTxt;   //null,
  String? orgId;   //"fb63973932d54429b7ca6dcc379d3884",
  String? orgName;   //"法之运科技有限公司",
  int? status;   //1,
  int? delFlag;   //0,
  String? workNo;   //"1112",
  String? post;   //"devleader",
  String? telephone;   //null,
  String? createBy;   //null,
  String? createTime;   //"2038-06-21 17:54:10",
  String? updateBy;   //"admin",
  String? updateTime;   //"2020-10-23 10:30:10",
  int? activitiSync;   //1,
  int? userIdentity;   //2,
  String? departIds;   //"c6d7cb4deeac411cb3384b1b31278596",
  String? thirdType;   //null,
  String? relTenantIds;   //"",
  String? postname;

  User(
      this.id,
      this.username,
      this.realname,
      this.avatar,
      this.birthday,
      this.sex,
      this.email,
      this.phone,
      this.orgCode,
      this.orgCodeTxt,
      this.orgId,
      this.orgName,
      this.status,
      this.delFlag,
      this.workNo,
      this.post,
      this.telephone,
      this.createBy,
      this.createTime,
      this.updateBy,
      this.updateTime,
      this.activitiSync,
      this.userIdentity,
      this.departIds,
      this.thirdType,
      this.relTenantIds,
      this.postname); //null
  //不同的类使用不同的mixin即可
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String?, dynamic> toJson() => _$UserToJson(this);
}