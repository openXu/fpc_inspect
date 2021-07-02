import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpc_inspect/common/net/http_manager.dart';
import 'package:fpc_inspect/common/style/fpc_style.dart';
import 'package:fpc_inspect/common/util/LogUtil.dart';
import 'package:fpc_inspect/common/util/common_utils.dart';
import 'package:fpc_inspect/config/Global.dart';
import 'package:fpc_inspect/config/api_service.dart';
import 'package:fpc_inspect/pages/other/bind/models/EqBind.dart';
import 'package:fpc_inspect/router/routes.dart';
import 'package:fpc_inspect/widgets/fpc_refresh_loadmore.dart';
import 'package:fpc_inspect/widgets/fpc_ripple_item.dart';
import 'package:fpc_inspect/widgets/fpc_search.dart';
import 'package:fpc_inspect/widgets/fpc_widget_utils.dart';
import 'barcode_scan_page.dart';
import 'fpc_barcode_scan_page.dart';
import 'nfc_page.dart';

/// 设备绑定
///
///
// ignore: must_be_immutable
class EqBindCode extends StatelessWidget {
  static final String sName = "/other_eq_bind";

  late final String _title;
  late final int _codeType;    //标签码类型 0-条形码 1-二维码 2-rfid码
  late final String _codeTypeStr;
  final Map<String, Object> _arguments;

  String _nameorcode = ""; //设备编码或名称
  String _region = ""; //区域id拼接 或者 空（全部区域）
  String _classid = ""; //设备类型id拼接 或者 空（全部类型）

  final EdgeInsetsGeometry topItempaddingFirst = const EdgeInsets.only(left: FPCSize.pageSides);
  final EdgeInsetsGeometry topItempaddingLast = const EdgeInsets.only(right: FPCSize.pageSides);
  final EdgeInsetsGeometry topItempadding = const EdgeInsets.all(0);


  // BindCode(this._title, this._bindType);
  EqBindCode(this._arguments) {
    _title = _arguments[RouteArgs.TITLE]?.toString() ?? "";
    _codeType = _arguments["codeType"]! as int;
    if(_codeType == 0){
      _codeTypeStr = "条形码";
    }else if(_codeType == 1){
      _codeTypeStr = "二维码";
    }else if(_codeType == 2){
      _codeTypeStr = "RFID码";
    }
  }

  @override
  Widget build(BuildContext context) {

    ListStateController _topController1 = new ListStateController();
    ListStateController _topController2 = new ListStateController();
    ListStateController _listController = new ListStateController();

    return Scaffold(
        appBar: FpcWidgetUtils.getApp(context, _title),
        ///Column中嵌套ListView时，必须在ListView外包裹一层以确定其高度，否则无法计算ListView的高度
        body: Column(
          children: [
            ///搜索
            FpcSearch(
              hintText: "请输入设备编码或名称",
              search: (text){
                _nameorcode = text;
                //控制刷新（搜索后根据字符串刷新）
                _listController.refresh();
              },
            ),
            ///设备类型
            TopList<EqType>(
              loadData: () async {
                return await _getEqTypeList();
              },
              itemBuilder: (context, data, isFirst, isLast) {
                return _topItemView(context, data.classname ?? "", _classid == data.classid, isFirst, isLast, () {
                  if (data.classid != _classid) {
                    _classid = data.classid!;
                    _topController1.refresh(); //让ListView刷新
                    _listController.refresh();
                  } else {
                    print("点击相同的了");
                  }
                });
              },
              controller: _topController1,
            ),

            ///区域
            TopList<Region>(
              loadData: () async {
                return await _getRegionList();
              },
              itemBuilder: (context, data, isFirst, isLast) {
                return _topItemView(context, data.regionname ?? "", _region == data.regionid, isFirst, isLast, () {
                  if (data.regionid != _region) {
                    _region = data.regionid!;
                    _topController2.refresh();
                    _listController.refresh();
                  } else {
                    print("点击相同的了");
                  }
                });
              },
              controller: _topController2,
            ),

            ///避免Column嵌套listview报错，尺寸计算的问题
            Expanded(
                child: RefreshLoadmore<Equepment>(
                    divider: Divider(),
                    onLoadData: (pageNo, pageSize) async {
                      return await _getEqList(pageNo, pageSize);
                    },
                    itemBuilder: (context, equepment) {
                      return FpcRippleItem(
                        itemView: _itemView(context, equepment),
                        itemClick: () {
                          codeScan(context, equepment);
                        },
                      );
                    },
                    stateController:_listController,
                )
            ),
          ],
        ));
  }

