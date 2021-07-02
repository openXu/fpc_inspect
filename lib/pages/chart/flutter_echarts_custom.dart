import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:fpc_inspect/common/util/common_utils.dart';
import 'package:fpc_inspect/echarts/modules/option.dart';
import 'package:fpc_inspect/echarts/modules/series.dart';
import 'package:fpc_inspect/echarts/modules/xAxis.dart';
import 'package:fpc_inspect/echarts/modules/yAxis.dart';
import 'package:fpc_inspect/router/routes.dart';
import 'package:fpc_inspect/widgets/fpc_button.dart';
import 'package:fpc_inspect/widgets/fpc_widget_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

///规范检查--检查项列表
///
///
///
class EchartsCustom extends StatefulWidget {
  static final String sName = "/echart_custom";
  final Map<String, Object> _arguments;
  EchartsCustom(this._arguments);
  @override
  _EchartsCustomState createState() => _EchartsCustomState();

}

class _EchartsCustomState extends State<EchartsCustom> {

  String _data = "";
  String _xdata = "['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']";    //['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
  String _ydata = "[820, 932, 901, 934, 1290, 1330, 1320]";    //[820, 932, 901, 934, 1290, 1330, 1320]

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    print("刷新页面");

    return Scaffold(
      appBar: FpcWidgetUtils.getApp(context, widget._arguments[RouteArgs.TITLE]?.toString()??""),
      body:SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: _getLineChart(),
              height: 300,
            ),

            FpcButton(text: "更新数据", onPress: ()async{
              String newData = await _getData(context);
              setState(() {
                _data = newData;
                print("更新数据：$_data");
              });

            })

          ],
        ),
      ),
    );
  }


  Future<String> _getData(BuildContext context) async{
    CommonUtils.showLoading(context);
    print("模拟请求数据......");
    await Future.delayed(Duration(seconds: 2));
/*
    XAxis xAxis = new XAxis("category", ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']);
    YAxis yAxis = new YAxis("value");
    Series series = Series("line",  [820, 932, 901, 934, 1290, 1330, 1320]);
    Option option = new Option(xAxis, yAxis, [series]);*/
    List<List<dynamic>> datasource = [
      ['Mon', 820],
      ['Tue', 932],
      ['Wed', 901],
      ['Thu', 934],
      ['Fri', 1290],
      ['Sat', 1330],
      ['Sun', 1320]
    ];

    Random random = Random(5);
    int dataNum = random.nextInt(1000);

    List<String> xList = [];
    for(int i = 0; i<dataNum; i++){
      xList.add("x$i");
    }
    _xdata = json.encode(xList);
    print("x轴刻度值：$_xdata");

    List<int> yList = [];
    for(int i = 0; i<dataNum; i++){
      yList.add(i+random.nextInt(i+3));
    }
    _ydata = json.encode(yList);
    print("x轴刻度值：$_ydata");
    Navigator.of(context).pop();
    return json.encode(datasource);

  }


  Echarts _getLineChart(){
    return Echarts(
      // captureAllGestures:true,
      captureHorizontalGestures:true,
      // captureVerticalGestures:true,
      option: '''
    {
      xAxis: {
        type: 'category',
        data: $_xdata
      },
      yAxis: {
        type: 'value'
      },
      tooltip: {
        show:true,
        trigger: 'axis',
        triggerOn:'mousemove|click',
        axisPointer: {
            type: 'cross'
        },
        backgroundColor: 'rgba(255, 255, 255, 0.8)',
        position: function (pos, params, el, elRect, size) {
            var obj = {top: 10};
            obj[['left', 'right'][+(pos[0] < size.viewSize[0] / 2)]] = 30;
            return obj;
        },
        extraCssText: 'width: 170px'
      },
 dataZoom: [
        {
            type: 'slider',
            show: true,
            xAxisIndex: [0],
            start: 1,
            end: 35
        },
        {
            type: 'slider',
            show: true,
            yAxisIndex: [0],
            left: '93%',
            start: 29,
            end: 36
        },
        {
            type: 'inside',
            xAxisIndex: [0],
            start: 1,
            end: 35
        },
        {
            type: 'inside',
            yAxisIndex: [0],
            start: 29,
            end: 36
        }
    ],
      series: [{
        data: $_ydata,
        type: 'line'
      }]
    }
  ''',
    );
  }



}