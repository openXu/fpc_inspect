import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpc_inspect/widgets/form/fpc_form_item.dart';
import 'fpc_form_controller.dart';
import 'models/Indicator.dart';
/// 自定义输入组件
/// 
///
///
///

class FpcForm extends StatefulWidget {

  final bool enable;
  final bool finished;
  final FpcFormController formController;
  final List<FpcFormItemController> _formItemController = [];
  FpcForm({this.enable = true,
    this.finished = false,
    required this.formController}){
    ///初始化结果回调
    formController.checkResult = (){
      bool result = true;
      _formItemController.forEach((itemController) {
        if(!itemController.formItemCheck()) {
          result = false;
        }
      });
      return result;
    };
    formController.formResult = () async {
      return _formItemController.map((itemController) {return itemController.formItemResult();}).toList();
    };
  }
  @override
  _FpcFormState createState() => new _FpcFormState();
}

class _FpcFormState extends State<FpcForm> {
  List<Indicator>? _indicators;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async{
    _indicators = await widget.formController.requestData();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context){

    widget._formItemController.clear();

    if(_indicators==null){
      return Center(
        child: Text("加载中..."),
      );
    }else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start, //水平方向上靠左边
        /*children:widget.indicators.map((indocator) {
        return Text("");
      }).toList(),*/
        children: _indicators!.map((indocator) {
          FpcFormItem formItem = FpcFormItem(indocator, widget.enable);

          widget._formItemController.add(new FpcFormItemController(
              formItemCheck: () => formItem.checkForm(),
              formItemResult: () => formItem.formResult())
          );

          return formItem;
        }).toList(),

      );
    }
  }
}