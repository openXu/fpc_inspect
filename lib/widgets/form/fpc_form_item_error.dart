import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpc_inspect/common/style/fpc_style.dart';
import 'package:fpc_inspect/pages/check/models/CheckItems.dart';
import 'package:fpc_inspect/widgets/form/form_config.dart';

import 'fpc_form.dart';
import 'fpc_form_item_base.dart';
import 'models/Indicator.dart';

/// 自定义输入组件
///
///

class FormItemError extends FormItemBase {

  final Indicator _indicator;
  final String _errorStr;

  FormItemError(this._indicator, this._errorStr){
  }
  @override
  bool checkFormResult() {
    return true;
  }

  @override
  Indicator getFormResult() {
    return _indicator;
  }
  @override
  bool isNormal() {
    return true;
  }

  @override
  Widget build(BuildContext context) {

    return Text(_errorStr,style: FormConfig.formErrorTextStyle);
  }
}
/*


class _FormItemErrorState extends State<FormItemError> {
  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Text("${widget._indicator.displayname}", style: FpcForm.formKeyTextStyle),
        Expanded(
          //flex弹性系数，0或null：child是没有弹性的，即不会被扩伸占用的空间
          //如果大于0，所有的Expanded按照其flex的比例来分割主轴的全部空闲空间
          flex: 1,
          child: Text("错误的indicatortype指标类型${widget._indicator.indicatortype}"),
        ),
      ],
    );
  }

}*/
