import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fpc_inspect/common/style/fpc_style.dart';
import 'package:fpc_inspect/pages/main_page.dart';
import 'package:fpc_inspect/router/routes.dart';

import 'pages/login/welcome_page.dart';

class FpcInspectApp extends StatefulWidget {
  @override
  _FpcInspectAppState createState() => _FpcInspectAppState();
}

class _FpcInspectAppState extends State<FpcInspectApp> {

  @override
  void initState() {
    super.initState();
    //状态栏和虚拟按键隐藏掉
    // SystemChrome.setEnabledSystemUIOverlays([]);

    //状态栏颜色透明
    // SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    // SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

    // deviceInfo();
    // print("初始化完毕");
  }


  @override
  Widget build(BuildContext context) {
    /// 使用 flutter_redux 做全局状态共享
    /// 通过 StoreProvider 应用 store
    //Material是一种标准的移动端和web端的视觉设计语言,
    // 为了继承主题数据，widget需要位于MaterialApp内才能正常显示， 因此使用MaterialApp来运行该应用
    return new MaterialApp(

        // this.title = '',                                // 设备用于为用户识别应用程序的单行描述
        // this.home,                                      // 应用程序默认路由的小部件,用来定义当前应用打开的时候，所显示的界面
        // this.color,                                     // 在操作系统界面中应用程序使用的主色。
        // this.routes = const <String, WidgetBuilder>{},  // 应用程序的顶级路由表
        // this.navigatorKey,                              // 在构建导航器时使用的键。
        // this.initialRoute,                              // 如果构建了导航器，则显示的第一个路由的名称
        // this.onGenerateRoute,                           // 应用程序导航到指定路由时使用的路由生成器回调
        // this.onUnknownRoute,                            // 当 onGenerateRoute 无法生成路由(initialRoute除外)时调用
        // this.navigatorObservers = const <NavigatorObserver>[], // 为该应用程序创建的导航器的观察者列表
        // this.builder,                                   // 用于在导航器上面插入小部件，但在由WidgetsApp小部件创建的其他小部件下面插入小部件，或用于完全替换导航器
        // this.onGenerateTitle,                           // 如果非空，则调用此回调函数来生成应用程序的标题字符串，否则使用标题。
        // this.locale,                                    // 此应用程序本地化小部件的初始区域设置基于此值。
        // this.localizationsDelegates,                    // 这个应用程序本地化小部件的委托。
        // this.localeListResolutionCallback,              // 这个回调负责在应用程序启动时以及用户更改设备的区域设置时选择应用程序的区域设置。
        // this.localeResolutionCallback,
        // this.supportedLocales = const <Locale>[Locale('en', 'US')],     // 此应用程序已本地化的地区列表
        // this.debugShowMaterialGrid = false,             // 打开绘制基线网格材质应用程序的网格纸覆盖
        // this.showPerformanceOverlay = false,            // 打开性能叠加
        // this.checkerboardRasterCacheImages = false,     // 打开栅格缓存图像的棋盘格
        // this.checkerboardOffscreenLayers = false,       // 打开渲染到屏幕外位图的图层的棋盘格
        // this.showSemanticsDebugger = false,             // 打开显示框架报告的可访问性信息的覆盖

        debugShowCheckedModeBanner: false,    //在选中模式下打开一个小的“DEBUG”横幅，表示应用程序处于选中模式

        //配置ThemeData类轻松更改应用程序的主题
        theme: new ThemeData(
          /*
          primaryColor只是状态栏颜色，它是primarySwatch一系列颜色中的一种通常等于primarySwatch [500]
          primarySwatch：主题颜色样本，某些材质组件可能会使用不同的primaryColor阴影来处理阴影,边框等…
           */
          primaryColor: FPCColors.colorPrimary,
          backgroundColor:FPCColors.yellow,   //与primaryColor形成对比的颜色，例如用作进度条的剩余部分
          dialogBackgroundColor:FPCColors.mainBackgroundColor,   //对话框背景颜色
          scaffoldBackgroundColor:FPCColors.mainBackgroundColor, //位于[Scaffold]下方的[Material]的默认颜色。典型材质应用程序或应用程序中页面的背景颜色。

          //主色，决定导航栏颜色
          /* primarySwatch: MaterialColor(0xffdb4527,
            <int, Color>{
              50: FPCColors.colorPrimary,
              100: FPCColors.colorPrimary,
              200: FPCColors.colorPrimary
            },),*/
          primarySwatch: FPCColors.primarySwatch, //主题颜色样本
          accentColor: FPCColors.colorAccent,//次级色，决定大多数Widget的颜色，如进度条、开关等
          brightness: Brightness.light,  //深色还是浅色

          splashColor:FPCColors.mainBackgroundColor,  // 墨水飞溅的颜色。InkWell
          dividerColor: FPCColors.colorLine,//分割线颜色
          dividerTheme: DividerThemeData(
            color: FPCColors.colorLine,
            space: FPCSize.lineHeight
          ),
          //按钮主题
          buttonTheme: ButtonThemeData(),
          //输入框光标颜色
          textSelectionTheme: TextSelectionThemeData(
              cursorColor: FPCColors.colorAccent),
          hintColor: FPCColors.subLightTextColor, //提示文本或占位符文本的颜色，例如在TextField中。
          // errorColor - Color类型，用于输入验证错误的颜色，例如在TextField中。
          iconTheme: IconThemeData(),      // Icon的默认样式
          // TargetPlatform platform, //指定平台，应用特定平台控件风格
          // fontFamily , //文字字体
          // primaryTextTheme: FPCStyle.normalText,
          ///Material design 文本主题。与其直接创建[TextTheme]，您可以获得一个实例，例如[Typeography.black]或[Typeography.white]。
          ///https://storage.googleapis.com/spec-host-backup/mio-design%2Fassets%2F1W8kyGVruuG_O8psvyiOaCf1lLFIMzB-N%2Ftypesystem-typescale.png
          ///https://material.io/design/typography/the-type-system.html#type-scale
          ///2018规范有十三种文字样式
          textTheme: TextTheme(
              headline6: FPCStyle.titleText,  //标题
              bodyText1:FPCStyle.normalText.copyWith(    //强调bodyText2的文本
                fontWeight: FontWeight.bold,
              ),
              //默认文本样式
              bodyText2:FPCStyle.normalText,
          ),

        ),
        //国际化
        localizationsDelegates: [
          // 本地化的代理类
          //为Material 组件库提供的本地化的字符串和其他值，它可以使Material 组件支持多语言
          GlobalMaterialLocalizations.delegate,
          //定义组件默认的文本方向，从左到右或从右到左，这是因为有些语言的阅读习惯并不是从左到右，比如如阿拉伯语就是从右向左的。
          GlobalWidgetsLocalizations.delegate,
        ],
        //应用支持的语言列表
        supportedLocales: [
          const Locale('en', 'US'), // 美国英语
          const Locale('zh', 'CN'), // 中文简体
          //其它Locales
        ],
        //Navigator.pushNamed(...)打开命名路由时如果路由表中没有注册，会调用onGenerateRoute来生成路由

        initialRoute:"/",    //初始路由名称
        ///命名式路由
        /// "/" 和 MaterialApp 的 home 参数一个效果
        // home:WelcomePage(),
        //Map<String, WidgetBuilder>? routes;
        routes:RouterUtil.getRouters(context),
        onGenerateRoute: _onGenerateRoute(),
       /* routes: {
          WelcomePage.sName: (context) {
            return WelcomePage();
          },
          LoginPage.sName: (context) {
            return LoginPage();
          },
        }*/
    );
  }

