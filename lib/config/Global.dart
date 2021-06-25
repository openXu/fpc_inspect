// 提供五套可选主题色
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fpc_inspect/common/util/LogUtil.dart';
import 'package:fpc_inspect/common/util/sp_storage.dart';
import 'package:fpc_inspect/models/LoginInfo.dart';
import 'package:fpc_inspect/models/UserPermission.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themes = <MaterialColor>[
  Colors.blue,
  Colors.red,
];

class Global {

  // 网络缓存对象
  // static NetCache netCache = NetCache();
  // 可选的主题列表
  static List<MaterialColor> get themes => _themes;
  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  static LoginInfo? _loginInfo;
  static List<UserPermission>? _userPermissions;

  static Future<LoginInfo?> getLoginInfo() async {
    if (_loginInfo != null)
      return _loginInfo;
    var jsonStr = await SpLocalStorage.getData<String>(
        SpLocalStorage.KEY_USER);
    if (jsonStr != null) {
      _loginInfo = LoginInfo.fromJson(jsonDecode(jsonStr));
    }else{
      print("本地没有用户信息");
    }
    return _loginInfo;
  }
  static Future<List<UserPermission>?> getUserPermission() async {
    if (_userPermissions != null)
      return _userPermissions;
    var jsonStr = await SpLocalStorage.getData<String>(
        SpLocalStorage.KEY_USER_PERMISSION);
    if (jsonStr != null) {
      //List<Map>
      List list = jsonDecode(jsonStr);
      //权限数组
      _userPermissions = List.generate(list.length,
              (index) => UserPermission.fromJson(list[index]));
    }else{
      print("本地没有用户权限信息");
    }
    return _userPermissions;
  }

}