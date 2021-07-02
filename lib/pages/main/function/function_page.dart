import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpc_inspect/common/style/fpc_style.dart';
import 'package:fpc_inspect/config/Global.dart';
import 'package:fpc_inspect/models/UserPermission.dart';
import 'package:fpc_inspect/pages/chart/echartsSample/echarts_main.dart';
import 'package:fpc_inspect/pages/chart/flutter_echarts_custom.dart';
import 'package:fpc_inspect/pages/chart/flutter_echarts_test.dart';
import 'package:fpc_inspect/pages/chart/web_view_page.dart';
import 'package:fpc_inspect/pages/check/task_page.dart';
import 'package:fpc_inspect/pages/login/login_mixin.dart';
import 'package:fpc_inspect/pages/other/bind/bind_page.dart';
import 'package:fpc_inspect/router/routes.dart';
import 'package:fpc_inspect/widgets/fpc_ripple_item.dart';

///功能
///
///
///
class FunctionPage extends StatefulWidget {
  static final String sName = "/main_function";

  @override
  _FunctionPageState createState() => _FunctionPageState();
}

class _FunctionPageState extends State<FunctionPage>  with Login{

  ///滚动控制器，用于控制和监听滚动位置
  ScrollController _scrollController = new ScrollController();

  final _moduleList = <FunctionModule>[];
  final _spanCount = 3;

