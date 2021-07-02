import 'dart:async';
import 'dart:io' show Platform;

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fpc_inspect/widgets/fpc_widget_utils.dart';

///
///
///


class FpcBarCodeScan extends StatelessWidget {
  static final String sName = "/other_fpcbarcode_scan";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FpcWidgetUtils.getApp(context, "扫码"),
      body: _CodeContent(),
    );
  }
}

class _CodeContent extends StatefulWidget {
  @override
  _CodeContentState createState() => _CodeContentState();
}

class _CodeContentState extends State<_CodeContent>  {

  //创建Flutter平台客户端
  static const platform = const MethodChannel('fpc.flutter.io/qrcode');

  String code = "";

  @override
  void initState() {
    _scan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("扫码结果:$code"),
    );


  }

  Future _scan() async {
    code = await platform.invokeMethod('scan');
    setState(() {

    });
  }

}

