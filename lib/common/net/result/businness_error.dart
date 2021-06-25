///后台返回的业务错误，将直接提示给用户
class BusinessError implements Exception{
  int code;
  String? message;
  BusinessError(this.code, this.message);
}