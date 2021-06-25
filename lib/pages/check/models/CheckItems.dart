import 'dart:core';

import 'package:fpc_inspect/widgets/form/models/Indicator.dart';
import 'package:json_annotation/json_annotation.dart';

part 'CheckItems.g.dart';

@JsonSerializable()
class CheckItems{
    String? serialkey;
    List<Indicator>? taskitem;

    CheckItems(this.serialkey, this.taskitem);

    //不同的类使用不同的mixin即可
  factory CheckItems.fromJson(Map<String, dynamic> json) => _$CheckItemsFromJson(json);
  Map<String?, dynamic> toJson() => _$CheckItemsToJson(this);
}
