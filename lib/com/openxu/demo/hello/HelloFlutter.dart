import 'package:flutter/material.dart';

class HelloFlutter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Hello"),
      ),
      body: new Center(
        child: new Text('Hello World'),
      ),
    );

  }

}


