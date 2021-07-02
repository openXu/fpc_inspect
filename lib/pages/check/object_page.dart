import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fpc_inspect/common/net/http_manager.dart';
import 'package:fpc_inspect/common/style/fpc_style.dart';
import 'package:fpc_inspect/common/util/LogUtil.dart';
import 'package:fpc_inspect/config/api_service.dart';
import 'package:fpc_inspect/pages/check/models/CheckTask.dart';
import 'package:fpc_inspect/widgets/fpc_refresh_loadmore.dart';
import 'package:fpc_inspect/widgets/fpc_ripple_item.dart';
import 'package:fpc_inspect/widgets/fpc_widget_utils.dart';

import 'form_page.dart';
import 'models/CheckObject.dart';

///规范检查--检查项列表
///
///
///
class CheckObjectList extends StatelessWidget {
  static final String sName = "/check_object_list";
  final CheckTask _task;
  CheckObjectList(this._task);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FpcWidgetUtils.getApp(context, _task.TaskName??""),
      ///使用自定义下拉上拉列表页
      body: RefreshLoadmore<CheckObject>(
          divider: Divider(),
          onLoadData: (pageNo, pageSize) async {
            return await _getObjectList(pageNo, pageSize);
          },
          itemBuilder: (context, obj) {
            return FpcRippleItem(
              padding: EdgeInsets.all(FPCSize.pageSides),
              itemView:_itemView(context, obj),
              itemClick: (){
                print("点击了${obj.taskobjectname}");
                Navigator.of(context).pushNamed(CheckFormPage.sName, arguments:obj);
              },
            );
          }),
    );
  }

  ///构建item视图
  Widget _itemView(BuildContext context, CheckObject obj){
    return Row(
      children: [
        Expanded(
          //flex弹性系数，0或null：child是没有弹性的，即不会被扩伸占用的空间
          //如果大于0，所有的Expanded按照其flex的比例来分割主轴的全部空闲空间
          flex: 1,
          child: Text(obj.taskobjectname??""),
        ),
        Text("${obj.examindicatorcount}/${obj.totalindicatorcount}",
            style: FPCStyle.middleText),
        Icon(Icons.keyboard_arrow_right, color:FPCColors.subTextColor, size: 19),
      ],
    );
  }

  ///请求规范检查任务数据
  Future<List<CheckObject>?> _getObjectList(int pageNo, int pageSize) async {
    Map<String, dynamic> requestParams = {
      "pageno": pageNo,
      "pagesize": pageSize,
      "taskid": _task.taskid??""
    };
    var response =
    await httpManager.get(ApiService.URL_CHECK_OBJECT_LIST, requestParams);
    if (response.success) {
      //List<Map>
      List list = (response.result["records"] as List);
      List<CheckObject> objList = List.generate(list.length,
              (index) => CheckObject.fromJson(list[index]));
      LogUtil.v("获取规范检查项 $objList");
      return objList;
    }
    return null;
  }

}
