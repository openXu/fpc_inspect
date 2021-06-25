import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class AnimSet extends StatefulWidget {
  _LogoAppState createState() => new _LogoAppState();
}

class _LogoAppState extends State<AnimSet> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  initState() {
    super.initState();
    //1. 创建往复执行的动画，这个动画会被多个估值器使用
    controller = new AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    animation = new CurvedAnimation(parent: controller, curve: Curves.easeIn);
    //往复执行
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();  //开始
  }

  Widget build(BuildContext context) {
    return new AnimatedLogo(animation: animation);
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}
class AnimatedLogo extends AnimatedWidget {
  //2. 多个动画估值器
  static final _opacityTween = new Tween<double>(begin: 0.1, end: 1.0);
  static final _sizeTween = new Tween<double>(begin: 0.0, end: 300.0);

  AnimatedLogo({required Animation<double> animation})
      : super(listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return new Center(
      child: new Opacity(
        //通过各个估值器计算动画当前的值
        opacity: _opacityTween.evaluate(animation),  //3. 控制child透明度的动画
        child: new Container(
          margin: new EdgeInsets.symmetric(vertical: 10.0),
          height: _sizeTween.evaluate(animation),  //4. 控制child大小的动画
          width: _sizeTween.evaluate(animation),
          child: new FlutterLogo(),
        ),
      ),
    );
  }
}
void main() {
  runApp(new AnimSet());
}