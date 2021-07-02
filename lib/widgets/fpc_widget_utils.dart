import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpc_inspect/common/style/fpc_style.dart';

class FpcWidgetUtils {

  static getApp(BuildContext context, String title){
    return AppBar(
      title: Text(title, style: TextStyle(fontSize: 16)),
      centerTitle: true,
      //左边图标
      leading: new IconButton(
        icon: new Icon(Icons.arrow_back_ios),
        onPressed: () => {
          Navigator.of(context).pop('返回数据')
        },
      ),
    );
  }



}
