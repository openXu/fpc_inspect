import 'dart:convert';

///网络结果数据
class ResultData {
  //{"success":true,"message":"登录成功","code":200,"result":{}}
  int code;
  bool success;
  String? message;
  int? timestamp;
  var result;    //json初步解析后的List 或者Map， 需要再次转换为相关类型对象
  ResultData(this.code, this.success, this.message, this.timestamp, this.result);
/*

  ResultData.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null&&json['result']!='null') {
      result = JsonConvert.fromJsonAsT<T>(json['data']);
    }
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data;
    }
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
*/

  @override
  String toString() {
    Map map = {
      'code': code,
      'success': success,
      'message': message,
      'result': result,
    };
    return jsonEncode(map);
  }
}