  ///请求数据👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
  ///请求设备类型
  Future<List<EqType>?> _getEqTypeList() async {
    Map<String, dynamic> requestParams = {
      "companyid": (await Global.getLoginInfo())?.userInfo?.orgId, //组织机构ID
    };
    var response =
        await httpManager.get(ApiService.URL_EQBIND_TYPE_LIST, requestParams);
    if (response.success) {
      List<EqType> datalist = [];
      datalist.add(EqType.defaultType(classname: "全部类型"));
      //List<Map>
      List list = (response.result as List);
      datalist.addAll(
          List.generate(list.length, (index) => EqType.fromJson(list[index])));
      LogUtil.v("请求设备类型 $datalist");
      return datalist;
    }
    return null;
  }

  ///获取区域标签列表
  Future<List<Region>?> _getRegionList() async {
    Map<String, dynamic> requestParams = {
      "companyid": (await Global.getLoginInfo())?.userInfo?.orgId, //组织机构ID
      "parentid": "0000000000000000000", //父级节点idparentid 固定为0000000000000000000
    };
    var response =
        await httpManager.get(ApiService.URL_EQBIND_REGION_LIST, requestParams);
    if (response.success) {
      List<Region> datalist = [];
      datalist.add(Region.defaultType(regionname: "全部区域"));
      //List<Map>
      List list = (response.result as List);
      datalist.addAll(
          List.generate(list.length, (index) => Region.fromJson(list[index])));
      LogUtil.v("获取区域标签列表 $datalist");
      return datalist;
    }
    return null;
  }

  ///请求设备列表
  Future<List<Equepment>?> _getEqList(int pageNo, int pageSize) async {
    Map<String, dynamic> requestParams = {
      "pageno": pageNo,
      "pagesize": pageSize,
      "companyid": (await Global.getLoginInfo())?.userInfo?.orgId, //组织机构ID
      "nameorcode": _nameorcode, //设备编码或名称
      "region": _region, //区域id拼接 或者 空（全部区域）
      "classid": _classid, //设备类型id拼接 或者 空（全部类型）
    };
    var response =
        await httpManager.get(ApiService.URL_EQBIND_EQ_LIST, requestParams);
    if (response.success) {
      //List<Map>
      List list = (response.result["records"] as List);
      List<Equepment> eqList = List.generate(
          list.length, (index) => Equepment.fromJson(list[index]));
      LogUtil.v("获取设备列表 $eqList");
      return eqList;
    }
    return null;
  }

  ///跟换code
  Future<String?> _changeCode(BuildContext context, String equipmentid, String code, String type) async {
    CommonUtils.showLoading(context);
    Map requestParams = {
      "equipmentid": equipmentid,
      "code" : code,
      "type" : type
    };
    //await调用异步请求，等待请求结果
    var response = await httpManager.post(ApiService.URL_EQBIND_CHANGE_CODE,
        json.encode(requestParams));
    print("返回结果:$response");
    // 隐藏loading框
    Navigator.of(context).pop();
    if (response.success) {
      return response.message;
    }
    return null;
  }

