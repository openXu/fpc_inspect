
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

}
