import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fpc_inspect/config/Global.dart';
import 'package:fpc_inspect/config/config.dart';
import 'package:fpc_inspect/models/LoginInfo.dart';
import 'package:fpc_inspect/pages/login/login_page.dart';
import 'package:fpc_inspect/pages/main_page.dart';

import 'login_mixin.dart';

/*
 * 欢迎页
 */
class WelcomePage extends StatefulWidget {
  static final String sName = "/";

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with Login{
  bool hadInit = false;

  String text = "";
  double fontSize = 76;
  @override
  void initState() {
    super.initState();
    print('初始化启动页面');
    //

    new Future.delayed(const Duration(seconds: 2, milliseconds: 500), () async {
      print("延迟2s进入主页面");
      // Navigator.popAndPushNamed(context, MainPage.sName);
      //状态栏\底部虚拟按键（华为系列某些手机有虚拟按键） 显示
      SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);

      LoginInfo? loginInfo = await Global.getLoginInfo();
      if (loginInfo != null && loginInfo.logined) {
        LogUtil.init(tag : "fpc", isDebug:Config.DEBUG);
        if(loginInfo!=null && loginInfo.autoLogin
            &&loginInfo.userInfo!=null){
          print("自动登录");
        }
        Navigator.pushReplacementNamed(context, MainPage.sName);
      } else{
        Navigator.pushReplacementNamed(context, LoginPage.sName);
      }
      // Navigator.pushNamed(context, LoginPage.sName);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Image(
          image: AssetImage("assets/images/launch_image.png"),
          fit:BoxFit.cover
      ),
    );

  }

}
