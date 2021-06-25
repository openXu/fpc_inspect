//★使用示例：通过一个逐渐放大的动画显示logo
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(new AnimWidget());
}

//由于动画会使UI变化，所以应该使用StatefulWidget
class AnimWidget extends StatefulWidget {
  _LogoAppState createState() => new _LogoAppState();
}

class _LogoAppState extends State<AnimWidget> with SingleTickerProviderStateMixin {
  //将Animation对象存储为Widget的成员，然后使用其value值来决定如何绘制
  late Animation<double> animation;
  late AnimationController controller;
  @override
  initState() {
    super.initState();
    //1. 创建动画控制器
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    //2. 将动画施加在double类型数值上，得到一个动画对象，并设置监听
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addStatusListener((status) {
        // AnimationStatus.completed
        // AnimationStatus.reverse
        // AnimationStatus.dismissed
        print("$status");
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      })
      ..addListener(() {  //..级联调用，也就是连续调用
        setState(() {  //4. 动画执行时，setState()会触发build()方法刷新UI
        });
      });
    controller.forward();  //3. 开始执行动画
  }

  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        height: animation.value, //5. 在build()中，改变container大小
        width: animation.value,
        child: new FlutterLogo(),
      ),
    );
  }

  dispose() {
    //6. 动画完成时释放控制器(调用dispose()方法)以防止内存泄漏。
    controller.dispose();
    super.dispose();
  }
}