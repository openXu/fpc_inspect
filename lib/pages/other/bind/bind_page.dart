
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fpc_inspect/common/style/fpc_style.dart';
import 'package:fpc_inspect/router/routes.dart';
import 'package:fpc_inspect/widgets/fpc_widget_utils.dart';

import 'equepment_bind_page.dart';

/// 1设备绑定 & 2区域绑定
///
///
class BindCode extends StatelessWidget {
  static final String sName = "/other_bind_code";

  // final String _title;
  late final int _bindType; //绑定类型  1：设备绑定  2:区域绑定
  final Map<String, Object> _arguments;
  // BindCode(this._title, this._bindType);
  BindCode(this._arguments){
    _bindType = _arguments["bindType"]! as int;
  }

  @override
  Widget build(BuildContext context) {
    //获取路由参数
    var args = ModalRoute.of(context)?.settings.arguments;
    print("参数title : $args");
    return Scaffold(
      appBar: FpcWidgetUtils.getApp(context, _arguments[RouteArgs.TITLE]?.toString()??""),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _getBtn(context, 1, "二维码扫描", "关联二维码", Color(0xfffd6399), "assets/images/multiple_code_type_qrcode.png"),
          _getBtn(context, 0, "条形码扫描", "关联条形码", Color(0xff21c4b3), "assets/images/multiple_code_type_barcode.png"),
          _getBtn(context, 2, "NFC扫描", "关联RFID", Color(0xfff79332), "assets/images/multiple_code_type_nfccode.png"),
        ],
      ),
    );
  }

  Widget _getBtn(BuildContext context, int codeType,String text, String title ,Color color, String image){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      child: GestureDetector(
        onTap: (){
          Map<String, Object> _arguments = {};
          _arguments[RouteArgs.TITLE] = title;
          _arguments["codeType"] = codeType;
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return _bindType==1?
              EqBindCode(_arguments):
              EqBindCode(_arguments);
          }));
          // pushNamed(CheckObjectList.sName, arguments:task);
        },
        child: AspectRatio(              //宽高比为1，保持正方形
          aspectRatio: 3.48,
          child:Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.fill
              ),
            ),
            alignment: Alignment.center,
            child: Text(text, style: FPCStyle.normalText.copyWith(
                color:color
            ),),
          ),
        ),
      ),
    );
  }
}

