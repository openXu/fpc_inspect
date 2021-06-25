import 'package:json_annotation/json_annotation.dart';

import 'CheckTask.dart';

part 'CheckTaskPage.g.dart';

@JsonSerializable()
class CheckTaskPage{
  List<CheckTask>? records;   //
  int? total;   //2
  int? size;   //30
  int? current;   //1
  List<int>? orders;   //[]
  bool? optimizeCountSql;   //true
  bool? hitCount;  //false
  bool? searchCount;   //true
  int? pages;

  CheckTaskPage(this.records, this.total, this.size, this.current, this.orders,
      this.optimizeCountSql, this.hitCount, this.searchCount, this.pages); //1
  //不同的类使用不同的mixin即可
  factory CheckTaskPage.fromJson(Map<String, dynamic> json) => _$CheckTaskPageFromJson(json);
  Map<String?, dynamic> toJson() => _$CheckTaskPageToJson(this);
}