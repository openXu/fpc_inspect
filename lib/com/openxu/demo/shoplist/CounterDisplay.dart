import 'package:flutter/material.dart';

/**
 * 创建了两个新的无状态widget的！清晰地分离了
 * 显示 计数器（CounterDisplay）
 * 更改 计数器（CounterIncrementor）的逻辑。
 * 尽管最终效果与前一个示例相同，但责任分离允许将复杂性逻辑封装在各个widget中，同时保持父项的简单性。
 */
class CounterDisplay extends StatelessWidget {
  CounterDisplay({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return new Text('Count: $count');
  }
}

class CounterIncrementor extends StatelessWidget {
  CounterIncrementor({required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
      onPressed: onPressed,
      child: new Text('Increment'),
    );
  }
}

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => new _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    //在Flutter的响应式风格的框架中，调用setState() 会为State对象触发build()方法，从而导致对UI的更新
    setState(() {
      ++_counter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Row(children: <Widget>[
      new CounterIncrementor(onPressed: _increment),
      new CounterDisplay(count: _counter),
    ]);
  }
}