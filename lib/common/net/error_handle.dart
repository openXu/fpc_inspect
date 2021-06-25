part of 'http_manager.dart';

///统一错误处理
ResultData _resultError(Exception e, bool toastError) {
  int? code;
  String message;
  if(e is DioError){
    print("http错误 ${e.type} ${e.message}");
    switch(e.type){
      case DioErrorType.connectTimeout: //超时
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        code = Code.NETWORK_TIMEOUT;
        message = "网络请求超时!!!";
        break;
      case DioErrorType.response://服务器响应，但状态不正确如404， 503
        code = Code.NETWORK_TIMEOUT;
        message = "服务器异常，请重试!!!";
        break;
      case DioErrorType.cancel:  //当请求被取消时，dio将抛出此类型的错误。
        code = -110;
        message = "已经取消!!!";
        break;
      case DioErrorType.other:  //其他一些错误
        code = Code.NETWORK_ERROR;
        message = "请检查网络后重试!!!";
        break;
    }
  }else if(e is BusinessError) {
    code = e.code;
    message = e.message??"业务错误";
  }else if(e is FormatException){
    print("其他错误：${e.message}");
    code = Code.JSON_ERROR;
    message = "数据解析错误!!!$e";
  }else{
    code = Code.OTHER_ERROR;
    message = "未知错误!!!$e";
  }
  //Toast提示错误
  if(toastError) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  return ResultData(code, false, message, 0, null);
}