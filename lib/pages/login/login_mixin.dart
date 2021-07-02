
import 'dart:convert';
//Key和material包中Key类名冲突，可以给加密包取别名，这样调用包中的类时都要通过 别名encrypt.
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:encrypt/encrypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpc_inspect/common/util/common_utils.dart';
import 'package:fpc_inspect/common/net/http_manager.dart';
import 'package:fpc_inspect/common/util/sp_storage.dart';
import 'package:fpc_inspect/config/Global.dart';
import 'package:fpc_inspect/config/api_service.dart';
import 'package:fpc_inspect/config/config.dart';
import 'package:fpc_inspect/models/LoginInfo.dart';
import 'package:fpc_inspect/models/UserPermission.dart';

mixin Login{

  Future<bool> onLogin(BuildContext context, String name, String pwd) async {
    CommonUtils.showLoading(context);
//AES加密后:[-41, 52, 15, 1, -47, 122, 66, -60, 102, -20, 9, 90, 53, 52, -99, -42]
//         [215, 52, 15, 1, 209, 122, 66, 196, 102, 236, 9, 90, 53, 52, 157, 214]
//base64加密:[49, 122, 81, 80, 65, 100, 70, 54, 81, 115, 82, 109, 55, 65, 108, 97, 78, 84, 83, 100, 49, 103, 61, 61]
//MXpRUEFkRjZRc1JtN0FsYU5UU2QxZz09
    var keyAndVi = '21328FPC1192021g';

    final key = encrypt.Key.fromUtf8(keyAndVi); //encrypt.Key.fromBase64(base64Encode(keyAndVi.codeUnits));
    final iv = encrypt.IV.fromUtf8(keyAndVi);  //encrypt.IV.fromBase64(base64Encode(iv.codeUnits));
    //"AES/CBC/PKCS5Padding",
    final encrypted = Encrypter(AES(key, mode: AESMode.cbc))
        .encrypt(pwd, iv: iv);
    //MXpRUEFkRjZRc1JtN0FsYU5UU2QxZz09
    var passwordEncrypted = base64Encode(utf8.encode(encrypted.base64));
    // http://39.98.164.162:8080/jeecg-boot/sys/phoneLogin
    Map requestParams = {
      "mobileorusercode": name,
      "password" : passwordEncrypted,
      "appid" : Config.productId,
      "devicetokenkey" : "ssssssssssssssss",
      "clienttype" : "1"
    };

    //await调用异步请求，等待请求结果
    var response = await httpManager.post(ApiService.URL_LOGIN,
        json.encode(requestParams));
    print("返回结果:$response");
    // 隐藏loading框
    Navigator.of(context).pop();
    if(response.success){
      print("返回结果:${response.result.runtimeType}");
      LoginInfo loginInfo = LoginInfo.fromJson(response.result);
      loginInfo.logined = true;
      loginInfo.autoLogin = true;
      ///将登录信息存储到sp中
      SpLocalStorage.saveData(SpLocalStorage.KEY_USER, jsonEncode(loginInfo));
      return true;
    }
   return false;
  }

  Future<bool> getUserPermission(BuildContext context, {bool showLoading = true}) async {
    if(showLoading)
      CommonUtils.showLoading(context);
    Map<String, dynamic> requestParams = {
      "token": (await Global.getLoginInfo())?.token??"",
      "applicationid" : Config.applicationid,
    };
    var response = await httpManager.get(ApiService.URL_USER_PERMISSION, requestParams);
    if(showLoading)
      Navigator.of(context).pop();
    if(response.success){
      //List<Map>
      List list = (response.result as List);
      //权限数组
      List<UserPermission> userPermissions = List.generate(list.length,
              (index) => UserPermission.fromJson(list[index]));
      ///将权限信息存储到sp中
      SpLocalStorage.saveData(SpLocalStorage.KEY_USER_PERMISSION, jsonEncode(userPermissions));
      return true;
    }
    return false;
  }
}