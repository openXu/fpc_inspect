import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpc_inspect/common/style/fpc_style.dart';
import 'package:fpc_inspect/widgets/form/fpc_form_item_base.dart';
import 'package:fpc_inspect/widgets/form/fpc_form_item_enum.dart';
import 'package:fpc_inspect/widgets/form/fpc_form_item_error.dart';
import 'fpc_form_controller.dart';
import 'fpc_form_item_date.dart';
import 'fpc_form_item_input.dart';
import 'fpc_form_item_multinput.dart';
import 'models/Indicator.dart';
import 'package:fpc_inspect/widgets/form/form_config.dart';

/// 表单项item
///
///

///表单项控制器
typedef FormItemResult = Indicator Function();
class FormItemController{
  late FormResultCheck itemCheck;
  late FormItemResult itemResult;
  FormItemController();
  FormItemController.forItem(this.itemCheck, this.itemResult);
}

class FpcFormItem extends StatefulWidget {

  final bool _enable;
  final Indicator _indicator;
  final List<IndicatorEnum> _enumList = [];

  late final FormItemController itemController;

  FpcFormItem(this._indicator, this._enable){
    if("2" == _indicator.indicatortype){  //枚举
      try{
        List list = jsonDecode(_indicator.enumstrs!);
        List<IndicatorEnum> enums = List.generate(list.length,
                (index) => IndicatorEnum.fromJson(list[index]));
        _enumList.addAll(enums);
      }catch (e) {
        print("解析枚举列表错误$e");
      }
    }

    itemController = FormItemController();

  }
  bool checkItemResult() => itemController.itemCheck();

  Indicator getItemResult() => itemController.itemResult();

  @override
  _FpcFormItemState createState() => new _FpcFormItemState();
}

class _FpcFormItemState extends State<FpcFormItem> {

  IndicatorEnum? _selectedEnum;
  DateTime? _dateTime;
  bool _clickAble = false;    //item是否可点击
  bool _error = false;        //后台返回的指标数据是否有错误
  bool _isMultInput = false;  //是否是多行输入
  @override
  void initState() {
    print("initState初始化item控件");
    String? indicatortype = widget._indicator.indicatortype;
    String? datatype = widget._indicator.datatype;
    if("1" == indicatortype){   //输入
      if(datatype == FormConfig.DATATYPE_DATE ||
          datatype == FormConfig.DATATYPE_TIME ||
          datatype == FormConfig.DATATYPE_DATETIME){
        try {
          print("${widget._indicator.displayname} 默认值：${widget._indicator.defaultvalue}");
          _dateTime = DateTime.tryParse(widget._indicator.defaultvalue!);
        }catch(e){
          print("格式化默认日期错误:$e");
        }
      }
    }else if("2" == indicatortype){  //枚举
      try{
        _selectedEnum = widget._enumList[0];
      }catch (e) {
        print("解析枚举列表错误$e");
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    String? indicatortype = widget._indicator.indicatortype;
    String? datatype = widget._indicator.datatype;
    FormItemBase _itemWidget;
    if("1" == indicatortype){   //输入
      if(datatype == FormConfig.DATATYPE_MULTILINE){
        _isMultInput = true;
        _itemWidget = FormItemMultInput(widget._indicator, widget._enable);
      }else if(datatype == FormConfig.DATATYPE_DATE ||
          datatype == FormConfig.DATATYPE_TIME ||
          datatype == FormConfig.DATATYPE_DATETIME){
        _clickAble = true;
        _itemWidget = FormItemDate(widget._indicator, widget._enable, _dateTime);
      }else{
        _itemWidget = FormItemInput(widget._indicator, widget._enable);
      }
    }else if("2" == indicatortype){  //枚举
      _clickAble = true;
      _itemWidget = new FormItemEnum(widget._indicator, widget._enable, widget._enumList, _selectedEnum);
    }else{
      _error = true;
      _itemWidget = new FormItemError(widget._indicator, "错误的indicatortype指标类型${widget._indicator.indicatortype}");
    }
    ///初始化item控制器
    widget.itemController.itemCheck = _itemWidget.checkItemResult;
    widget.itemController.itemResult = _itemWidget.getItemResult;

    return Column(
        children:[
          ///item的标题部分
          SizedBox(
            height: FPCSize.formItemHight.toDouble(),  //确定的高度
            ///白色背景 + InkWell点击效果
            child: Ink(
                color: FPCColors.white, //使用Ink包裹，在这里设置颜色
                child: InkWell(
                  //可点击的item设置onTap事件，item点击时会有涟漪效果，如果设置为null则没有
                  onTap: _clickAble?() async{
                    if(_itemWidget is FormItemEnum) {
                      _selectedEnum = await (_itemWidget).click(context);
                      print("枚举项选择了：${_selectedEnum?.EnumValue}");
                      //选择刷新
                      setState(() { });
                    }
                    else if(_itemWidget is FormItemDate)
                      _dateTime = await (_itemWidget).click(context);
                      print("日期选择：${_dateTime.toString()}");
                      if(_dateTime!=null)//选择刷新
                        setState(() { });
                  }:null,
                  //非多行输入，左右排列
                  child: Padding(
                      padding: EdgeInsets.only(left: FPCSize.formSides),
                      child: Row(
                        children: [
                          ///item名称
                          Text("${_error?"⚠ ":""}${widget._indicator.displayname}",
                              style: _error ? FormConfig.formErrorTextStyle:FormConfig.formKeyTextStyle),

                          _isMultInput? SizedBox():
                          Expanded(
                            //flex弹性系数，0或null：child是没有弹性的，即不会被扩伸占用的空间
                            //如果大于0，所有的Expanded按照其flex的比例来分割主轴的全部空闲空间
                            flex: 1,
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: FPCSize.formSides, vertical: 0),
                                    child:_itemWidget
                                )
                            ),
                          ),
                        ],
                      )
                  ),
                )),
          ),
          ///item分割线
          !_isMultInput?Divider():
          // !isMultInput?SizedBox(height: FPCSize.lintHeight):
          ///多行输入框
          _itemWidget
        ]
    );
  }
}







