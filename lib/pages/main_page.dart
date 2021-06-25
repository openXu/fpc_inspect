import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpc_inspect/pages/main/function/function_page.dart';
import 'package:fpc_inspect/pages/main/home_page.dart';
import 'package:fpc_inspect/pages/main/message_page.dart';

import 'main/person_page.dart';

///首页
///
///
///
class MainPage extends StatefulWidget {
  static final String sName = "/main_function";

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title : Text("首页"),
      // ),
      ///底部导航栏
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(backgroundColor: Colors.blue, icon: Icon(Icons.home),label : "任务"),
          BottomNavigationBarItem(backgroundColor: Colors.green, icon: Icon(Icons.message),label: "功能"),
          BottomNavigationBarItem(backgroundColor: Colors.amber, icon: Icon(Icons.shopping_cart), label : "消息"),
          BottomNavigationBarItem(backgroundColor: Colors.red, icon: Icon(Icons.person), label : "我的"),
        ],
        currentIndex: _currentIndex,
        fixedColor: Colors.blue,   //选中的颜色，如果不设置默认使用primaryColor
        // type: BottomNavigationBarType.shifting,  //花哨的模式
        type: BottomNavigationBarType.fixed,
        onTap: (index) {  //点击导航按钮切换页面
          if (index != _currentIndex) {
            setState(() {
              _currentIndex = index;
            });
          }
        },
      ),

      //
     /* bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞，shape决定洞的外形
        child: Row(
          children: [
            // BottomNavigationBarItem(backgroundColor: Colors.blue, icon: Icon(Icons.home),label : "任务"),
            // BottomNavigationBarItem(backgroundColor: Colors.green, icon: Icon(Icons.functions),label: "功能"),
            // BottomNavigationBarItem(backgroundColor: Colors.amber, icon: Icon(Icons.message), label : "消息"),
            // BottomNavigationBarItem(backgroundColor: Colors.red, icon: Icon(Icons.person), label : "我的"),
            IconButton(icon: Icon(Icons.home), onPressed: () { _pageChange(0); },),
            IconButton(icon: Icon(Icons.functions), onPressed: () {  _pageChange(1);  },),
            SizedBox(), //中间位置空出
            IconButton(icon: Icon(Icons.message), onPressed: () {  _pageChange(2);  },),
            IconButton(icon: Icon(Icons.person), onPressed: () {  _pageChange(3);  },),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
        ),
      ),
      //打洞的位置
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
*/
      body: pages[_currentIndex],
    );
  }

  _pageChange(int index){
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
    }
  }
  final pages = [HomePage(), FunctionPage(), MessagePage(), PersonPage()];

}

