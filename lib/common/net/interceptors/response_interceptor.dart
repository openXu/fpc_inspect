import 'package:dio/dio.dart';

class ResponseInterceptor extends InterceptorsWrapper {

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
   /* try {
      var header = response.headers[Headers.contentTypeHeader];
      if ((header != null && header.toString().contains("text"))) {
        value = new ResultData(response.data, true, Code.SUCCESS);
      } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
        value = new ResultData(response.data, true, Code.SUCCESS,
            headers: response.headers);
      }
    } catch (e) {
      print(e.toString() + response.requestOptions.path);
      value = new ResultData(response.data, false, response.statusCode,
          headers: response.headers);
    }*/

    super.onResponse(response, handler);
  }
}
