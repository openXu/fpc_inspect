import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fpc_inspect/common/net/http_manager.dart';
import 'package:fpc_inspect/common/style/fpc_style.dart';
import 'package:fpc_inspect/common/util/LogUtil.dart';
import 'package:fpc_inspect/config/Global.dart';
import 'package:fpc_inspect/config/api_service.dart';
import 'package:fpc_inspect/pages/check/models/CheckTask.dart';
import 'package:fpc_inspect/pages/check/models/CheckTaskPage.dart';
import 'package:fpc_inspect/pages/check/object_page.dart';
import 'package:fpc_inspect/router/routes.dart';
import 'package:fpc_inspect/widgets/fpc_refresh_loadmore.dart';
import 'package:fpc_inspect/widgets/fpc_ripple_item.dart';

///规范检查--任务列表
///
///
///
class CheckTaskList extends StatelessWidget {
  static final String sName = "/check_task_list";


  final String _title;
  CheckTaskList(this._title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title, style: TextStyle(fontSize: 16)),
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
      body: RefreshLoadmore<CheckTask>(
          firstPage: 1,
          pageSize: 20,
          divider: Divider(),
          onLoadData: (pageNo, pageSize) async {
            return await _getTaskList(pageNo, pageSize);
          },
          itemBuilder: (context, task) {
            return FpcRippleItem(
              itemView:_itemView(task),
              itemClick: (){
                print("点击了${task.TaskName}");
                // Navigator.of(context).pushNamed(CheckObjectList.sName, arguments:task);
                // Navigator.of(context).push(RouterUtil.anim(context, CheckObjectList.sName), arguments:task);
                Navigator.of(context).pushNamed(CheckObjectList.sName, arguments:task);
              },
            );
          }),
    );
  }

  ///构建任务item视图
  Widget _itemView(CheckTask task){
    return Column(    //列
      crossAxisAlignment: CrossAxisAlignment.start, //水平方向上靠左边
      children: [
        Text(task.TaskName ?? ""),
        //任务名称，默认正常字体样式，已经在主题bodyText2设置，所以不用特意设置
        SizedBox(height: FPCSize.itemRowSpace),
        Row(
          //行
          children: [
            Text("时间  ", style: FPCStyle.middleText),
            Text("${task.taskstarttime}至${task.taskendtime}",
                style: FPCStyle.middleText.copyWith(
                    color: FPCColors.mainTextColor //修改中等文本颜色
                )),
          ],
        ),
        SizedBox(height: FPCSize.itemRowSpace),
        Row(
          children: [
            Text("进度  ", style: FPCStyle.middleText),
            Text(task.progress ?? "",
                style: FPCStyle.middleText.copyWith(
                    color: FPCColors.mainTextColor //修改中等文本颜色
                )),
          ],
        )
      ],
    );
  }

  ///请求规范检查任务数据
  Future<List<CheckTask>?> _getTaskList(int pageNo, int pageSize) async {
    Map<String, dynamic> requestParams = {
      "pageno": pageNo,
      "pagesize": pageSize,
      "taskcode": "", //任务编码
      "taskname": "", //任务名称
      "userid": (await Global.getLoginInfo())?.userInfo?.id, //任务执行人
    };
    var response =
    await httpManager.get(ApiService.URL_CHECK_TASK_LIST, requestParams);
    LogUtil.v("获取规范检查任务 $response");
    if (response.success) {
      CheckTaskPage taskPage = CheckTaskPage.fromJson(response.result);
      LogUtil.v(
          "获取规范检查任务列表第${taskPage.current}页，${taskPage.size}条数据, 总共${taskPage.total}");
      return taskPage.records;
    }
    return null;
  }

}
