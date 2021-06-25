import 'package:flutter/material.dart';

class FadeTradition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MyFadeTest(title: 'Fade Demo');
  }
}

class MyFadeTest extends StatefulWidget {
  MyFadeTest({required this.title});
  final String title;
  @override
  _MyFadeTest createState() => new _MyFadeTest();
}

class _MyFadeTest extends State<MyFadeTest> with TickerProviderStateMixin {
  late AnimationController controller;
  late CurvedAnimation curve;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    curve = new CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    var arguments = ModalRoute.of(context)?.settings.arguments;//获取传入的值
    print("传入参数$arguments");

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(arguments.toString()),
      ),
      body: new Center(
          child: new Container(
              child: new FadeTransition(
                  opacity: curve,
                  child: new FlutterLogo(
                    size: 100.0,
                  )))),
      floatingActionButton: new FloatingActionButton(
        tooltip: 'Fade',
        child: new Icon(Icons.brush),
        onPressed: () {
          controller.forward();
        },
      ),
    );
  }
}