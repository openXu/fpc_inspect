import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpc_inspect/common/style/fpc_style.dart';

/// 自定义appbar
///
///
class FpcAppBar extends StatelessWidget {

  late final Widget title; //标题文本
  // Widget? leading,   //左侧显示的图标 通常首页显示的为应用logo 在其他页面为返回按钮
  // List<Widget>? actions, //右侧item
  //bottom 一个 AppBarBottomWidget 对象，通常是 TabBar。用来在 Toolbar 标题下面显示一个 Tab 导航栏
  //backgroundColor AppBar背景色
  //brightness AppBar亮度 有黑白两种主题
  // iconTheme AppBar上图标的样式
  // actionsIconTheme AppBar上actions图标的样式
  // textTheme AppBar上文本样式
  // centerTitle 标题是否居中
  // titleSpacing 标题与其他控件的空隙
  // toolbarOpacity AppBar tool区域透明度
  // bottomOpacity bottom区域透明度

  FpcAppBar( this.title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //左边图标
      leading: new IconButton(
        icon: new Icon(Icons.arrow_back_ios),
        onPressed: () => {
          Navigator.of(context).pop('刷新')
        },
      ),
      // color: FPCColors.red,
      title : title,
      // titleTextStyle:TextStyle(
      //   fontSize: FPCSize.tsTitle,
      // ),
      centerTitle: true,
    );
  }


}
