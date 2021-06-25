import 'dart:convert';
import 'dart:typed_data';
//Key和material包中Key类名冲突，可以给加密包取别名，这样调用包中的类时都要通过 别名encrypt.
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:encrypt/encrypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fpc_inspect/config/Global.dart';
import 'package:fpc_inspect/common/style/fpc_style.dart';
import 'package:fpc_inspect/mixin/login.dart';
import 'package:fpc_inspect/widgets/fpc_button.dart';
import 'package:fpc_inspect/widgets/fpc_input.dart';

import 'main_page.dart';

///登录页面
class LoginPage extends StatefulWidget{
  static final String sName = "/login";
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>  with Login{

  TextEditingController _unameController = new TextEditingController(
  );
  TextEditingController _pwdController = new TextEditingController();

  bool _pwdShow = false; //密码是否显示明文
  GlobalKey _formKey = new GlobalKey<FormState>();
  bool _nameAutoFocus = true;

  @override
  void initState() {
    _initData();
    super.initState();
  }

  _initData() async{
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    _unameController.text = (await Global.getLoginInfo())?.userInfo?.username??"";

    if (_unameController.text.isNotEmpty)
      _nameAutoFocus = false;
    _unameController.text = "cyf95";
    _pwdController.text = "123456";
  }

  @override
  Widget build(BuildContext context) {
    /// 触摸收起键盘
    return new GestureDetector(
      onTap: () {//点击
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      ///Scaffold 是 Material library 中提供的一个widget, 它提供了默认的导航栏、标题和包含主屏幕widget树的body属性
      child: Scaffold(
        body:Container(
            ///防止overFlow的现象
          child: SafeArea(
            ///Stack层叠布局
            child: Stack(children: [
              ///更换域名
              Positioned(
                top: 5.0, //状态栏下5pt
                left: 12.0,
                child: Text("域名"),
              ),
              ///居中
              Center(
                child: ///同时弹出键盘不遮挡
                SingleChildScrollView(
                  //左右边距
                  child:Padding(
                    padding: new EdgeInsets.only(
                        left: 30.0, top: 0, right: 30.0, bottom: 0.0),
                    child: Column(
                      mainAxisAlignment:MainAxisAlignment.center,   //
                      mainAxisSize:MainAxisSize.min,  //垂直方向包裹内容
                      children: [
                        Image(
                          image: AssetImage("images/icon_logo.png"),
                        ),
                        SizedBox(height: 10),//保留间距10
                        Text("安全生产管理系统", style: FPCStyle.normalText.copyWith(
                          fontSize: FPCSize.tsBig
                        )),
                        SizedBox(height: 4),

                        Text("安全管理", style: FPCStyle.normalText.copyWith(
                          color: FPCColors.red,
                        )),
                        SizedBox(height: 4),
                        Text("v1.0.0", style: FPCStyle.middleText,),
                        SizedBox(height: 50),

                        Form(
                          key: _formKey,
                          // autovalidate: true,
                          ///垂直布局（向下）
                          child: Column(
                            children: <Widget>[
                              ///用户名输入框
                              FpcInput(
                                hintText: "请输入用户名/手机号",
                                prefixIcon: Icon(Icons.person, color:Theme.of(context).primaryColor, size: 23),
                                // border : UnderlineInputBorder(borderSide: BorderSide(color: FPCColors.colorPrimary)),
                                controller: _unameController,
                                validator: (v) {   //校验时，如果错误提示不为null，输入框下划线会变为红色
                                  return v!.trim().isNotEmpty ? null : "用户名不能为空";
                                }
                              ),
                              ///红色横线
                              SizedBox(
                                width: double.infinity,
                                height: 1,
                                child: Container(color: FPCColors.red),
                              ),
                              ///密码输入框
                              SizedBox(height: 15),
                              FpcInput(
                                  obscureText: !_pwdShow,   //是否隐藏明文
                                  hintText:"请输入密码",
                                  keyboardType: TextInputType.visiblePassword,
                                  enterType: TextInputAction.send,
                                  enterAction:(str){
                                    _login();//回车登录
                                  },
                                  prefixIcon: Icon(Icons.lock,
                                      color:Theme.of(context).primaryColor, size: 25),
                                  suffixIcon: IconButton(  //后面的图片
                                    icon: Icon( _pwdShow ? Icons.visibility_off : Icons.visibility,
                                        color:Theme.of(context).primaryColor, size: 25),
                                    onPressed: () {
                                      setState(() {
                                        _pwdShow = !_pwdShow;
                                      });
                                    },
                                  ),
                                  controller: _pwdController,
                                  validator: (v) {
                                    return v!.trim().isNotEmpty ? null : "密码不能为空";
                                  }
                              ),
                              ///红色横线
                              SizedBox(
                                width: double.infinity,
                                height: 1,
                                child: Container(color: FPCColors.red),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 35),
                                child: FpcButton(
                                  text:"登录",
                                  fontSize: 16,
                                  color: FPCColors.red,
                                  onPress: _login
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ])
          ),
        ),
      )
    );
  }

  ///登录
  _login() async {
    // 提交前，先验证各个表单字段是否合法
    if ((_formKey.currentState as FormState).validate()) {
      FocusScope.of(context).unfocus(); //收起键盘
      //等待异步调用结果
      var result = await onLogin(context, _unameController.text, _pwdController.text);
      print("登录：${await Global.getLoginInfo()}");
      if(!result)
        return;
      result = await getUserPermission(context);
      print("获取用户权限：${await Global.getUserPermission()}");
      if(!result)
        return;
      print("登录完成，进入主页面");
      Navigator.pushReplacementNamed(context, MainPage.sName);
    }
  }

}


