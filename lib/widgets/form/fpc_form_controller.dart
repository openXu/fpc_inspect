

import 'models/Indicator.dart';

typedef FormDataCallBack = Future<List<Indicator>> Function();
typedef FormResultCheck = bool Function();
class FpcFormController{
  final FormDataCallBack requestData;
  late FormDataCallBack formResult;
  late FormResultCheck checkResult;
  FpcFormController({
    required this.requestData,
  });

}

