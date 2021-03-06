class ApiService {

  ///登录
  static const URL_LOGIN = "/jeecg-boot/sys/phoneLogin";
  ///刷新token
  static const URL_REFRESH_TOKEN = "/jeecg-boot/sys/ChangeAppToken";
  ///获取用户功能权限
  static const URL_USER_PERMISSION = "/jeecg-boot/sys/permission/getPhoneUserPermissionByToken";

  ///规范检查
  //规范检查_任务登记_获取待登记的任务列表
  static const URL_CHECK_TASK_LIST = "/jeecg-boot/exam/examExaminetask/examTaskGetList";
  //规范检查_任务查询_获取待登记的被检查对象列表_手机使用
  static const URL_CHECK_OBJECT_LIST = "/jeecg-boot/exam/examExaminetaskobject/examTaskObjectForPhoneSelOne";
  //规范检查_任务登记_获取检查对象的被检查指标列表
  static const URL_CHECK_ITEM_LIST = "/jeecg-boot/exam/examExaminetaskitem/examExamTaskItemGetList";

  ///设备标签绑定
  //1、获取区域标签列表 (区域管理_区域列表_查询简易列表)  20210323144742424
  static const URL_EQBIND_REGION_LIST = "/jeecg-boot/cmds/cmdsRegion/cmdsRegionGetSimpleList";
  //2、获取设备类型列表 (设备分类查询_根据单位获取有设备分类的一级分类)
  static const URL_EQBIND_TYPE_LIST = "/jeecg-boot/emb/embEquipmentclass/equipmentFirstForCompanyID";
  //3、获取设备列表
  static const URL_EQBIND_EQ_LIST = "/jeecg-boot/emb/embEquipment/getEqumpListForClass";
  //4、更换设备的标签
  static const URL_EQBIND_CHANGE_CODE = "/jeecg-boot/emb/embEquipment/embEquipmentChangeEmbCode";

}
