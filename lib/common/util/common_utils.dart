
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpc_inspect/common/net/result/result_data.dart';

class CommonUtils {

  static String getDateStr(DateTime? date) {
    if (date == null || date.toString() == "") {
      return "";
    } else if (date
        .toString()
        .length < 10) {
      return date.toString();
    }
    return date.toString().substring(0, 10);
  }


  static showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, //点击遮罩不关闭对话框
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.only(top: 26.0),
                child: Text("正在加载，请稍后..."),
              )
            ],
          ),
        );
      },
    );
  }

/*
  static List<T>? getListData<T>(ResultData resultData){
    if(resultData.result["records"]==null)
      return null;
    //List<Map>
    List list = (resultData.result["records"] as List);
    List<T> dataList = List.generate(list.length,
            (index) => T.fromJson(list[index]));
    LogUtil.v("获取设备列表 $eqList");
  }*/

  ///技巧：两个Text水平排列时，如果一个显示中文，另一个显示数字或者英文，尽管两个TextSize一样，数字或者英文的Text会偏上（不能与前一个Text对齐），
  ///可以让数字或者英文后加一个全角的空格（中文），这样两个就对齐了
  static getChineseWestern(String? western){
    return western==null?"":"$western　";
  }

}
