import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:fpc_inspect/router/routes.dart';
import 'package:fpc_inspect/widgets/fpc_widget_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

///规范检查--检查项列表
///
///
///
class EchartsTest extends StatefulWidget {
  static final String sName = "/echart_test_1";
  final Map<String, Object> _arguments;
  EchartsTest(this._arguments);
  @override
  _EchartsTestState createState() => _EchartsTestState();

}

class _EchartsTestState extends State<EchartsTest> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FpcWidgetUtils.getApp(context, widget._arguments[RouteArgs.TITLE]?.toString()??""),
      body:SingleChildScrollView(
        child: Column(
          children: [
            _getChart1(),
            _getChart2(),
            _getChart3(),
          ],
        ),
      ),
    );
  }

  Widget _getChart1(){
    return Container(
      child: Echarts(
        // captureAllGestures:true,
        captureHorizontalGestures:true,
        // captureVerticalGestures:true,
        option: '''
    {
      xAxis: {
        type: 'category',
        data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
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
      series: [{
        data: [820, 932, 901, 934, 1290, 1330, 1320],
        type: 'line'
      }]
    }
  ''',
      ),
      height: 400,
    );
  }


  Widget _getChart2(){
    return Container(
      child: Echarts(
        captureHorizontalGestures:true,
        option: '''
    {
    series : [
        {
            name: '访问来源',
            type: 'pie',
            radius: '55%',
            data:[
                {value:235, name:'视频广告'},
                {value:274, name:'联盟广告'},
                {value:310, name:'邮件营销'},
                {value:335, name:'直接访问'},
                {value:400, name:'搜索引擎'}
            ],
             roseType: "area"
        }
    ]
    }
  ''',
      ),
      height: 400,
    );
  }


  Widget _getChart3(){
    return Container(
      child: Echarts(
        captureHorizontalGestures:true,
        option: '''
    {
      xAxis: {
        type: 'category',
        data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
      },
      yAxis: {
        type: 'value'
      },
      series: [{
        data: [820, 932, 901, 934, 1290, 1330, 1320],
        type: 'line'
      }]
    }
  ''',
      ),
      height: 300,
    );
  }



}