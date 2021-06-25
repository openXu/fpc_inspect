import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpc_inspect/common/style/fpc_style.dart';
import 'package:fpc_inspect/config/Global.dart';

/// 点击带涟漪效果的item

///
///

class FpcRippleItem extends StatelessWidget {
  final Widget itemView;             //item视图
  final VoidCallback? itemClick;         //点击事件
  final EdgeInsetsGeometry? padding; //自定义padding
  const FpcRippleItem(
    {
    Key? key,
    this.padding,
    required this.itemView,
    this.itemClick,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Ink(
        color: FPCColors.white, //使用Ink包裹，在这里设置颜色
        child: InkWell(
          onTap: itemClick,
          child: Padding(
            //item四边的间隙
            padding: padding??
                EdgeInsets.symmetric(horizontal: FPCSize.pageSides, vertical: FPCSize.itemSides),
            child: itemView,
          ),
        ));
  }
}
