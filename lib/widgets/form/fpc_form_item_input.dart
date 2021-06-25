import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fpc_inspect/common/style/fpc_style.dart';
import 'package:fpc_inspect/widgets/form/form_config.dart';

import '../fpc_input.dart';
import 'fpc_form_item_base.dart';
import 'models/Indicator.dart';

/// 表单--单行输入
///
///
///

class FormItemInput extends FormItemBase {

  final TextEditingController controller = new TextEditingController();

  final bool _enable;
  final Indicator _indicator;
  FormItemInput(this._indicator, this._enable){
   /* onPress = (){
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
    var isNormal = true;
    if(_indicator.datatype == FormConfig.DATATYPE_INT
        ||_indicator.datatype == FormConfig.DATATYPE_DECIMAL){
      String value = controller.text;
      double d = double.parse(value);
      if(_indicator.upperlimit!=null)
        isNormal = d<=_indicator.upperlimit!;
      if(_indicator.lowerlimit!=null)
        isNormal = d>=_indicator.lowerlimit!;
    }
    return isNormal;
  }

  @override
  Widget build(BuildContext context) {
    //设置默认值
    controller.text = _indicator.defaultvalue??"";

    //键盘类型
    TextInputType _keyboardType;
    //允许的输入格式
    List<TextInputFormatter> _inputFormatters = [];
    switch(_indicator.datatype){
      case FormConfig.DATATYPE_INT:   //整数
        _keyboardType = TextInputType.number;
        _inputFormatters.add(FilteringTextInputFormatter.allow(RegExp(r'[-0-9]')));
        // _inputFormatters.add(FilteringTextInputFormatter.allow(RegExp(r'(^(-?)[1-9]{1,6}$)|(^[0]|^([1-9]{1,6}))')));
        // _inputFormatters.add(LengthLimitingTextInputFormatter(5));
        //添加自定义输入过滤器
        _inputFormatters.add(IntInputFormatter());
        break;
      case FormConfig.DATATYPE_DECIMAL:    //小数
      // _keyboardType = TextInputType.numberWithOptions(decimal:true);  //设置键盘为可录入小数的数字
        _keyboardType = TextInputType.number;
        _inputFormatters.add(FilteringTextInputFormatter.allow(RegExp(r'[-.0-9]')));
        _inputFormatters.add(DecimalInputFormatter(digit: 3));
        // _inputFormatters.add(FilteringTextInputFormatter.allow(RegExp(r'(^[0-9]{1,6})(\.?)([0-9]{1,3})')));
        //(0开头 或者 非0数字最多6位) (^[0]|^([1-9]{1,6}))   (\.(d){1.2})?
        // _inputFormatters.add(FilteringTextInputFormatter.allow(RegExp('(^[0]|^([1-9]{1,6}))')));
        // _inputFormatters.add(FilteringTextInputFormatter.allow(RegExp(r'(^[0]|^([1-9]{1,6}))(\.{1}(\d){0,2})$')));
        // _inputFormatters.add(FilteringTextInputFormatter.allow(RegExp(r'(\.?)$')));
        break;
      default:   //DATATYPE_STRING //字符型
        _keyboardType = TextInputType.text;
        _inputFormatters.add(LengthLimitingTextInputFormatter(20));
        break;
    }
    return DecoratedBox(
      decoration: BoxDecoration(/*color: Colors.red*/),

      child: FpcInput(
          key: UniqueKey(),
          hintText: _enable?"请输入":"",
          enabled: _enable,
          style : FPCStyle.normalText, //文本的样式
          hintStyle: FormConfig.formHintTextStyle,
          keyboardType : _keyboardType, //键盘类型
          inputFormatters: _inputFormatters,
          enterType: TextInputAction.next,//默认回车跳到下一个选项
          maxLines: 1,
          border: OutlineInputBorder(borderSide: BorderSide.none),
          textAlign : TextAlign.end,   //文字水平靠右
          textAlignVertical: TextAlignVertical.center,  //文字竖直居中
          contentPadding : EdgeInsets.all(0),
          controller: controller,
          validator: (v) {   //校验时，如果错误提示不为null，输入框下划线会变为红色
            return v!.trim().isNotEmpty ? null : "请完成表单";
          }
      ),
    );
  }


}




/// -999 <= value <= 999 的整数 过滤
class IntInputFormatter extends TextInputFormatter {
  IntInputFormatter();
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String oldStr = oldValue.text;
    String newStr = newValue.text;
    int selectionIndex = newValue.selection.end;

    if(newStr == "-" || newStr == "--" || newStr == "-0" || newStr == "0-"){
      newStr = "-";
    }else if(newStr.startsWith("0")){   // 0
      if(newStr == "0") newStr = "0";
      else newStr = newStr.substring(1, newStr.length);   // 00    0-    01
    }else if(!oldStr.contains("-") && newStr.endsWith("-") ){
      newStr = "-$oldStr";
    }else if(oldStr.startsWith("-") && newStr.length>4){    //负数>=-999
      newStr = oldStr;
    }else if(!newStr.startsWith("-") && newStr.length>3){   //正数 <=999
      newStr = oldStr;
    }
    selectionIndex = newStr.length;
    return new TextEditingValue(
      text: newStr,
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

/// -999.99 <= value <= 999.99 的两位小数 过滤
class DecimalInputFormatter extends TextInputFormatter {
  static const defaultDouble = 0.001;
  ///允许的小数位数，-1代表不限制位数
  int digit;
  DecimalInputFormatter({this.digit = -1});
  static double strToFloat(String str, [double defaultValue = defaultDouble]) {
    try {
      return double.parse(str);
    } catch (e) {
      return defaultValue;
    }
  }

  ///获取目前的小数位数
  static int getValueDigit(String value) {
    if (value.contains(".")) {
      return value.split(".")[1].length;
    } else {
      return -1;
    }
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String oldStr = oldValue.text;
    String newStr = newValue.text;
    int selectionIndex = newValue.selection.end;

    ///输入校验
    if (newStr == ".") {
      newStr = "0.";
    }if(newStr == "-" || newStr == "--" || newStr == "0-"){
      newStr = "-";
    } else if(newStr == "-00"){
      newStr = "-0";
    }else if(newStr.startsWith("0")){
      if(newStr == "0" || newStr == "00") newStr = "0";  // 0    00
      else if(newStr == "0-") newStr = "-0";    //   0-    01
      else if(newStr == "0.-") newStr = "-0.";
      else if(newStr.endsWith("-") && newStr.length>=2){  //2-  0.2-
        newStr = "-${newStr.substring(0, newStr.length-1)}";
      }
    }else if(!oldStr.contains("-") && newStr.endsWith("-") ){
      newStr = "-$oldStr";   //正负得负
    }else if(oldStr.startsWith("-") && newStr.endsWith("-")){
      
      newStr = oldStr.substring(1, oldStr.length);//负负得正
    }

    ///范围校验
    if(newStr.isNotEmpty){    //负数>=-999
      double v = strToFloat(newStr, defaultDouble);
      if(v<-999.99 || v>999.99 || getValueDigit(newStr) > digit){
        newStr = oldStr;
      }
    }
    selectionIndex = newStr.length;
    return new TextEditingValue(
      text: newStr,
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}