  @override
  void initState() {
    super.initState();
    //解析权限数据
    _parsePermissionData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
      appBar: AppBar(
        // backgroundColor: Colors.transparent, //把appbar的背景色改成透明
        title : Text("功能", style: TextStyle(fontSize: 16)),
        // titleTextStyle: TextStyle(fontSize: 13),
        centerTitle: true,
        elevation: 1,//appbar的阴影
      ),

      body: RefreshIndicator(
          onRefresh: () async {
            await getUserPermission(context, showLoading: false);
            //解析权限数据
            await _parsePermissionData();
          },
          ///builder系列构造方法用于构建列表项目比较多或者无限的情况
          child: StaggeredGridView.countBuilder(
              shrinkWrap: true, //表示是否根据子组件的总长度来设置ListView的长度，默认值为false 。默认情况下，ListView的会在滚动方向尽可能多的占用空间。当ListView在一个无边界(滚动方向上)的容器中时，shrinkWrap必须为true。
              controller: _scrollController,
              crossAxisCount: _spanCount,    //横轴子元素的数量，确定每个单元格的尺寸=横轴宽度（屏幕宽度）/4
              itemCount: _moduleList.length,
              mainAxisSpacing: 1,  //主轴方向的间距
              crossAxisSpacing: 1,  //横轴方向子元素的间距
              itemBuilder: (context, index) {
                return FunctionItemWidget(_moduleList[index], (module){
                  if(module.navigation.isEmpty){
                    Fluttertoast.showToast(msg: "功能暂未开放");
                    return;
                  }
                  Navigator.of(context).pushNamed(module.navigation, arguments:module.arguments);
                  print("点击${module.name}  ${module.navigation}");
                });
              },
            //决定每个item的宽高
            staggeredTileBuilder: (index) =>
              //★ count：主轴横轴为固定数量子元素的layout算法
              //crossAxisCellCount:横轴占据的单元数
              //mainAxisCellCount:主轴占用的单元数
              //StaggeredTile.count(2, index.isEven ? 2 : 1),
              //★ extent：横轴子元素为固定最大长度的layout算法
              //横轴上占据的单元格数、主轴上占用的像素数
              // StaggeredTile.extent(2, 100),
              //★ fit：主轴item包裹内容，纵轴上的数量
              StaggeredTile.fit(
                  _moduleList[index].type==FunctionModule.TYPE_TITLE?_spanCount:1),

          ),

        ),
      );
  }

  ///解析权限数据
  _parsePermissionData() async {

    List<UserPermission>? userPermission = await Global.getUserPermission();

    ///TODO 图表测试入口
    userPermission?.forEach((element) {
      if (element.component == PermissionComponent.level1_function) { //找到功能模块
        List<UserPermission> newList = [];
        List<UserPermission> chartList = [];
        chartList.add(new UserPermission(1, "webview", "WebView", "平台组件webview", "", "", null));
        chartList.add(new UserPermission(1, "flutterEcharts", "flutterEchart", "flutterEchart插件示例", "", "", null));
        chartList.add(new UserPermission(1, "echarts_test", "echart测试", "echaert测试", "", "", null));
        chartList.add(new UserPermission(1, "echarts_custom", "echart自定义", "echart自定义", "", "", null));
        chartList.add(new UserPermission(1, "chart_4", "饼状图", "饼状图", "", "", null));
        UserPermission chartTitle = new UserPermission(2, "chart", "图表", "", "", "", chartList);
        newList.add(chartTitle);
        newList.addAll(element.children!);
        element.children = newList;
      }
    });

    print("解析用户权限：$userPermission");
    userPermission?.forEach((element) {
      if(element.component == PermissionComponent.level1_function){ //找到功能模块
        _moduleList.clear();
        for (var titleEntry in element.children!) { //功能二级分类
          //标题
          _moduleList.add(FunctionModule(FunctionModule.TYPE_TITLE,
              titleEntry.component??"",
              titleEntry.name??"",
              titleEntry.descrip??""));
          print("添加标题：==================${titleEntry.name}");
          var span = 0;
          for (var moduleEntry in titleEntry.children!) {     //功能三级功能模块
            var module = FunctionModule(FunctionModule.TYPE_CONTENT,
                moduleEntry.component??"",
                moduleEntry.name??"",
                moduleEntry.descrip??"");
            _setModel(module);
            print("添加功能：--${moduleEntry.name} ${moduleEntry.component}");
            _moduleList.add(module);
            span ++;
          }
          //为上一个模块补齐
          if(span>0 && span % _spanCount>0) {
            //缺多少个
            int que = _spanCount - span % _spanCount;
            print("---该模块一共$span个功能，每行$_spanCount，最后一行需要补充$que个");
            for (var i = 0; i < que; i++) {
              _moduleList.add(FunctionModule(FunctionModule.TYPE_OTHER,"", "", ""));
            }
          }
        }
      }

      setState(() {
         //刷新界面
      });
    });
  }

  _setModel(FunctionModule module) {

    switch(module.component){

    /**图表测试  chart*/
      case "webview":
        _setModel1(module, null, WebViewPage.sName);
        break;
      case "flutterEcharts":
        _setModel1(module, null, EchartsMain.sName);
        break;
      case "echarts_test":
        _setModel1(module, null, EchartsTest.sName);
        break;
      case "echarts_custom":
        _setModel1(module, null, EchartsCustom.sName);
        break;
      case "chart_4":
        _setModel1(module, null, CheckTaskList.sName);
        break;
     /**安全检查  exam*/
      case PermissionComponent.level3_rwdj:
        _setModel1(module, "assets/images/res_icon_func_xfjd_xttx.png", CheckTaskList.sName);
        break;
     /**其他*/
      case PermissionComponent.level3_sbbd:  //设备绑定
        _setModel1(module, "assets/images/res_icon_func_xfjd_xttx.png", BindCode.sName, map: {"bindType":1});
        break;
      case PermissionComponent.level3_qybd:  //区域绑定
        _setModel1(module, "assets/images/res_icon_func_xfjd_xttx.png", BindCode.sName, map: {"bindType":2});
        break;
    //     UserPermission.level3_dddj -> {  //督导管控--督导登记
    // setModel(module, R.mipmap.res_icon_func_xfjd_xttx, RouterPathSv.PAGE_SV_LIST, null)
    // }
    // /**双控预防  dp*/
    // UserPermission.level3_fxda -> {  //风险档案
    // val bundle = Bundle()
    // bundle.putInt("status", 0)
    // setModel(module, R.mipmap.res_icon_func_aqzy_zyrwcx, RouterPathRisk.PAGE_RISK_LIST, bundle)
    // }
    // UserPermission.level3_jcsq -> {   //解除申请
    // val bundle = Bundle()
    // bundle.putInt("status", 1)
    // setModel(module, R.mipmap.res_icon_func_zhyw_dhzzf, RouterPathRisk.PAGE_RISK_LIST, bundle)
    // }
    // UserPermission.level3_jcsp ->{  //解除审批
    // val bundle = Bundle()
    // bundle.putInt("status", 2)
    // setModel(module, R.mipmap.res_icon_func_aqzy_zyrwsh, RouterPathRisk.PAGE_RISK_LIST, bundle)
    // }
    // /**安全检查  exam*/
    // UserPermission.level3_rwdj ->setModel(module, R.mipmap.res_icon_func_dqrw_gfjc, RouterPathCheck.PAGE_TASKLIST, null)  //任务登记
    // /**检查整改  proc*/
    // UserPermission.level3_zgcx ->{  //整改查询
    // setModel(module, R.mipmap.res_icon_func_zhtyw_sgrwcx, RouterPathDanger.PAGE_RECTIFY_LIST, null)
    // }
    // UserPermission.level3_zgxd ->setModel(module, R.mipmap.res_icon_func_yhcl_zgxd, RouterPathDanger.PAGE_ADD_RECTIFY, null)  //整改下单
    // UserPermission.level3_zgdj ->{  //整改登记
    // val bundle = Bundle()
    // bundle.putBoolean("operator", true)
    // setModel(module, R.mipmap.res_icon_func_jczg_zgdj, RouterPathDanger.PAGE_RECTIFY_LIST, bundle)
    // }
    // /**其他*/ // TODO 缺少图标设计，使用的其他图标顶替的
    // UserPermission.level3_wdzz ->setModel(module, R.mipmap.res_icon_func_wxxfz_rygl, RouterPathMultiple.PAGE_MYDUTY, null)  //我的职责
    // UserPermission.level3_sbbd ->{   //设备绑定  //之前的设备标签绑定RouterPathEquipment.PAGE_SELECTLABLE
    // val bundle = Bundle()
    // bundle.putInt("bindType", 1)
    // setModel(module, R.mipmap.res_icon_func_zhyw_sbbqbd, RouterPathMultiple.PAGE_BINDING, bundle)
    // }
    // UserPermission.level3_qybd ->{   //区域绑定    //替换之前的RouterPathMultiple.PAGE_AREABINDING
    // val bundle = Bundle()
    // bundle.putInt("bindType", 2)
    // setModel(module, R.mipmap.res_icon_func_qt_qybd, RouterPathMultiple.PAGE_BINDING, bundle)
    // FLog.w("当前单位id  ${mViewModel.user.orgId}")
    // }
    // UserPermission.level3_zsk ->setModel(module, R.mipmap.res_icon_func_zsk_zsk, RouterPathMultiple.PAGE_KNOWLEDGE, null)  //知识库

    }

  }
  _setModel1(FunctionModule module, String? icon, String navigation, {Map<String, Object>? map}){
      module.icon = icon;
      module.navigation = navigation;
      //添加标题
      module.arguments = {RouteArgs.TITLE:module.name};
      if(map!=null)
        module.arguments!.addAll(map);
  }

}


