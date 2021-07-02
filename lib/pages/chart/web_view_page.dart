import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fpc_inspect/router/routes.dart';
import 'package:fpc_inspect/widgets/fpc_widget_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

///规范检查--检查项列表
///
///
///
class WebViewPage extends StatefulWidget {
  static final String sName = "/web_view_page";
  final Map<String, Object> _arguments;
  WebViewPage(this._arguments);
  @override
  _WebViewPageState createState() => _WebViewPageState();

}

class _WebViewPageState extends State<WebViewPage> {

  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FpcWidgetUtils.getApp(context, widget._arguments[RouteArgs.TITLE]?.toString()??""),
      body: WebView(
        // initialUrl: 'https://flutter.dev',
        //要显示的url
        initialUrl: getAssetsPath('assets/files/echarts.html'),
        //JS执行模式 是否允许JS执行 默认是不调用
        javascriptMode: JavascriptMode.unrestricted,
          //JS可以调用Flutter
          // javascriptChannels: ,
      //     拦截请求
      // navigationDelegate
      // 手势
      // gestureRecognizers
      // 页面加载完成
      //     onPageFinished
        //WebView创建完成时调用
        onWebViewCreated: (WebViewController webViewController) {
          _webViewController = webViewController;
          // _webViewController.evaluateJavascript(javascriptString)
          // _loadHtmlFromAssets();
        },
      ),
    );
  }
  ///获取打包后的资源文件实际路径
  ///如assets/files/index.html
  String getAssetsPath(String path) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'file:///android_asset/flutter_assets/' + path;
    } else {
      //https://www.jianshu.com/p/0d0ebb663f55 IOS不支持加载本地文件
      return 'file://Frameworks/App.framework/flutter_assets/' + path;
    }
  }

}