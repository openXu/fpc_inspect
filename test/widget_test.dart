// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';

void main() {

  // 单一的测试
  test("测试json", () {
    decodePerson();
    // 验证 counter.value 的是是否为 1
    // expect(counter.value, 1);
  });

}

Future decodePerson() async {
  // String jsonStr = await rootBundle.loadString('jsons/user_permission.json');

  String jsonStr = """
{"success":true,"message":"操作成功！","code":200,"result":[{"sortno":1.0,"component":"homePage","descrip":"","children":[],
"name":"任务","id":"1369167908600557569","parentid":""},{"sortno":2.0,"component":"effect","descrip":"","children":[{"sortno":1.0,
"component":"dp","descrip":"","children":[{"sortno":1.0,"component":"riskArchives","descrip":"","children":[],"name":"风险档案","id":"1369169893764640769",
"parentid":"1369169134549479426"},{"sortno":3.0,"component":"relieveapply","descrip":"","children":[],"name":"解除申请","id":"1369170756419727362",
"parentid":"1369169134549479426"},{"sortno":4.0,"component":"relieveAudit","descrip":"","children":[],"name":"解除审批","id":"1369171215368859650",
"parentid":"1369169134549479426"}],"name":"双控预防","id":"1369169134549479426","parentid":"1369168578380574721"},{"sortno":1.0,"component":"sv",
"descrip":"","children":[{"sortno":1.0,"component":"svregister","descrip":"","children":[],"name":"督导登记","id":"1402882481586888706","parentid":"1402882248203231233"}],
"name":"督导管控","id":"1402882248203231233","parentid":"1369168578380574721"},{"sortno":2.0,"component":"exam","descrip":"","children":[{"sortno":2.0,
"component":"registerTask","descrip":"","children":[],"name":"任务登记","id":"1369171680823357441","parentid":"1369169473927393282"}],
"name":"安全检查","id":"1369169473927393282","parentid":"1369168578380574721"},{"sortno":3.0,"component":"proc","descrip":"","children":[{"sortno":1.0,
"component":"procsel","descrip":"","children":[],"name":"整改查询","id":"1372434493574541313","parentid":"1372433453672361986"},{"sortno":2.0,"component":"procrelease",
"descrip":"","children":[],"name":"整改下单","id":"1372433860205277186","parentid":"1372433453672361986"},{"sortno":3.0,"component":"procregister","descrip":"",
"children":[],"name":"整改登记","id":"1372434292642213890","parentid":"1372433453672361986"}],"name":"检查整改","id":"1372433453672361986","parentid":"1369168578380574721"},
{"sortno":4.0,"component":"other","descrip":"","children":[{"sortno":1.0,"component":"otherduty","descrip":"","children":[],"name":"我的职责","id":"1382868262802472962",
"parentid":"1382867653793726466"},{"sortno":2.0,"component":"miniTask","descrip":"","children":[],"name":"微任务","id":"1369168265212866561","parentid":"1382867653793726466"},
{"sortno":3.0,"component":"bindembcode","descrip":"","children":[],"name":"设备绑定","id":"1385189681814749186","parentid":"1382867653793726466"},{"sortno":4.0,
"component":"bindregioncode","descrip":"","children":[],"name":"区域绑定","id":"1385189977546735617","parentid":"1382867653793726466"},{"sortno":5.0,"component":"knowledge",
"descrip":"","children":[],"name":"知识库","id":"1386263700089520129","parentid":"1382867653793726466"}],"name":"其他功能","id":"1382867653793726466",
"parentid":"1369168578380574721"}],"name":"功能","id":"1369168578380574721","parentid":""},{"sortno":3.0,"component":"onekeyalarm","descrip":"","children":[],
"name":"一键报警","id":"1384019518910283778","parentid":""},{"sortno":4.0,"component":"message","descrip":"","children":[],"name":"消息","id":"1384411276294930433",
"parentid":""},{"sortno":5.0,"component":"me","descrip":"","children":[{"sortno":1.0,"component":"changeHead","descrip":"","children":[],"name":"修改头像",
"id":"1369172545298771969","parentid":"1369168809608359938"},{"sortno":2.0,"component":"changePwd","descrip":"","children":[],"name":"修改密码","id":"1369172656217141250",
"parentid":"1369168809608359938"},{"sortno":3.0,"component":"logPostBack","descrip":"","children":[],"name":"日志回传","id":"1369172757111123969",
"parentid":"1369168809608359938"},{"sortno":4.0,"component":"feedback","descrip":"","children":[],"name":"意见反馈","id":"1369173184967880705","parentid":"1369168809608359938"}],"name":"我的","id":"1369168809608359938","parentid":""}],"timestamp":1623397467313}
  """;

  // 解析 json 字符串，返回的是 Map<String, dynamic> 类型
  final jsonMap = jsonDecode(jsonStr);
  print('jsonMap runType is ${jsonMap.runtimeType}');

  final result = jsonMap["result"];
  print('result runType is ${result.runtimeType}');

  (result as List).forEach((element) {
    print("元素 ： $element");
  });

 /* (result as Map).forEach((key, value) {
    print('键值对--> $key : $value');
  });*/

}
