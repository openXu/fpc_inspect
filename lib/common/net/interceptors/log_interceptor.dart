import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:fpc_inspect/config/config.dart';

/// Log 拦截器
class LogsInterceptor extends InterceptorsWrapper {
/*  static List<Map?> sHttpResponses = [];
  static List<String?> sResponsesHttpUrl = [];

  static List<Map<String, dynamic>?> sHttpRequest = [];
  static List<String?> sRequestHttpUrl = [];

  static List<Map<String, dynamic>?> sHttpError = [];
  static List<String?> sHttpErrorUrl = [];*/

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (Config.DEBUG) {
      print("\nREQUEST START ------------------------------------------------------------");
      print("\n");
      print("【请求url】 ${options.baseUrl}${options.path} ${options.method}");
      options.headers.forEach((k, v) => options.headers[k] = v ?? "");
      print('【请求头】 ' + options.headers.toString());
      //如果你一次输出太多，那么Android有时会丢弃一些日志行。为了避免这种情况，您可以使用Flutter的foundation库中的debugPrint()。 这是一个封装print，它将输出限制在一个级别，避免被Android内核丢弃。
      debugPrint('【请求参数】 ${options.data}');
    }
   /* try {
      addLogic(sRequestHttpUrl, options.path);
      var data;
      if (options.data is Map) {
        data = options.data;
      } else {
        data = Map<String, dynamic>();
      }
      var map = {
        "header:": {...options.headers},
      };
      if (options.method == "POST") {
        map["data"] = data;
      }
      addLogic(sHttpRequest, map);
    } catch (e) {
      print(e);
    }*/
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (Config.DEBUG) {
        print("\n");
        LogUtil.v('【返回数据----】 ${response.toString()}');
        // debugPrint('【返回数据】 ${response.toString()}');
    }
/*    if (response.data is Map || response.data is List) {
      try {
        var data = Map<String, dynamic>();
        data["data"] = response.data;
        addLogic(sResponsesHttpUrl, response.requestOptions.uri.toString());
        addLogic(sHttpResponses, data);
      } catch (e) {
        print(e);
      }
    } else if (response.data is String) {
      try {
        var data = Map<String, dynamic>();
        data["data"] = response.data;
        addLogic(sResponsesHttpUrl, response.requestOptions.uri.toString() );
        addLogic(sHttpResponses, data);
      } catch (e) {
        print(e);
      }
    } else if (response.data != null) {
      try {
        String data = response.data.toJson();
        addLogic(sResponsesHttpUrl, response.requestOptions.uri.toString() );
        addLogic(sHttpResponses, json.decode(data));
      } catch (e) {
        print(e);
      }
    }*/
    print("\nREQUEST END ---------------------------------------------------------------");
    print("\n");
    super.onResponse(response, handler);
  }

  /*static addLogic(List list, data) {
    if (list.length > 20) {
      list.removeAt(0);
    }
    list.add(data);
  }*/
}
