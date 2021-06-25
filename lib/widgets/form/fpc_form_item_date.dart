import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpc_inspect/common/style/fpc_style.dart';
import 'package:fpc_inspect/pages/check/models/CheckItems.dart';

import 'fpc_form_item_base.dart';
import 'models/Indicator.dart';

/// 自定义输入组件
/// 
///
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fpc_inspect/common/style/fpc_style.dart';
import 'package:fpc_inspect/widgets/form/form_config.dart';

import '../fpc_input.dart';
import 'fpc_form.dart';
import 'fpc_form_item_base.dart';
import 'models/Indicator.dart';

/// 表单--日期 弹窗
///
///

typedef FormDataClick = Future<DateTime?> Function(BuildContext context);

class FormItemDate extends FormItemBase {

  final bool _enable;
  final Indicator _indicator;
  final DateTime? _dateTime;
  late final FormDataClick click;
  FormItemDate(this._indicator, this._enable, this._dateTime){
    click = (context){
      return _showDateTimeDialog(context);
    };
  }
  @override
  bool checkFormResult() {
    return _dateTime!=null;
  }

  @override
  Indicator getFormResult() {
    String value = _date2Str(_dateTime)??"";
    _indicator.datavalue = value;
    _indicator.datatext = value;
    _indicator.isnormal = isNormal()? 1 : 0;  //是否正常值(0,否;1,是)'
    return _indicator;
  }
  @override
  bool isNormal() {
    return true;
  }

  @override
  Widget build(BuildContext context) {

    return DecoratedBox(
      decoration: BoxDecoration(/*color: Colors.red*/),
      child: Text(_date2Str(_dateTime)??""),
    );
  }

  ///三种类型日期选择对话框
  Future<DateTime?> _showDateDialog(BuildContext context) async {
    DateTime _nowDate = DateTime.now();
    DateTime? dateTime = await showDatePicker(
        context: context,
        initialDatePickerMode:DatePickerMode.day,
        initialDate: _nowDate, //初始化显示的日期
        firstDate: DateTime(2019),
        lastDate: DateTime(2022));
    return dateTime;
  }
  Future<TimeOfDay?> _showTimeDialog(BuildContext context) async {
    return await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now());
  }
  Future<DateTime?> _showDateTimeDialog(BuildContext context) async {
    if(_indicator.datatype == FormConfig.DATATYPE_DATE){   //日期
      return _showDateDialog(context);
    }else if(_indicator.datatype == FormConfig.DATATYPE_TIME){  //时间
      TimeOfDay? timeOfDay = await _showTimeDialog(context);
      if(timeOfDay==null)
        return null;
      final now = new DateTime.now();
      return new DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    }else if(_indicator.datatype == FormConfig.DATATYPE_DATETIME){  //日期+时间
      DateTime? dateTime = await _showDateDialog(context);
      if(dateTime==null)
        return null;
      TimeOfDay? timeOfDay = await _showTimeDialog(context);
      if(timeOfDay==null)
        return null;
      return new DateTime(dateTime.year, dateTime.month, dateTime.day,
          timeOfDay.hour, timeOfDay.minute);
    }
  }


  String? _date2Str(DateTime? dateTime){
    if(dateTime == null)
      return null;
    // String str = "${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
    String? str;
    if(_indicator.datatype == FormConfig.DATATYPE_DATE){   //日期
      str = formatDate(dateTime ,['yyyy', '-', 'mm', '-', 'dd']);
      print("格式化 日期：$str");
    }else if(_indicator.datatype == FormConfig.DATATYPE_TIME){  //时间
      str = formatDate(dateTime, ["HH", ':', "nn", ':', "ss"]);
      print("格式化 时间：$str");
    }else if(_indicator.datatype == FormConfig.DATATYPE_DATETIME){  //日期+时间
      str = formatDate(dateTime ,['yyyy', '-', 'mm', '-', 'dd',
        " ", "HH", ':', "nn", ':', "ss"]);
      print("格式化 日期时间：$str");
    }
    return str;
  }

  /*static DateTime? str2Date(DateTime? dateTime){
    if(dateTime == null){
      return null;
    }
    String str = "${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
    print("格式化日期：$str");
    return str;
  }
*/
}



/*

class _FormItemDateState extends State<FormItemDate> {
  @override
  Widget build(BuildContext context) {

    return DecoratedBox(
      decoration: BoxDecoration(*/
/*color: Colors.red*//*
),

      child: Text("日期值"),
    );
  }

}*/
