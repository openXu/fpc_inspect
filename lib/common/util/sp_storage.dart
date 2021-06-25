
import 'package:shared_preferences/shared_preferences.dart';

import 'LogUtil.dart';

class SpLocalStorage {

  static const String KEY_USER = "loginInfo";
  static const String KEY_USER_PERMISSION = "userPermissions";

  static Future<T?> getData<T>(String key) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    switch(T){
      case int:
        return _prefs.getInt(key) as T?;
      case double:
        return _prefs.getDouble(key) as T?;
      case bool:
        return _prefs.getBool(key) as T?;
      case List:
        return _prefs.getStringList(key) as T?;
      default:
        return _prefs.getString(key) as T?;
    }
  }


  static Future saveData(String key, String value) async {
    print("存储$key ： $value");
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString(key, value);
  }


  static Future clearData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
    var _loginInfo = _prefs.getString(KEY_USER);
    var _userPermissions = _prefs.getString(KEY_USER_PERMISSION);
    LogUtil.d("登录信息 $_loginInfo");
    LogUtil.d("权限信息 $_userPermissions");
  }

}