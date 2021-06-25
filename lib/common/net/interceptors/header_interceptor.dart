import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:fpc_inspect/config/Global.dart';

/// header拦截器
class HeaderInterceptor extends InterceptorsWrapper {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    ///超时
    options.connectTimeout = 30000;
    options.sendTimeout = 30000;
    options.receiveTimeout = 30000;
    ///header
    Map<String, dynamic> headers = new HashMap();

    headers["Connection"] = "keep-alive";
    headers["Content-Type"] = "application/json;charset=UTF-8";
    //接受任何 MIME 类型的资源，支持采用 gzip、deflate 或 sdch 压缩过的资源。告知服务器发送何种媒体类型  对应响应头Content-Type
    headers["Accept"] = "*/*";
    //可以接受 zh-CN、en-US 和 en 三种语言，并且 zh-CN 的权重最高（q 取值 0 - 1，最高为 1，最低为 0，默认为 1），服务端应该优先返回语言等于 zh-CN 的版本。
    headers["Accept-Language"] = "zh-CN,en-US;q=0.8,en;q=0.6";
    //告知服务器发送何种字符集   对应响应头Content
    headers["Accept-Charset"] = "UTF-8";
    /*Accept-Encoding告知服务器采用何种压缩方式，如果没有设置，后台可能返回gzip格式
      返回乱码的原因就是Okhttp没有正确解压Gzip的数据
      Okhttp不会帮你处理Gzip的解压，需要你自己去处理。*/
    headers["Accept-Encoding"] = "";
    ///token
    ///eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MjM4NDAzODcsInVzZXJuYW1lIjoiY3lmOTUifQ._qS7VU1PYhK95OEB39AvVtel7C5LXh-OEronJ40dro4
    headers["X-Access-Token"] = (await Global.getLoginInfo())?.token??"";
    options.headers.addAll(headers);
    super.onRequest(options, handler);
  }

}
