

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fpc_inspect/com/openxu/demo/page_router.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context2) {


    //为了继承主题数据，widget需要位于MaterialApp内才能正常显示， 因此使用MaterialApp来运行该应用
    return new MaterialApp(
      //配置ThemeData类轻松更改应用程序的主题
        theme: new ThemeData(
          primaryColor: Colors.redAccent,
        ),
        //将具有指定Route的Map传递到顶层MaterialApp实例
        routes: PageRouter.myRoutes,

        home: new FunctionList()
    );
  }

}

class Functions{
  Functions({required this.name, required this.router});
  final String name;
  final String router;
}
class FunctionList extends StatelessWidget {

  final _fun_router = <Functions>[];

  //添加一个biggerFont变量来增大字体大小
  final _biggerFont = const TextStyle(fontSize: 18.0);
  FunctionList(){
    _fun_router.add(new Functions(name: "hello flutter", router: PageRouter.helloFlutter));
    _fun_router.add(new Functions(name: "随机单词", router: PageRouter.randomWords));
    _fun_router.add(new Functions(name: "购物车", router: PageRouter.shopList));
    _fun_router.add(new Functions(name: "动画淡入logo", router: PageRouter.animFade));
    _fun_router.add(new Functions(name: "动画1", router: PageRouter.animWidget));
    _fun_router.add(new Functions(name: "动画集合", router: PageRouter.animSet));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold( //Scaffold是Material中主要的布局组件.
      appBar: new AppBar(
        title: new Text("Flutter Cooker"),
      ),
      body: new ListView(
        padding: const EdgeInsets.all(16.0),
        children:_fun_router.map((Functions f){
          return new ListTile(
            //列表平铺的主要内容
            title: new Text(
              f.name,
              style: _biggerFont,
            ),
            //标题后显示的小部件
            trailing: new Icon(Icons.arrow_forward_ios),
            //当用户轻触此列表平铺时调用
            onTap: (){
              //使路由入栈（以后路由入栈均指推入到导航管理器的栈）
              Navigator.of(context).pushNamed(f.router, arguments: {"title":f.name});

            },
          );
        }).toList() ,
      ),
    );
  }


}