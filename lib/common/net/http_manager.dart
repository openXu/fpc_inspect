
import 'dart:collection';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpc_inspect/common/net/result/businness_error.dart';
import 'package:fpc_inspect/common/net/result/code.dart';
import 'package:fpc_inspect/common/net/result/result_data.dart';
import 'interceptors/header_interceptor.dart';
import 'interceptors/token_interceptor.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/log_interceptor.dart';
import 'interceptors/response_interceptor.dart';

part 'error_handle.dart';

///
/// https://github.com/flutterchina/dio/blob/master/README-ZH.md
///
///
final HttpManager httpManager = new HttpManager();

class HttpManager{
  // BuildContext context;
  // Options _options;
  late Dio _dio;
  Dio get dio => _dio;

  HttpManager() {
    print("初始化网络框架...");
    _dio = createDio();
  }

  Dio createDio(){
    Dio dio = new Dio(BaseOptions(
      baseUrl: 'http://39.98.164.162:8080',
      headers: {
        "Connection" : "keep-alive",
        "Content-Type" : "application/json;charset=UTF-8",
        //接受任何 MIME 类型的资源，支持采用 gzip、deflate 或 sdch 压缩过的资源。告知服务器发送何种媒体类型  对应响应头Content-Type
        // "Accept" : "*/*";
        //可以接受 zh-CN、en-US 和 en 三种语言，并且 zh-CN 的权重最高（q 取值 0 - 1，最高为 1，最低为 0，默认为 1），服务端应该优先返回语言等于 zh-CN 的版本。
        "Accept-Language" : "zh-CN,en-US;q=0.8,en;q=0.6",
        //告知服务器发送何种字符集   对应响应头Content
        "Accept-Charset" : "UTF-8",
        /*Accept-Encoding告知服务器采用何种压缩方式，如果没有设置，后台可能返回gzip格式
              返回乱码的原因就是Okhttp没有正确解压Gzip的数据
              Okhttp不会帮你处理Gzip的解压，需要你自己去处理。*/
        "Accept-Encoding" : "",
        // String token = "";
        ///token
        // "X-Access-Token" : token,
      },
    ));

    dio.interceptors.add(new HeaderInterceptor());
    dio.interceptors.add(new LogsInterceptor());
    dio.interceptors.add(new TokenInterceptor());
    dio.interceptors.add(new ErrorInterceptor());
    dio.interceptors.add(new ResponseInterceptor());
    return dio;
  }


  Future<ResultData> get(String url, Map<String, dynamic>? params,
      {Map<String, dynamic>? header, bool toastError = true}){
    Options option = new Options(method: "get", responseType:ResponseType.json);

    /*String completeUrl = url;
    if(params!=null && params.isNotEmpty) {
      completeUrl += "?";
      params.forEach((key, value) {
        completeUrl += "$key=$value&";
      });
      completeUrl = completeUrl.substring(0, completeUrl.length-1);
    }*/
    return _doRequest(url, params, "", header, option, toastError);
  }

  Future<ResultData> post(String url, data, {Map<String, dynamic>? queryParameters, Map<String, dynamic>? header, bool toastError = true}){
    Options option = new Options(method: "post");
    return _doRequest(url, queryParameters, data, header, option, toastError);
  }

  ///发起网络请求(私有方法)
  Future<ResultData> _doRequest(
      String url,      //请求url
      Map<String, dynamic>? queryParameters,
      String data,     //请求参数
      Map<String, dynamic>? header,  //额外的请求头
      Options option,  //请求配置
      bool toastError  //出现错误是否土司提示，默认true
      ) async {
    try {
      Map<String, dynamic> headers = new HashMap();
      if (header != null)
        headers.addAll(header);
      option.headers = headers;

      Response response = await _dio.request(url,
          queryParameters:queryParameters,
          data: data, options: option);

      // json解析错误:FormatException: Unexpected character (at character 34)
      // {"success":true,"avatar": "["[\"temp/xiaofangyuan_1617935262694.jpg\"]"...
      //"avatar": "[\"[\\\"temp/xiaofangyuan_1617935262694.jpg\\\"]\"]",
      // String avatar = "[\"[\\\"temp/xiaofangyuan_1617935262694.jpg\\\"]\"]";
      //,"avatar":"[\"temp/xiaofangyuan_1617935262694.jpg\"]"
      String resunt = """
    {"success":true,"message":"登录成功","code":200,
"result":{"multi_depart":1,"userInfo":{"id":"6780018054576476000","username":"cyf95",
"realname":"陈永富",
"postname":null
},
"departs":[
{
"id":"20210323144742424",
"updateTime":null,
"orgClass":2
}
],
"token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MjM0MTA0MzMsInVzZXJuYW1lIjoiY3lmOTUifQ.6yK-sv5U1kaldA6Ga3RMTpJSqcSBX9MRxVdn27l7f5U"
},
"timestamp":1622791905835
}
    """;
      final jsonMap;
      if(url.contains("phoneLogin eeee")){
        jsonMap = jsonDecode(resunt);
      }else{
        if (response.data is Map) {
          jsonMap = response.data;
        }else{
          jsonMap = jsonDecode(response.data);
        }
      }
      int code = jsonMap['code'] as int;
      if(code!=Code.SUCCESS)
        throw BusinessError(code, jsonMap['message'] as String?);
      return ResultData(
          jsonMap['code'] as int,
          jsonMap['success'] as bool,
          jsonMap['message'] as String?,
          jsonMap['timestamp'] as int?,
          jsonMap['result']);
    } on DioError catch (e) {
      return _resultError(e, toastError);
    } on BusinessError catch (e) {
      return _resultError(e, toastError);
    } on Exception catch (e) {
      return _resultError(e, toastError);
    } catch (e) {
      print('未知类型的异常: $e');
      rethrow; //如果你无法完全处理该异常，请使用 rethrow 关键字再次抛出异常
    }finally{}
    /*    if (response.data is DioError) {
      print("2请求异常：${(response.data as DioError).message}");
      return resultError(response.data);
    }*/

  }



}




