import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

///
///
///
class NfcRead extends StatelessWidget {
  static final String sName = "/other_nfc_read";

  // final String _title;
  // BindNfc(this._title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NFC", style: TextStyle(fontSize: 16)),
        centerTitle: true,
        //左边图标
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          onPressed: () => {
            Navigator.of(context).pop('返回数据')
          },
        ),
      ),
      ///使用自定义下拉上拉列表页
      body: _NFCContent(),
    );
  }
}

class _NFCContent extends StatefulWidget {
  @override
  _NFCContentState createState() => _NFCContentState();
}

class _NFCContentState extends State<_NFCContent>  {

  bool _isSupportNFC = false;
  //创建Flutter平台客户端
  static const platform = const MethodChannel('fpc.flutter.io/nfc');
  static const eventChannel = const EventChannel('fpc.flutter.io/nfcstream');
  String _nfcResult = '';

  @override
  void initState() {
    ///是否支持nfc
    _supportNFC().then((value) {
      if(value){
        //开始读NFC
        _readNFCOnce();
      }
      setState(() {
        _isSupportNFC = value;
      });
    });

    // FlutterNfcReader.checkNFCAvailability()

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isSupportNFC) {
      return Center(
        child:Text("该设备不支持NFC"),
      );
    }

    return Center(
      child: Image(image: AssetImage("assets/images/lib_icon_nfc_rfid.png")),
    );

    /*return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        new RaisedButton(
          child: new Text('开始读取nfc'),
          onPressed: _readNFCOnce,
        ),
        new RaisedButton(
          child: new Text('一直读取nfc'),
          onPressed: _readNFC,
        ),
        new RaisedButton(
          child: new Text('停止读取nfc'),
          onPressed: _stopNfc,
        ),
        new Text(_nfcResult),
      ],
    );*/
  }


  ///自定义NFC插件
  Future<bool> _supportNFC() async {
    return await platform.invokeMethod('supportNFC');
  }
  Future _readNFCOnce() async {
    print("开始读nfc，等待结果");
    _nfcResult = await platform.invokeMethod('readNFCOnce');
    //返回扫描结果
    print("返回扫描结果$_nfcResult");
    // await platform.invokeMethod('stopNfc');   //关闭会导致重复响应
    Navigator.of(context).pop(_nfcResult);

    // setState(() {
    // });
  }
  Future _stopNfc() async {
    await platform.invokeMethod('stopNfc');
    setState(() {
      _nfcResult = "";
    });
  }
  _readNFC() {
    if(defaultTargetPlatform==TargetPlatform.android){
    }else{
      // if (Platform.isIOS) {
      //   _callRead(instruction: instruction);
      // }
      Fluttertoast.showToast(msg: "请实现ios端NFC功能");
    }
    eventChannel.receiveBroadcastStream()
        .listen((data){
          print("Flutter收到平台端发来的nfc消息：$data");
          _nfcResult = data;
          setState(() {});
        }, onError: (obj, stackTrace){
          print("错误");
        });
  }


}

