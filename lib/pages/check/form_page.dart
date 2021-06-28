import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpc_inspect/common/net/http_manager.dart';
import 'package:fpc_inspect/common/style/fpc_style.dart';
import 'package:fpc_inspect/common/util/LogUtil.dart';
import 'package:fpc_inspect/config/api_service.dart';
import 'package:fpc_inspect/widgets/form/fpc_form.dart';
import 'package:fpc_inspect/widgets/form/fpc_form_controller.dart';
import 'package:fpc_inspect/widgets/form/models/Indicator.dart';
import 'package:fpc_inspect/widgets/fpc_attr.dart';
import 'package:fpc_inspect/widgets/fpc_button.dart';

import 'models/CheckItems.dart';
import 'models/CheckObject.dart';

///规范检查--检查表单
///
///
///
class CheckFormPage extends StatelessWidget {
  static final String sName = "/check_form";

  final CheckObject _obj;
  late final FpcFormController _formController;
  CheckFormPage(this._obj){
    _formController = new FpcFormController(requestData:_getFormData,);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(_obj.taskobjectname??"", style: TextStyle(fontSize: 16)),
        centerTitle: true,
        //左边图标
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize : MainAxisSize.min,
        children: [
          ///hint提示
          Container(
            color: FPCColors.mainBackgroundColor,
            width: double.infinity,  //宽度填充屏幕（无限）
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: FPCSize.pageSides, vertical: FPCSize.itemSides),
              child: Text("请填写以下数据，然后点击提交完成任务", style: FPCStyle.smallText),
            ),
          ),
          ///表单+附件
          Expanded(
            flex: 1,
              child:CustomScrollView(
                slivers:<Widget>[
                 SliverToBoxAdapter(
                    child:FpcForm(
                      formController: _formController,
                    )
                  ),

                  FpcAttr(editAble:true, sliver: true)
                 ]
              ),
            ),
          ///提交按钮
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: FpcButton(
                text:"确认提交",
                color: FPCColors.red,
                onPress: _submit
            ),
          ),
        ],
      ),

    );
  }

  ///请求规范检查任务数据
  Future<List<Indicator>> _getFormData() async {
    Map<String, dynamic> requestParams = {
      "taskobjectid": _obj.taskobjectid??""
    };
    List<Indicator> taskitem = [];
    var response =
    await httpManager.get(ApiService.URL_CHECK_ITEM_LIST, requestParams);
    if (response.success) {
      CheckItems items = CheckItems.fromJson(response.result);
      LogUtil.v("获取规范检查项 $items");
      if(items.taskitem!=null)
        taskitem.addAll(items.taskitem!);
    }
    return taskitem;
  }

  ///提交
  _submit() async {
    if(_formController.checkResult()) {
      List<Indicator> list = await _formController.formResult();
      String json = jsonEncode(list);
      print("表单结果：$json");
    }else{
      print("请检查表单");
      Fluttertoast.showToast(
          msg: "请完成表单后提交",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          // backgroundColor: Colors.red,
          // textColor: Colors.white,
          fontSize: 13.0
      );
    }
  }




}
