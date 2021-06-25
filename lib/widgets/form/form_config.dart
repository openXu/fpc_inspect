import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:fpc_inspect/common/style/fpc_style.dart';

class FormConfig {


  ///Indicator 检查项填写的数据类型 DataType值
  static const String DATATYPE_INT = "IntType";             //整数
  static const String DATATYPE_DECIMAL = "DecimalType";     //小数
  static const String DATATYPE_STRING = "StringType";       //字符型
  static const String DATATYPE_MULTILINE = "MultilineType"; //多行字符
  static const String DATATYPE_DATE = "DateType";            //日期
  static const String DATATYPE_TIME = "TimeType";            //时间
  static const String DATATYPE_DATETIME = "DateTimeType";    //日期时间
  static const String DATATYPE_COUNT = "CountType";          //计数项

  ///计数单位输入最大值和最小值
  static const double INPUT_NUM_MAX = 999.0;
  static const double INPUT_NUM_MIN = -999.0;

  static const formKeyTextStyle = TextStyle(
    color: FPCColors.subTextColor,
    fontSize:FPCSize.formTextSize,
  );
  static const formValueTextStyle = TextStyle(
    color: FPCColors.mainTextColor,
    fontSize:FPCSize.formTextSize,
  );
  static const formHintTextStyle = TextStyle(
    color: FPCColors.subLightTextColor,
    fontSize:FPCSize.formTextSize,
  );
  static const formErrorTextStyle = TextStyle(
    color: FPCColors.red,
    fontSize:FPCSize.formTextSize,
  );
}
