import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fpc_inspect/common/style/fpc_style.dart';
import 'package:fpc_inspect/widgets/form/form_config.dart';

import '../fpc_input.dart';
import 'fpc_form.dart';
import 'fpc_form_item_base.dart';
import 'models/Indicator.dart';

/// 表单--多行输入
///
///
class FormItemMultInput extends FormItemBase {

  final TextEditingController controller = new TextEditingController();

  final bool _enable;
  final Indicator _indicator;
  FormItemMultInput(this._indicator, this._enable){
    /*onPress = (){
      print("点击${_indicator.displayname}");
    };*/
  }

  @override
  bool checkFormResult() {
    return controller.text.isNotEmpty;
  }

  @override
  Indicator getFormResult() {
    String value = controller.text;
    _indicator.datavalue = value;
    _indicator.datatext = value;
    _indicator.isnormal = isNormal() ? 1 : 0; //是否正常值(0,否;1,是)'
    return _indicator;
  }

  @override
  bool isNormal() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    //设置默认值
    controller.text = _indicator.defaultvalue??"";

    return DecoratedBox(
      decoration: BoxDecoration(/*color: Colors.red*/),
      child: FpcInput(
          hintText: _enable?"请输入":"",
          enabled: _enable,
          style : FPCStyle.normalText, //文本的样式
          hintStyle: FormConfig.formHintTextStyle,
          keyboardType : TextInputType.multiline, //键盘类型  多行文本，配合maxLines使用
          //取消文本框右下角字符计数器。将 maxLength 设置为 null 仅使用 LengthLimitingTextInputFormatter 限制最长字符；
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(60)
          ],
          enterType: TextInputAction.next,//默认回车跳到下一个选项
          minLines: 3,
          maxLines: 5,
          border: OutlineInputBorder(borderSide: BorderSide.none),
          textAlign : TextAlign.start,   //文字水平靠右
          textAlignVertical: TextAlignVertical.bottom,  //文字竖直居中
          contentPadding : EdgeInsets.symmetric(horizontal: FPCSize.formSides, vertical: 6),
          controller: controller,
          validator: (v) {   //校验时，如果错误提示不为null，输入框下划线会变为红色
            return v!.trim().isNotEmpty ? null : "请完成表单";
          }
      ),
    );
  }


}



