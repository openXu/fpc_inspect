import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///消息
///
///
///
class MessagePage extends StatefulWidget {
  static final String sName = "/main_Message";

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Text("消息"),
      ),
    );
  }


}
