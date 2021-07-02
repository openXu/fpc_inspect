

// {
//       xAxis: {
//         type: 'category',
//         data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
//       },
//       yAxis: {
//         type: 'value'
//       },
//       series: [{
//         data: [820, 932, 901, 934, 1290, 1330, 1320],
//         type: 'line'
//       }]
//     }
import 'package:fpc_inspect/echarts/modules/series.dart';
import 'package:fpc_inspect/echarts/modules/xAxis.dart';
import 'package:fpc_inspect/echarts/modules/yAxis.dart';

class Option{
  XAxis xAxis;     //line
  YAxis yAxis;     //line
  List<Series> series;

  Option(this.xAxis, this.yAxis, this.series); // 'value',


}
