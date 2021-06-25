import 'package:json_annotation/json_annotation.dart';

part 'CheckTask.g.dart';

@JsonSerializable()
class CheckTask{

  String? taskendtime;     //  2021-03-16 11:19:02"
  String? TaskCode;     //  EXAMT20210316082000089"
  String? TaskName;     //  GL计划2"
  String? companyname;     //  腾讯众创空间"
  String? progress;     //  0/5"
  String? taskstarttime;     //  2021-03-16 08:19:02"
  String? abnormalobjectcount;     //  0"
  String? taskid;

  CheckTask(
      this.taskendtime,
      this.TaskCode,
      this.TaskName,
      this.companyname,
      this.progress,
      this.taskstarttime,
      this.abnormalobjectcount,
      this.taskid); //  6777382895989559296"

  //不同的类使用不同的mixin即可
  factory CheckTask.fromJson(Map<String, dynamic> json) => _$CheckTaskFromJson(json);
  Map<String?, dynamic> toJson() => _$CheckTaskToJson(this);
}