  ///命名路由时，如果注册路由表中没有对应的名称路由?，onGenerateRoute拦截
  _onGenerateRoute() => (RouteSettings settings){
        final String name = settings.name ?? "";
        final Function? builder = routes[name];
        print("路由------->  ${settings.name} ${settings.arguments}");

        if (name.endsWith(MainPage.sName)) {
          return MaterialPageRoute(builder: (context) {
            print("已经登录了，进入主页");
            return MainPage(); //主页
          });
        }

        ///统一参数传递处理，传递参数都通过构造函数
        if (builder == null) {
          print("路由不存在");
        } else if (settings.arguments != null) {
          print("传递参数${settings.arguments}");
          print("传递参数${settings.arguments.runtimeType}");
          return MaterialPageRoute(
              settings: settings,
              builder: (context) =>
                  builder(context, arguments: settings.arguments));
        } else {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) => builder(context));
        }
    /*
        LoginInfo? loginInfo;
        Global.getLoginInfo().then((value) => {
          loginInfo = value
        });

        if (loginInfo != null && loginInfo!.logined) {

        } else {
          // 如果访问的路由页需要登录，但当前未登录，则直接返回登录页路由，引导用户登录；其它情况则正常打开路由。
          return MaterialPageRoute(builder: (context) {
            print("还未登录，进入的登录页");
            return LoginPage();
          });
        }*/
      };


}
typedef MyWidgetBuilder = Widget Function(BuildContext context, {dynamic arguments});