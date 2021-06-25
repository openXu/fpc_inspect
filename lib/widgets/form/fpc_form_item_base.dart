import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpc_inspect/common/style/fpc_style.dart';
import 'package:fpc_inspect/pages/check/models/CheckItems.dart';

import 'models/Indicator.dart';

/// 自定义输入组件
/// 
///


abstract class FormItemBase extends StatelessWidget {

  // void setEnabled(bool enable);

  bool checkFormResult();
  Indicator getFormResult();

  bool isNormal(){
    return true;
  }


}

