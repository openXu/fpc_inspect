import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpc_inspect/pages/chart/echartsSample/echarts_main.dart';
import 'package:fpc_inspect/pages/chart/flutter_echarts_custom.dart';
import 'package:fpc_inspect/pages/chart/flutter_echarts_test.dart';
import 'package:fpc_inspect/pages/chart/web_view_page.dart';
import 'package:fpc_inspect/pages/check/form_page.dart';
import 'package:fpc_inspect/pages/check/object_page.dart';
import 'package:fpc_inspect/pages/check/task_page.dart';
import 'package:fpc_inspect/pages/login/login_page.dart';
import 'package:fpc_inspect/pages/other/bind/barcode_scan_page.dart';
import 'package:fpc_inspect/pages/other/bind/bind_page.dart';
import 'package:fpc_inspect/pages/other/bind/equepment_bind_page.dart';
import 'package:fpc_inspect/pages/other/bind/fpc_barcode_scan_page.dart';
import 'package:fpc_inspect/pages/other/bind/nfc_page.dart';
import 'package:fpc_inspect/pages/login/welcome_page.dart';


class RouteArgs{
  static const String TITLE = "title";
}


var routes = {
  WelcomePage.sName:(context) => WelcomePage(),
  LoginPage.sName:(context,{arguments})=>LoginPage(),
  ///图表
  WebViewPage.sName:(context,{arguments}) => WebViewPage(arguments),
  EchartsMain.sName:(context,{arguments}) => EchartsMain(),
  EchartsTest.sName:(context,{arguments}) => EchartsTest(arguments),
  EchartsCustom.sName:(context,{arguments}) => EchartsCustom(arguments),

  ///规范检查
  CheckTaskList.sName:(context,{arguments}) => CheckTaskList(arguments),
  CheckObjectList.sName:(context,{arguments}) => CheckObjectList(arguments),
  CheckFormPage.sName:(context,{arguments}) => CheckFormPage(arguments),

  ///标签绑定
  BindCode.sName:(context,{arguments}) => BindCode(arguments),
  EqBindCode.sName:(context,{arguments}) => EqBindCode(arguments),
  NfcRead.sName:(context,{arguments}) => NfcRead(),
  BarCodeScan.sName:(context,{arguments}) => BarCodeScan(),
  FpcBarCodeScan.sName:(context,{arguments}) => FpcBarCodeScan(),

  //定义route的时候就定义好跳转到当前页面需要接受参数
  //'/login':(context,{arguments})=>TestLogin(arguments: arguments,),
};


List<Map<String,dynamic>> _routerList = [
  {
    "path":WelcomePage.sName,
    "view":WelcomePage(),
  },
  {
    "path":LoginPage.sName,
    "view":LoginPage(),
  },
  /* {
      "path":"/changeLanguage",
      "view":ChangeLanguage(),
    },*/
];

class RouterUtil {

  static Map<String,Widget Function(BuildContext)> _routers = {};

  ///获取路由表<路由名称, 构建路由widget的函数>
  static Map<String,Widget Function(BuildContext)> getRouters(BuildContext context){
    if(_routers.isNotEmpty)
      return _routers;
    for(var router in _routerList){
      _routers[router["path"]] = (context)=>router["view"];
    }
    return _routers;
  }

  static Route anim<T>(BuildContext context, String name, {String mode = 'slide'}) {
    Map<String, Widget Function(BuildContext)> routers = getRouters(context);
    if (routers.containsKey(name)) {
      //在真正路由widget外面包裹一层动画widget
      return _AnimateRouter(routers[name]!(context), mode);
    } else {
      throw FormatException("未寻找到命名路由");
    }
  }

/*  RouterUtil.pushNamed(BuildContext context, String name,
      {String mode = 'slide', dynamic argument = ''}) {
    Map<String, Widget Function(BuildContext)> routers = getRouters(context);
    if (routers.containsKey(name)) {
      setArgument(argument);
      //在真正路由widget外面包裹一层动画widget
      Navigator.of(context).push(AnimateRouter(routers[name]!(context), mode));
    } else {
      throw FormatException("未寻找到命名路由");
    }
  }

  RouterUtil.pushReplacementNamed(BuildContext context, String name,
      {String mode = 'slide', dynamic argument = ''}) {
    Map<String, Widget Function(BuildContext)> routers = getRouters(context);
    if (routers.containsKey(name)) {
      setArgument(argument);
      Navigator.of(context).pushReplacement(AnimateRouter(routers[name]!(context), mode));
    } else {
      throw FormatException("未寻找到命名路由");
    }
  }

  RouterUtil.pushNamedAndRemoveUntil(BuildContext context, String name,
      {String mode = 'slide', dynamic argument = ''}) {
    Map<String, Widget Function(BuildContext)> routers = getRouters(context);
    if (routers.containsKey(name)) {
      setArgument(argument);
      Navigator.of(context).pushAndRemoveUntil(
          AnimateRouter(routers[name]!(context), mode), (route) => false);
    } else {
      throw FormatException("未寻找到命名路由");
    }
  }*/
}


class _AnimateRouter extends PageRouteBuilder {
  final Widget _widget;
  final String _mode;

  _AnimateRouter(this._widget, this._mode)
      : super(
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (BuildContext context, Animation<double> animation1,
          Animation<double> animation2) {
        return _widget;
      },
      transitionsBuilder: (BuildContext context,
          Animation<double> animation1,
          Animation<double> animation2,
          Widget child) {
        Widget routerWidget;
        switch (_mode) {
          case 'fade':
            routerWidget = FadeTransition(
              child: child,
              opacity: Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(parent: animation1, curve: Curves.linear)),
            );
            break;
          case 'scale':
            routerWidget = ScaleTransition(
              child: child,
              scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  parent: animation1, curve: Curves.linear)),
            );
            break;
          case 'rotation':
            routerWidget = RotationTransition(
              child: child,
              turns: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  parent: animation1, curve: Curves.linear)),
            );
            break;
          case 'rotationScale':
            routerWidget = RotationTransition(
              child: ScaleTransition(
                child: child,
                scale: Tween(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                        parent: animation1, curve: Curves.linear)),
              ),
              turns: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  parent: animation1, curve: Curves.linear)),
            );
            break;
          // case 'slide':
          default:
            routerWidget = SlideTransition(
              child: child,
              position: Tween<Offset>(
                  begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                  .animate(CurvedAnimation(
                  parent: animation1, curve: Curves.ease)),
            );
            break;
        }
        return routerWidget;
      });
}
