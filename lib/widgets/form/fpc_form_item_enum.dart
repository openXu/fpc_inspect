import 'package:flutter/material.dart';
import 'fpc_form_item_base.dart';
import 'models/Indicator.dart';

/// 表单--枚举 弹窗
///
///

typedef FormEnumClick = Future<IndicatorEnum?> Function(BuildContext context);

class FormItemEnum extends FormItemBase {
  final bool _enable;
  final Indicator _indicator;
  final List<IndicatorEnum> _enumList;
  final IndicatorEnum? _selectedItem;
  late final FormEnumClick click;
  FormItemEnum(
    this._indicator,
    this._enable,
    this._enumList,
    this._selectedItem){
    click = (context) async {
      return showListDialog(context);
    };
  }

  @override
  bool checkFormResult() {
    return _selectedItem!=null;
  }

  @override
  Indicator getFormResult() {
    _indicator.datavalue = _selectedItem?.IndicatorID;
    _indicator.datatext = _selectedItem?.EnumValue;
    _indicator.isnormal = isNormal()? 1 : 0;  //是否正常值(0,否;1,是)'
    return _indicator;
  }
  @override
  bool isNormal() {
    return "1" == _selectedItem?.IsNormal?true:false;
  }

  Future<IndicatorEnum?> showListDialog(BuildContext context) async {
    IndicatorEnum? indicatorEnum = await showDialog<IndicatorEnum>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('请选择 \"${_indicator.displayname}\"'),
              children : _enumList.map((data){
                return SimpleDialogOption(
                  onPressed: () {
                    // 返回1
                    Navigator.pop(context, data);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text('${data.EnumValue}'),
                  ),
                );
              }).toList(),
          );
        });
    return indicatorEnum;
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(/*color: Colors.red*/),
      child: Text(_selectedItem==null?"":"${_selectedItem?.EnumValue}"),
    );
  }
}
/*

class _FormItemEnumState extends State<FormItemEnum> {
  @override
  Widget build(BuildContext context) {

    return DecoratedBox(
      decoration: BoxDecoration(*/
/*color: Colors.red*//*
),
      child: Text("枚举值"),
    );
  }

}*/
