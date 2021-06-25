import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpc_inspect/common/style/fpc_style.dart';

/// 自定义按钮
///
/// FpcButton(
///     text:"登录",    //按钮文字
///     fontSize: FPCStyle.normalTextSize,  //文字大小，默认正常大小
///     color: FPCColors.red,   //按钮颜色
///     onPress: _login     //点击事件
///   )
/// 
class FpcButton extends StatelessWidget {

  late final String text;
  late final Color textColor;
  late final double fontSize;
  late final Color color;
  //文字显示位置
  late final AlignmentGeometry alignment;
  //点击事件
  late final VoidCallback onPress;

  FpcButton(
      { required this.text,
        this.textColor = Colors.white,
        this.fontSize = FPCSize.tsNormal,
        this.color = FPCColors.red,
        required this.onPress,
        this.alignment = Alignment.center});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style:ButtonStyle(
          alignment:alignment,    //Text在中间
          backgroundColor: ButtonStyleButton.allOrNull<Color>(color),  //背景色
          // overlayColor: ButtonStyleButton.allOrNull<Color>(FPCColors.green),  // 高亮色，按钮处于focused, hovered, or pressed时的颜色
          // shadowColor: ButtonStyleButton.allOrNull<Color>(FPCColors.blue),  // 阴影颜色
          elevation: ButtonStyleButton.allOrNull<double>(2),// 阴影值
          // 最小尺寸，宽度无限大（填充）
          minimumSize:ButtonStyleButton.allOrNull<Size>(Size(double.infinity, 10)),
          // 按钮尺寸：高度45
          fixedSize: ButtonStyleButton.allOrNull<Size>(Size.fromHeight(45)),
          //Text小部件子体大小，颜色请通过下面的foregroundColor设置
          textStyle: ButtonStyleButton.allOrNull<TextStyle>(new TextStyle(fontSize: fontSize)),
          //字体颜色
          foregroundColor:ButtonStyleButton.allOrNull<Color>(textColor),
          //child与按钮的空隙
          padding: ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(
              new EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0, bottom: 10.0)),
          shape: ButtonStyleButton.allOrNull(    //形状
            RoundedRectangleBorder(//圆角矩形
                borderRadius: BorderRadius.all(Radius.circular(6.0)))),
          animationDuration:Duration(milliseconds:100), //[shape]和[elevation]的动画更改的持续时间。
          enableFeedback:true,// 检测到的手势是否应提供声音和/或触觉反馈。例如，在Android上，点击会产生咔哒声，启用反馈后，长按会产生短暂的振动。通常，组件默认值为true。
        ),
        onPressed: onPress,
        /*        onPressed: () {
            this.onPress?.call();
          }*/
        child:Text(text)

    );
  }


}
