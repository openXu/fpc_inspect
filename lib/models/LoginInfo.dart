import 'package:json_annotation/json_annotation.dart';

import 'User.dart';

// user.g.dart 将在我们运行生成命令后自动生成
part 'LoginInfo.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class LoginInfo{
  //接口返回
  int? multi_depart;
  String? token;
  User? userInfo;

  //是否已经登录，只有登录后才能进入主页
  bool logined = false;
  //是否自动登录，登录页配置
  bool autoLogin = true;

  LoginInfo(this.multi_depart, this.token, this.userInfo);
  //不同的类使用不同的mixin即可
  factory LoginInfo.fromJson(Map<String, dynamic> json) => _$LoginInfoFromJson(json);
  Map<String?, dynamic> toJson() => _$LoginInfoToJson(this);
}