import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fpc_inspect/common/net/http_manager.dart';
import 'package:fpc_inspect/common/util/sp_storage.dart';
import 'package:fpc_inspect/config/Global.dart';
import 'package:fpc_inspect/config/api_service.dart';
import 'package:fpc_inspect/models/LoginInfo.dart';
class TokenInterceptor extends InterceptorsWrapper {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    // {"timestamp":"2021-03-10 16:00:54", "status":500, "error":"Internal Server Error",
    // "message":"Token失效，请重新登录", "path":"/jeecg-boot/sys/permission/getPhoneUserPermissionByToken"}
    print("请求错误${err.response}");
    if (err.response?.statusCode == 500) {
      Map<String, dynamic> map = jsonDecode(err.response.toString());
      var message = map["message"]?.toString()??"";
      if(!message.contains("Token失效")){
        print("---------返回500的其他错误，直接返回错误提示");
        handler.next(err);
        return;
      }
      //你可以通过调用拦截器的 lock()/unlock 方法来锁定/解锁拦截器。
      // 一旦请求/响应拦截器被锁定，接下来的请求/响应将会在进入请求/响应拦截器之前排队等待，
      // 直到解锁后，这些入队的请求才会继续执行(进入拦截器)。这在一些需要串行化请求/响应的场景中非常实用
      httpManager.dio.lock();
      // httpManager.dio.clear(); //方法来清空等待队列
      bool result = await refreshToken();  //刷新token
      print("刷新token: $result");
      httpManager.dio.unlock();
      try {
        RequestOptions? request = err.response?.requestOptions;
        print("重新请求：${request?.path}");   // /jeecg-boot/exam/examExaminetask/examTaskGetList
        Options option = new Options(method: request?.method, headers: request?.headers);
        //使用新token请求
        option.headers!["X-Access-Token"] = (await Global.getLoginInfo())?.token??"";
        Response response = await httpManager.dio.request(request!.path,
            data: request.data,
            queryParameters: request.queryParameters,
            cancelToken: request.cancelToken,
            options: option);
        print("重新请求结果：${response.data}");
        //用响应对象完成请求，将不执行其他错误拦截器，这将被视为一个成功的请求！
        handler.resolve(response);
      } on DioError catch (e) {
        handler.next(e);
      }
    }else{
      super.onError(err, handler);
    }
  }


  ///获取新token
  Future<bool> refreshToken() async {
    LoginInfo? loginInfo = await Global.getLoginInfo();
    String oldToken = loginInfo?.token??"";
    print("检测到Token已经过期：$oldToken");
    //一定要创建新的 dio 对象，不要用添加了拦截器的那个 dio 对象，不然会发生死锁，这一点官方文档也有提到
    Dio ndio = httpManager.createDio();
    Map<String, dynamic> requestData = {
      "Token": oldToken
    };
    try {
      Response response = await ndio.post(ApiService.URL_REFRESH_TOKEN,
          data: requestData, options:Options(responseType:ResponseType.json));
      String newToken = response.data["result"];
      print("获取到新token $newToken");
      ///存储新token
      loginInfo?.token = newToken;
      await SpLocalStorage.saveData(SpLocalStorage.KEY_USER, jsonEncode(loginInfo));
      return true;
    } on DioError catch (e) {
      print("xxxxxxxxxxx刷新token失败，重新登录");
      /*if (e.response == null) {
        print('DioError:${e.message}');
      } else {
        if (e.response.statusCode == 422) {
          print('422Error:${e.response.data['msg']}');
          //422状态码代表异地登录，token失效，发送登录失效事件，以便app弹出登录页面
          // EventManager.get(EventGroup.app).fire(LoginInvalidEvent());
        }
      }*/
      return false;
    }
  }
}