  ///item构建👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
  ///构建顶部item视图
  Widget _topItemView(BuildContext context, String text, bool checked,
      bool isFirst, bool isLast, Function() onItemClick) {
    return GestureDetector(
      onTap: onItemClick,
      child: Container(
        // color: Colors.blue,
        constraints: BoxConstraints(
            minHeight: double.infinity //高度无限大，也就是横向ListView外层设置的最大高度，请见TopList
            ),
        child: Center(
          child: Padding(
              padding: isFirst
                  ? topItempaddingFirst
                  : (isLast ? topItempaddingLast : topItempadding),
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: checked
                          ? FPCColors.mainBackgroundColor
                          : Colors.transparent),
                  child: Text(text,
                      style: FPCStyle.middleText.copyWith(
                          color: checked
                              ? FPCColors.red
                              : FPCColors.mainTextColor)))),
        ),
      ),
    );
  }

  ///构建item视图
  Widget _itemView(BuildContext context, Equepment equepment) {
    String status = "";
    //标签码类型 0-二维码 1-条形码 2-rfid码
    if ((_codeType == 0 && equepment.qrcode != null) ||
        (_codeType == 1 && equepment.barcode != null) ||
        (_codeType == 2 && equepment.rfidcode != null)) {
      status = "已绑定";
    }
    return Stack(
      alignment: AlignmentDirectional.centerEnd, //绑定状态 靠右居中
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(equepment.equipmentname ?? ""),
          SizedBox(height: FPCSize.itemRowSpace),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            //     CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
            children: [
              Text("设备编码", style: FPCStyle.middleText),
              SizedBox(width: 15),
              Text(CommonUtils.getChineseWestern(equepment.equipmentcode),
                  style: FPCStyle.middleText.copyWith(
                    color: FPCColors.mainTextColor,
                  )),
            ],
          ),
          SizedBox(height: FPCSize.itemRowSpace),
          Row(
            children: [
              Text("所在区域", style: FPCStyle.middleText),
              SizedBox(width: 15),
              Text(CommonUtils.getChineseWestern(equepment.regionname),
                  style: FPCStyle.middleText
                      .copyWith(color: FPCColors.mainTextColor)),
            ],
          ),
        ]),
        status.isEmpty
            ? Text("")
            : Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 3),
                decoration: BoxDecoration(
                    //删除按钮装饰
                    borderRadius: BorderRadius.circular(5),
                    color: FPCColors.green),
                child: Text(
                  status,
                  style: FPCStyle.middleText.copyWith(color: FPCColors.white),
                ))
      ],
    );
  }

  void codeScan(BuildContext context, Equepment equepment) async {
    print("点击了${equepment.equipmentname}");
    Object? resultCode;
    if(_codeType == 0){
      resultCode = await Navigator.of(context).pushNamed(BarCodeScan.sName);
    }else if(_codeType == 1){
      resultCode = await Navigator.of(context).pushNamed(FpcBarCodeScan.sName);
    }else if(_codeType == 2){
      resultCode = await Navigator.of(context).pushNamed(NfcRead.sName);
      print("收到NFC返回值：$resultCode");
    }
    if(resultCode==null || resultCode.toString().isEmpty)
      return;
    String msg = "";
    if(equepment.rfidcode==null || equepment.rfidcode!.isEmpty){
      msg = "是否关联如下$_codeTypeStr标签?\n序列号：$resultCode";
    }else if(equepment.rfidcode == resultCode){
      Fluttertoast.showToast(msg: "该$_codeTypeStr标签和设备$_codeTypeStr相同");
      return;
    }else{
      msg = "当前设备已有$_codeTypeStr标签，是否使用如下$_codeTypeStr标签替换？\n序列号：$resultCode";
    }

    showDialog<bool>(context: context,
        builder: (context) {
      return AlertDialog(
        title: Text("提示"),
        content: Text(msg),
        actions: <Widget>[
          TextButton(
            child: Text("取消"),
            onPressed: () => Navigator.of(context).pop(), //关闭对话框
          ),
          TextButton(
            child: Text("确定"),
            onPressed: () {
              Navigator.of(context).pop(true); //关闭对话框
              _changeCode(context, equepment.id??"", resultCode.toString(), _codeType.toString());
            },
          ),
        ],
      );
    });

  }


}

///顶部横向列表(设备类型 & 区域)
typedef ItemBuilder<D> = Widget Function(
    BuildContext context, D t, bool isFirst, bool isLast);
typedef RequestData<D> = Future<List<D>?> Function();


class TopList<T> extends StatefulWidget {
  final RequestData<T> loadData;
  final ItemBuilder<T> itemBuilder;
  final ListStateController controller;

  TopList(
      {required this.loadData,
      required this.itemBuilder,
      required this.controller});

  @override
  _TopListState<T> createState() => _TopListState<T>();
}

class _TopListState<D> extends State<TopList<D>> {
  var _datas = <D>[];
  @override
  void initState() {
    print("2设置刷新回调${widget.controller}");
    //刷新回调
    widget.controller.refresh = () {
      setState(() {});
    };
    _loadData();
    super.initState();
  }

  _loadData() async {
    List<D>? dataList = await widget.loadData();
    print("刷新加载数据：$dataList");
    if (dataList != null) {
      _datas.addAll(dataList);
      setState(() {
        _datas = List.of(_datas);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ///Column中嵌套ListView时，必须在ListView外包裹一层以确定其高度，否则无法计算ListView的高度
    return Container(
      height: 40,
      color: FPCColors.white,
      child: Center(
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics:
              BouncingScrollPhysics(), //ClampingScrollPhysics：Android下微光效果。 BouncingScrollPhysics：iOS下弹性效果。
          // shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          itemCount: _datas.length,
          //分割线
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: 30,
            );
          },
          //item生成
          itemBuilder: (context, index) {
            return widget.itemBuilder(
                context, _datas[index], index == 0, index == _datas.length - 1);
          },
        ),
      ),
    );
  }
}
