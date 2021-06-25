import 'package:dio/dio.dart';
import 'package:fpc_inspect/config/config.dart';

///是否需要弹提示
const NOT_TIP_KEY = "noTip";

/// 错误拦截
class ErrorInterceptor extends InterceptorsWrapper {

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (Config.DEBUG) {
      print("\n");
      print('【请求异常】${err.toString()}');
    }
    /*try {
      addLogic(sHttpErrorUrl, err.requestOptions.path);
      var errors = Map<String, dynamic>();
      errors["error"] = err.message;
      addLogic(sHttpError, errors);
    } catch (e) {
      print(e);
    }*/
    print("\nREQUEST END ---------------------------------------------------------------");
    print("\n");
    super.onError(err, handler);
  }

}
