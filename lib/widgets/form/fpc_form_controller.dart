

import 'models/Indicator.dart';

typedef RequestData = Future<List<Indicator>?> Function();
typedef FormResult = Future<List<Indicator>> Function();


class FpcFormController{

  final RequestData requestData;
  late FormItemCheck checkResult;
  late FormResult formResult;
  FpcFormController({
    required this.requestData,
  });

}

///表单项控制器
typedef FormItemResult = Indicator Function();
typedef FormItemCheck = bool Function();
class FpcFormItemController{
  final FormItemCheck formItemCheck;
  final FormItemResult formItemResult;
  FpcFormItemController({
    required this.formItemCheck,
    required this.formItemResult,
  });

}