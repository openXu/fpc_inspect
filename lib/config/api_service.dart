class ApiService {

  ///登录
  static const URL_LOGIN = "/jeecg-boot/sys/phoneLogin";
  ///刷新token
  static const URL_REFRESH_TOKEN = "/jeecg-boot/sys/ChangeAppToken";
  ///获取用户功能权限
  static const URL_USER_PERMISSION = "/jeecg-boot/sys/permission/getPhoneUserPermissionByToken";

  ///规范检查_任务登记_获取待登记的任务列表
  static const URL_CHECK_TASK_LIST = "/jeecg-boot/exam/examExaminetask/examTaskGetList";
  ///规范检查_任务查询_获取待登记的被检查对象列表_手机使用
  static const URL_CHECK_OBJECT_LIST = "/jeecg-boot/exam/examExaminetaskobject/examTaskObjectForPhoneSelOne";
  ///规范检查_任务登记_获取检查对象的被检查指标列表
  static const URL_CHECK_ITEM_LIST = "/jeecg-boot/exam/examExaminetaskitem/examExamTaskItemGetList";

}