///功能模块封装
class FunctionModule{
  //0：标题   1：功能模块
  static const TYPE_TITLE = 1;
  static const TYPE_CONTENT = 2;
  static const TYPE_OTHER = 3;
  final int type;
  //后台返回
  final String component;  //映射字段  effect
  final String name;       //模块名  功能
  final String descrip;    //说明
  //本地设置
  String? icon;             //图片
  int? cornerNumber;     //消息数
  String navigation = "";
  Map<String, Object>? arguments;

  FunctionModule(
      this.type,
      this.component,
      this.name,
      this.descrip); //路由
  // Bundle? bundle;        //数据传递
}


///功能item widget
///
///
///
class FunctionItemWidget extends StatelessWidget {

  final FunctionModule _module;
  final Function(FunctionModule module) _onTap;
  FunctionItemWidget(this._module, this._onTap, { Key? key }): super(key: key);

  @override
  Widget build(BuildContext context) {
    if(_module.type == FunctionModule.TYPE_TITLE){   //功能大模块标题
      return Container(
        // color: Colors.redAccent,
        child: Padding(
          padding: EdgeInsets.only(left: 12, top: 10, bottom: 10),
          child: Text(_module.name,
              style: FPCStyle.normalText.copyWith(
                  fontSize: FPCSize.tsBig
              )
          ),
        ),
      );
    }else{   //功能内容 或者 凑数的
      return FpcRippleItem(
        padding: EdgeInsets.only(top: 15, bottom: 8),
        itemClick: (){
          if(_module.type == FunctionModule.TYPE_CONTENT){
            // Scaffold.of(context).showSnackBar(new SnackBar(
            //   content: new Text('Tap'),
            // ));
            _onTap(_module);
          }
        },
        itemView:Column(
          textDirection:TextDirection.ltr,
          mainAxisSize:MainAxisSize.min,  //尽可能少的占用主轴空间
          mainAxisAlignment:MainAxisAlignment.start,
          verticalDirection: VerticalDirection.down, //从上到下
          crossAxisAlignment:CrossAxisAlignment.center,  //纵轴（水平）居中
          children: [
            SizedBox(        //限制图片尺寸
              width: 40,
              height: 40,
              child: _module.type == FunctionModule.TYPE_CONTENT?
              Image(
                  image: AssetImage(_module.icon??"assets/images/icon_fun_def.png"),
                  fit:BoxFit.fill    //图片填充
              ):null,
            ),
            SizedBox(height:8),
            Text(_module.type == FunctionModule.TYPE_CONTENT?_module.name:"",
                maxLines: 1,
                style: TextStyle(
                  color: FPCColors.mainTextColor,
                  fontSize: FPCSize.tsNormal,
                  height:1.1,    //解决Text中英文数字高度不一致的问题
                )),
            SizedBox(height:4),
            Text(_module.type == FunctionModule.TYPE_CONTENT?_module.descrip:"",
                maxLines: 1,
                style: TextStyle(
                  color: FPCColors.subTextColor,
                  fontSize: FPCSize.tsSmall,
                  height:1.1,    //解决Text中英文数字高度不一致的问题
                )),
          ],
        )
      );

    }
  }
}
