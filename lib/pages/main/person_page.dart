import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpc_inspect/common/style/fpc_style.dart';
import 'package:fpc_inspect/common/util/sp_storage.dart';
import 'package:fpc_inspect/config/Global.dart';
import 'package:fpc_inspect/mixin/login.dart';
import 'package:fpc_inspect/widgets/fpc_button.dart';

import '../login_page.dart';

///我的
///
///
///
class PersonPage extends StatefulWidget {
  static final String sName = "/main_Person";

  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  bool hadInit = false;

  String text = "";
  double fontSize = 76;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Text("我的"),
      ),
      body:Padding(
        padding: const EdgeInsets.only(top: 35),
        child: FpcButton(
            text:"退出登录",
            fontSize: 16,
            color: FPCColors.red,
            onPress: (){
              SpLocalStorage.clearData();
              Navigator.pushReplacementNamed(context, LoginPage.sName);
            }
        ),
      ),
    );
  }


}
